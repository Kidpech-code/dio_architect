import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

// ─── Certificate Pin Model ────────────────────────────────────────────────────

/// Represents a single pinned host configuration.
///
/// Either supply the raw DER bytes of the public key, or the SHA-256
/// fingerprint string (with or without colons, case-insensitive).
///
/// ```dart
/// CertificatePin(
///   host: 'api.example.com',
///   sha256Fingerprints: ['AA:BB:CC:DD:...'],
/// )
/// ```
class CertificatePin {
  CertificatePin({
    required this.host,
    this.sha256Fingerprints = const [],
    this.trustedCertBytes,
  }) : assert(
         sha256Fingerprints.isNotEmpty || trustedCertBytes != null,
         'Provide at least one SHA-256 fingerprint or raw certificate bytes.',
       );

  /// The hostname to pin (e.g. `api.example.com`).
  final String host;

  /// SHA-256 fingerprints of the acceptable leaf certificates.
  ///
  /// Example format: `"AA:BB:CC:DD:EE:FF:..."` (colons optional).
  final List<String> sha256Fingerprints;

  /// Raw DER-encoded certificate bytes (loaded from your assets folder).
  /// Preferred when you bundle your own CA / certificate.
  final Uint8List? trustedCertBytes;
}

// ─── SSL Pinning Manager ──────────────────────────────────────────────────────

/// Configures a [Dio] instance with SSL/TLS certificate pinning.
///
/// Prevents Man-in-the-Middle (MITM) attacks by refusing any TLS handshake
/// whose server certificate is not in your explicit allow-list.
///
/// ### Usage
/// ```dart
/// final pins = [
///   CertificatePin(
///     host: 'api.example.com',
///     sha256Fingerprints: ['AA:BB:CC:DD:...'],
///   ),
/// ];
///
/// NetworkClientBuilder()
///   .baseUrl('https://api.example.com')
///   .setCertificatePins(pins)
///   .build();
/// ```
class SslPinningManager {
  const SslPinningManager(this._pins);

  final List<CertificatePin> _pins;

  /// Applies the pinning configuration to [dio]'s HTTP client adapter.
  ///
  /// Adds a custom [SecurityContext] / `badCertificateCallback` that rejects
  /// any certificate whose SHA-256 fingerprint is not in [_pins].
  void apply(Dio dio) {
    if (_pins.isEmpty) return;

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = _buildBadCertCallback();
        return client;
      },
    );
  }

  BadCertificateCallback _buildBadCertCallback() {
    return (X509Certificate cert, String host, int port) {
      final pin = _pinForHost(host);

      // No pin configured for this host → block by default (fail-closed policy).
      if (pin == null) return false;

      // ── Raw bytes check ──────────────────────────────────────────────────
      if (pin.trustedCertBytes != null) {
        return _certMatchesBytes(cert, pin.trustedCertBytes!);
      }

      // ── SHA-256 fingerprint check ────────────────────────────────────────
      final certFp = _sha256FingerprintOf(cert);
      final normalizedCert = _normalize(certFp);

      return pin.sha256Fingerprints.any(
        (fp) => _normalize(fp) == normalizedCert,
      );
    };
  }

  CertificatePin? _pinForHost(String host) {
    try {
      return _pins.firstWhere((p) => host.endsWith(p.host) || p.host == '*');
    } catch (_) {
      return null;
    }
  }

  bool _certMatchesBytes(X509Certificate cert, Uint8List expected) {
    final actual = cert.der;
    if (actual.length != expected.length) return false;
    for (var i = 0; i < actual.length; i++) {
      if (actual[i] != expected[i]) return false;
    }
    return true;
  }

  /// Returns the SHA-256 fingerprint of [cert]'s DER bytes,
  /// formatted as uppercase colon-separated hex (standard openssl format).
  ///
  /// e.g. `openssl x509 -fingerprint -sha256 -in cert.pem`
  String _sha256FingerprintOf(X509Certificate cert) {
    final digest = sha256.convert(cert.der);
    return digest.bytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join(':')
        .toUpperCase();
  }

  /// Strip colons/spaces and upper-case for consistent comparison.
  String _normalize(String fingerprint) =>
      fingerprint.replaceAll(':', '').replaceAll(' ', '').toUpperCase();
}

// ─── NetworkFailure mapper (ssl errors → unknown) ───────────────────────────

extension SslNetworkFailureX on DioException {
  bool get isSslError {
    return type == DioExceptionType.connectionError &&
        message?.toLowerCase().contains('certificate') == true;
  }
}
