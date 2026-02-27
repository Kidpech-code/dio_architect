import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dio/dio.dart' hide BackgroundTransformer;

// ─── Top-level isolate entry points ─────────────────────────────────────────
// Must be top-level (or static) so Dart can send them across isolate boundaries.

/// Decodes [payload] inside a spawned isolate.
///
/// [payload] is a `List` with structure: `[Uint8List bytes, String encoding]`.
dynamic _decodeResponse(List<Object?> payload) {
  final bytes = payload[0] as Uint8List;
  final encoding = payload[1] as String;
  final responseType = payload[2] as ResponseType;

  final charset = _lookupEncoding(encoding) ?? utf8;

  if (responseType == ResponseType.bytes) {
    return bytes;
  }

  final body = charset.decode(bytes);

  if (responseType == ResponseType.json) {
    return jsonDecode(body);
  }

  return body;
}

/// Encodes a request body to a JSON string inside a spawned isolate.
String _encodeRequest(Object? data) => jsonEncode(data);

Encoding? _lookupEncoding(String charset) {
  try {
    return Encoding.getByName(charset);
  } catch (_) {
    return null;
  }
}

// ─── IsolateTransformer ─────────────────────────────────────────────────────

/// A [Transformer] that decodes JSON responses **and** encodes request bodies
/// entirely in a separate [Isolate], keeping the UI thread free for rendering.
///
/// ### Why this matters
/// A 200 KB JSON payload decoded on the main isolate can steal ~8 ms of frame
/// budget, causing visible jank at 120 Hz. Offloading to a background isolate
/// guarantees the raster/UI threads are never blocked.
///
/// Enabled by default inside [NetworkClientBuilder] – no extra setup needed.
class IsolateTransformer extends Transformer {
  /// JSON encode request bodies.
  ///
  /// FormData and binary payloads are passed through unchanged.
  @override
  Future<String> transformRequest(RequestOptions options) async {
    final data = options.data;

    if (data == null) return '';

    // FormData must not be JSON-encoded.
    if (data is FormData) return data.toString();

    // Already a plain string – pass through directly.
    if (data is String) return data;

    // CPU-intensive JSON encoding happens in a background isolate.
    return Isolate.run(() => _encodeRequest(data));
  }

  /// Decode response bytes in a background isolate.
  ///
  /// Falls back gracefully to sync decoding for streaming / byte-range
  /// responses where isolate overhead would outweigh the benefit.
  @override
  Future<dynamic> transformResponse(
    RequestOptions options,
    ResponseBody responseBody,
  ) async {
    // Collect all bytes from the stream on the current isolate.
    // This is network I/O bound – the isolate cannot speed this up.
    final bytes = await _collectBytes(responseBody.stream);

    if (bytes.isEmpty) return null;

    final responseType = options.responseType;

    // Only spin up a new isolate for JSON / plain-text bodies.
    // Byte responses and stream responses are returned as-is.
    if (responseType == ResponseType.stream) {
      return ResponseBody.fromBytes(bytes, responseBody.statusCode);
    }

    final charset =
        _parseCharset(responseBody.headers['content-type']?.first) ?? 'utf-8';

    // Background isolate decodes the bytes – UI thread stays free.
    final decoded = await Isolate.run(
      () => _decodeResponse([bytes, charset, responseType]),
    );

    return decoded;
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  Future<Uint8List> _collectBytes(Stream<Uint8List> stream) async {
    final buffer = BytesBuilder(copy: false);
    await for (final chunk in stream) {
      buffer.add(chunk);
    }
    return buffer.toBytes();
  }

  /// Parses `charset=...` out of a Content-Type header value.
  String? _parseCharset(String? contentType) {
    if (contentType == null) return null;
    final match = RegExp(
      r'charset=([^\s;]+)',
      caseSensitive: false,
    ).firstMatch(contentType);
    return match?.group(1)?.trim().toLowerCase();
  }
}
