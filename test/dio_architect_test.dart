import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_architect/dio_architect.dart';
import 'package:flutter_test/flutter_test.dart';

// ─── Fake token storage ──────────────────────────────────────────────────────

class FakeTokenStorage implements TokenStorageManager {
  String? _access;
  String? _refresh;
  bool cleared = false;

  @override
  Future<String?> readAccessToken() async => _access;
  @override
  Future<void> writeAccessToken(String t) async => _access = t;
  @override
  Future<String?> readRefreshToken() async => _refresh;
  @override
  Future<void> writeRefreshToken(String t) async => _refresh = t;
  @override
  Future<void> clearTokens() async {
    _access = null;
    _refresh = null;
    cleared = true;
  }
}

// ─── Fake refresh delegate ───────────────────────────────────────────────────

class FakeRefreshDelegate implements TokenRefreshDelegate {
  int callCount = 0;
  bool shouldFail = false;

  @override
  Future<TokenPair> refreshTokens(String refreshToken) async {
    callCount++;
    if (shouldFail) throw Exception('refresh failed');
    return const TokenPair(access: 'new-access', refresh: 'new-refresh');
  }
}

// ─── Tests ───────────────────────────────────────────────────────────────────

void main() {
  // ── NetworkClientBuilder ─────────────────────────────────────────────────

  group('NetworkClientBuilder', () {
    test('builds a NetworkClient', () {
      final client =
          NetworkClientBuilder().baseUrl('https://api.example.com/').build();
      expect(client, isA<NetworkClient>());
    });

    test('sets baseUrl correctly', () {
      final client =
          NetworkClientBuilder().baseUrl('https://api.example.com/').build();
      expect(client.rawDio.options.baseUrl, equals('https://api.example.com/'));
    });

    test('sets connect / receive timeouts', () {
      final client = NetworkClientBuilder()
          .baseUrl('https://api.example.com/')
          .connectTimeout(const Duration(seconds: 5))
          .receiveTimeout(const Duration(seconds: 20))
          .build();
      expect(client.rawDio.options.connectTimeout, const Duration(seconds: 5));
      expect(client.rawDio.options.receiveTimeout, const Duration(seconds: 20));
    });

    test('uses IsolateTransformer by default', () {
      final client =
          NetworkClientBuilder().baseUrl('https://api.example.com/').build();
      expect(client.rawDio.transformer, isA<IsolateTransformer>());
    });

    test('adds RetryInterceptor when retry enabled', () {
      final client = NetworkClientBuilder()
          .baseUrl('https://api.example.com/')
          .enableRetry()
          .build();
      expect(
        client.rawDio.interceptors.any((i) => i is RetryInterceptor),
        isTrue,
      );
    });

    test('no RetryInterceptor when retry disabled', () {
      final client = NetworkClientBuilder()
          .baseUrl('https://api.example.com/')
          .disableRetry()
          .build();
      expect(
        client.rawDio.interceptors.any((i) => i is RetryInterceptor),
        isFalse,
      );
    });

    test('adds QueuedAuthInterceptor when auth configured', () {
      final client = NetworkClientBuilder()
          .baseUrl('https://api.example.com/')
          .auth(storage: FakeTokenStorage(), delegate: FakeRefreshDelegate())
          .build();
      expect(
        client.rawDio.interceptors.any((i) => i is QueuedAuthInterceptor),
        isTrue,
      );
    });

    test('merges custom default headers', () {
      final client = NetworkClientBuilder()
          .baseUrl('https://api.example.com/')
          .defaultHeaders({'X-App-Version': '2.0.0'}).build();
      expect(client.rawDio.options.headers['X-App-Version'], equals('2.0.0'));
      expect(
        client.rawDio.options.headers['Accept'],
        equals('application/json'),
      );
    });
  });

  // ── NetworkFailure ────────────────────────────────────────────────────────

  group('NetworkFailure', () {
    test('noConnection resolves correctly in when()', () {
      const failure = NetworkFailure.noConnection();
      final result = failure.when(
        noConnection: () => 'no_conn',
        timeout: () => 'TO',
        unauthorized: (_) => 'U',
        badRequest: (_) => 'BR',
        serverError: (_, __) => 'SE',
        unknown: (_, __, ___) => 'UK',
      );
      expect(result, equals('no_conn'));
    });

    test('serverError carries statusCode and message', () {
      const failure = NetworkFailure.serverError(
        statusCode: 503,
        message: 'busy',
      );
      failure.whenOrNull(
        serverError: (code, msg) {
          expect(code, equals(503));
          expect(msg, equals('busy'));
        },
      );
    });

    test('unauthorized carries message', () {
      const failure = NetworkFailure.unauthorized(message: 'Token expired');
      failure.whenOrNull(
        unauthorized: (msg) => expect(msg, equals('Token expired')),
      );
    });

    test('badRequest carries message', () {
      const failure = NetworkFailure.badRequest(message: 'email is invalid');
      failure.whenOrNull(
        badRequest: (msg) => expect(msg, equals('email is invalid')),
      );
    });

    test('maybeWhen returns orElse for unmatched case', () {
      const failure = NetworkFailure.unknown(message: 'oops');
      final result = failure.maybeWhen(
        noConnection: () => 'offline',
        orElse: () => 'other',
      );
      expect(result, equals('other'));
    });

    test('all failure types are distinct', () {
      const failures = [
        NetworkFailure.noConnection(),
        NetworkFailure.timeout(),
        NetworkFailure.unknown(),
      ];
      final types = failures.map((f) => f.runtimeType).toSet();
      expect(types.length, equals(3));
    });
  });

  // ── IsolateTransformer ────────────────────────────────────────────────────

  group('IsolateTransformer', () {
    late IsolateTransformer transformer;
    setUp(() => transformer = IsolateTransformer());

    test('encodes Map as JSON', () async {
      final options = RequestOptions(path: '/', data: {'key': 'value'});
      final encoded = await transformer.transformRequest(options);
      expect(encoded, equals('{"key":"value"}'));
    });

    test('passes String through unchanged', () async {
      final options = RequestOptions(path: '/', data: 'raw-body');
      expect(await transformer.transformRequest(options), equals('raw-body'));
    });

    test('returns empty string for null data', () async {
      final options = RequestOptions(path: '/');
      expect(await transformer.transformRequest(options), isEmpty);
    });

    test('decodes JSON response bytes', () async {
      const json = '{"id":1,"name":"Alice"}';
      final bytes = Uint8List.fromList(json.codeUnits);
      final options = RequestOptions(
        path: '/',
        responseType: ResponseType.json,
      );
      final body = ResponseBody(
        Stream.value(bytes),
        200,
        headers: {
          'content-type': ['application/json; charset=utf-8'],
        },
      );
      final result = await transformer.transformResponse(options, body);
      expect(result, isA<Map>());
      expect((result as Map)['name'], equals('Alice'));
    });

    test('returns plain string for ResponseType.plain', () async {
      const text = 'hello world';
      final bytes = Uint8List.fromList(text.codeUnits);
      final options = RequestOptions(
        path: '/',
        responseType: ResponseType.plain,
      );
      final body = ResponseBody(Stream.value(bytes), 200);
      final result = await transformer.transformResponse(options, body);
      expect(result, equals(text));
    });

    test('returns null for empty body', () async {
      final options = RequestOptions(
        path: '/',
        responseType: ResponseType.json,
      );
      final body = ResponseBody(Stream.value(Uint8List(0)), 204);
      final result = await transformer.transformResponse(options, body);
      expect(result, isNull);
    });
  });

  // ── RetryConfig ───────────────────────────────────────────────────────────

  group('RetryConfig', () {
    test('defaults are sane', () {
      const c = RetryConfig();
      expect(c.maxAttempts, equals(3));
      expect(c.retryableStatusCodes, containsAll([500, 502, 503, 504]));
      expect(c.retryableStatusCodes, isNot(contains(401)));
      expect(c.retryableStatusCodes, isNot(contains(404)));
    });

    test('custom values override defaults', () {
      const c = RetryConfig(maxAttempts: 5, retryableStatusCodes: {500});
      expect(c.maxAttempts, equals(5));
      expect(c.retryableStatusCodes, equals({500}));
    });
  });

  // ── QueuedAuthInterceptor ─────────────────────────────────────────────────

  group('QueuedAuthInterceptor', () {
    /// Helper: runs [fn] in a guarded zone so that the zone errors emitted by
    /// `ErrorInterceptorHandler.reject()` / `.next()` (which use Completer
    /// internally and have no listener when called in isolation) don't bubble
    /// up to the test framework as unhandled async errors.
    Future<void> runInterceptorCall(Future<void> Function() fn) {
      final done = Completer<void>();
      runZonedGuarded(
        () async {
          await fn();
          if (!done.isCompleted) done.complete();
        },
        (_, __) {
          if (!done.isCompleted) done.complete();
        },
      );
      return done.future;
    }

    test('clears tokens on refresh failure', () async {
      final storage = FakeTokenStorage()
        .._access = 'old'
        .._refresh = 'rt';
      final delegate = FakeRefreshDelegate()..shouldFail = true;
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
      final interceptor = QueuedAuthInterceptor(
        storage: storage,
        refreshDelegate: delegate,
        dio: dio,
      );
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      );

      await runInterceptorCall(
        () => interceptor.onError(err, ErrorInterceptorHandler()),
      );
      expect(storage.cleared, isTrue);
    });

    test('non-401 errors pass through untouched', () async {
      final storage = FakeTokenStorage();
      final delegate = FakeRefreshDelegate();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
      final interceptor = QueuedAuthInterceptor(
        storage: storage,
        refreshDelegate: delegate,
        dio: dio,
      );
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
        type: DioExceptionType.badResponse,
      );

      await runInterceptorCall(
        () => interceptor.onError(err, ErrorInterceptorHandler()),
      );
      // If interceptor tried to refresh on a 500, callCount would be > 0.
      expect(delegate.callCount, equals(0));
    });
  });

  // ── CertificatePin ────────────────────────────────────────────────────────

  group('CertificatePin', () {
    test('accepts SHA-256 fingerprints', () {
      final pin = CertificatePin(
        host: 'api.example.com',
        sha256Fingerprints: ['AA:BB:CC'],
      );
      expect(pin.host, equals('api.example.com'));
      expect(pin.sha256Fingerprints, equals(['AA:BB:CC']));
    });

    test('accepts raw certificate bytes', () {
      final bytes = Uint8List.fromList([1, 2, 3]);
      final pin = CertificatePin(
        host: 'api.example.com',
        trustedCertBytes: bytes,
      );
      expect(pin.trustedCertBytes, isNotNull);
    });
  });
}
