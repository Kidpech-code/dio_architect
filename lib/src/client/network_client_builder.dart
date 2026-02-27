import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';

import '../core/background_transformer.dart' show IsolateTransformer;
import '../core/ssl_pinning_manager.dart';
import '../interceptors/queued_auth_interceptor.dart';
import '../interceptors/retry_interceptor.dart';
import '../storage/token_storage_manager.dart';
import 'network_client.dart';

/// Fluent builder for constructing a fully configured [NetworkClient].
///
/// All setters return `this` for chaining. Call [build] at the end.
///
/// ### Minimal setup
/// ```dart
/// final client = NetworkClientBuilder()
///   .baseUrl('https://api.example.com/v1/')
///   .build();
/// ```
///
/// ### Full production setup
/// ```dart
/// final client = NetworkClientBuilder()
///   .baseUrl('https://api.example.com/v1/')
///   .connectTimeout(const Duration(seconds: 10))
///   .receiveTimeout(const Duration(seconds: 30))
///   .auth(
///     storage: secureTokenStorage,
///     delegate: authRepository,
///     onRefreshFailed: (_) => getIt<AuthBloc>().add(SignedOut()),
///   )
///   .enableRetry(config: RetryConfig(maxAttempts: 3))
///   .enableLogging(level: LogLevel.body)
///   .setCertificatePins([
///     CertificatePin(
///       host: 'api.example.com',
///       sha256Fingerprints: ['AA:BB:CC:...'],
///     ),
///   ])
///   .enableHttp2()
///   .addInterceptor(MyCustomInterceptor())
///   .defaultHeaders({'X-App-Version': '3.1.0'})
///   .build();
/// ```
class NetworkClientBuilder {
  String? _baseUrl;
  Duration _connectTimeout = const Duration(seconds: 15);
  Duration _sendTimeout = const Duration(seconds: 15);
  Duration _receiveTimeout = const Duration(seconds: 30);

  // Auth
  TokenStorageManager? _tokenStorage;
  TokenRefreshDelegate? _refreshDelegate;
  void Function(Object)? _onRefreshFailed;
  String _tokenHeaderName = 'Authorization';
  String _tokenPrefix = 'Bearer';

  // Retry
  bool _retryEnabled = true;
  RetryConfig _retryConfig = const RetryConfig();

  // Logging
  bool _loggingEnabled = false;
  LogLevel _logLevel = LogLevel.headers;

  // SSL Pinning
  List<CertificatePin> _pins = const [];

  // HTTP/2
  bool _http2Enabled = false;
  Duration _http2IdleConnectionTimeout = const Duration(minutes: 1);

  // Custom
  final List<Interceptor> _extraInterceptors = [];
  Map<String, dynamic> _defaultHeaders = {};

  // ─── Setters ──────────────────────────────────────────────────────────────

  /// Sets the base URL for all requests.
  /// Trailing `/` is recommended to allow relative path resolution.
  NetworkClientBuilder baseUrl(String url) {
    _baseUrl = url;
    return this;
  }

  /// Sets the TCP connection timeout. Default: 15 seconds.
  NetworkClientBuilder connectTimeout(Duration duration) {
    _connectTimeout = duration;
    return this;
  }

  /// Sets the request send timeout. Default: 15 seconds.
  NetworkClientBuilder sendTimeout(Duration duration) {
    _sendTimeout = duration;
    return this;
  }

  /// Sets the response receive timeout. Default: 30 seconds.
  NetworkClientBuilder receiveTimeout(Duration duration) {
    _receiveTimeout = duration;
    return this;
  }

  /// Enables the [QueuedAuthInterceptor] with the provided [storage] and
  /// [delegate] for automatic token injection and concurrency-safe refresh.
  ///
  /// - [onRefreshFailed]: Called when refresh fails (e.g. to sign the user out).
  NetworkClientBuilder auth({
    required TokenStorageManager storage,
    required TokenRefreshDelegate delegate,
    void Function(Object error)? onRefreshFailed,
    String tokenHeaderName = 'Authorization',
    String tokenPrefix = 'Bearer',
  }) {
    _tokenStorage = storage;
    _refreshDelegate = delegate;
    _onRefreshFailed = onRefreshFailed;
    _tokenHeaderName = tokenHeaderName;
    _tokenPrefix = tokenPrefix;
    return this;
  }

  /// Enables automatic retry with exponential backoff for 5xx / timeout errors.
  /// Retry is **on by default** with [RetryConfig] defaults.
  NetworkClientBuilder enableRetry({RetryConfig? config}) {
    _retryEnabled = true;
    if (config != null) _retryConfig = config;
    return this;
  }

  /// Disables the retry interceptor entirely.
  NetworkClientBuilder disableRetry() {
    _retryEnabled = false;
    return this;
  }

  /// Enables the [LogInterceptor] for debugging.
  ///
  /// **Do not use in production builds.** Gate with `kDebugMode`.
  NetworkClientBuilder enableLogging({LogLevel level = LogLevel.headers}) {
    _loggingEnabled = true;
    _logLevel = level;
    return this;
  }

  /// Configures SSL/TLS certificate pinning to prevent MITM attacks.
  NetworkClientBuilder setCertificatePins(List<CertificatePin> pins) {
    _pins = pins;
    return this;
  }

  /// Swaps the default HTTP/1.1 adapter with [Http2Adapter] from
  /// `dio_http2_adapter` for HTTP/2 multiplexing.
  ///
  /// Ideal when connecting to Go / gRPC-like microservices with HTTP/2 enabled.
  NetworkClientBuilder enableHttp2({
    Duration idleConnectionTimeout = const Duration(minutes: 1),
  }) {
    _http2Enabled = true;
    _http2IdleConnectionTimeout = idleConnectionTimeout;
    return this;
  }

  /// Appends a custom [Interceptor] to the chain.
  ///
  /// Custom interceptors are applied **after** the built-in ones.
  NetworkClientBuilder addInterceptor(Interceptor interceptor) {
    _extraInterceptors.add(interceptor);
    return this;
  }

  /// Sets headers that are included in every request.
  ///
  /// ```dart
  /// .defaultHeaders({
  ///   'X-App-Platform': 'flutter',
  ///   'Accept-Language': 'en',
  /// })
  /// ```
  NetworkClientBuilder defaultHeaders(Map<String, dynamic> headers) {
    _defaultHeaders = headers;
    return this;
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  /// Constructs and returns the fully configured [NetworkClient].
  NetworkClient build() {
    final options = BaseOptions(
      baseUrl: _baseUrl ?? '',
      connectTimeout: _connectTimeout,
      sendTimeout: _sendTimeout,
      receiveTimeout: _receiveTimeout,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        ..._defaultHeaders,
      },
    );

    final dio = Dio(options);

    // ── 1. Background transformer (always enabled) ────────────────────────
    dio.transformer = IsolateTransformer();

    // ── 2. SSL / TLS pinning ──────────────────────────────────────────────
    if (_pins.isNotEmpty) {
      SslPinningManager(_pins).apply(dio);
    }

    // ── 3. HTTP/2 adapter (optional) ──────────────────────────────────────
    if (_http2Enabled && _pins.isEmpty) {
      // Only swap if we haven't already set a custom IOHttpClientAdapter for pinning.
      dio.httpClientAdapter = Http2Adapter(
        ConnectionManager(
          idleTimeout: _http2IdleConnectionTimeout,
          onClientCreate: (uri, config) {
            config.onBadCertificate = (_) => false; // stay strict
          },
        ),
      );
    }

    // ── 4. Retry interceptor ──────────────────────────────────────────────
    if (_retryEnabled) {
      dio.interceptors.add(RetryInterceptor(dio: dio, config: _retryConfig));
    }

    // ── 5. Auth interceptor (requires storage + delegate) ─────────────────
    if (_tokenStorage != null && _refreshDelegate != null) {
      dio.interceptors.add(
        QueuedAuthInterceptor(
          storage: _tokenStorage!,
          refreshDelegate: _refreshDelegate!,
          dio: dio,
          tokenHeaderName: _tokenHeaderName,
          tokenPrefix: _tokenPrefix,
          onRefreshFailed: _onRefreshFailed,
        ),
      );
    }

    // ── 6. Logging (should be last to log final request/response) ─────────
    if (_loggingEnabled) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: _logLevel.index >= LogLevel.headers.index,
          requestBody: _logLevel == LogLevel.body,
          responseHeader: _logLevel.index >= LogLevel.headers.index,
          responseBody: _logLevel == LogLevel.body,
          error: true,
        ),
      );
    }

    // ── 7. Extra user-defined interceptors ────────────────────────────────
    for (final interceptor in _extraInterceptors) {
      dio.interceptors.add(interceptor);
    }

    return NetworkClient(dio);
  }
}

// ─── Log Level Enum ──────────────────────────────────────────────────────────

enum LogLevel {
  /// Only log request method, URL and response status.
  minimal,

  /// Log request and response headers.
  headers,

  /// Log full request/response bodies.
  body,
}
