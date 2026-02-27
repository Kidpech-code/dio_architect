import 'dart:math' as math;

import 'package:dio/dio.dart';

/// Configuration for the exponential backoff retry policy.
class RetryConfig {
  const RetryConfig({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 30),
    this.backoffMultiplier = 2.0,
    this.jitterFactor = 0.25,
    this.retryableStatusCodes = const {500, 502, 503, 504},
    this.respectRetryAfterHeader = true,
  });

  /// Maximum number of retry attempts (excluding the initial request).
  final int maxAttempts;

  /// Base delay for the first retry attempt.
  final Duration initialDelay;

  /// Upper bound for any single retry delay.
  final Duration maxDelay;

  /// The multiplier applied to the delay after each failed attempt.
  ///
  /// With `initialDelay = 500 ms` and `backoffMultiplier = 2.0`:
  /// - Attempt 1: 500 ms
  /// - Attempt 2: 1 000 ms
  /// - Attempt 3: 2 000 ms
  final double backoffMultiplier;

  /// Adds a random jitter of ±[jitterFactor] to prevent the
  /// [thundering-herd problem](https://en.wikipedia.org/wiki/Thundering_herd_problem).
  ///
  /// Set to `0.0` to disable jitter. Typical range: `0.1 – 0.5`.
  final double jitterFactor;

  /// Set of HTTP status codes that will trigger a retry.
  ///
  /// Defaults to `{500, 502, 503, 504}`.
  /// **Do NOT include 4xx codes** (except 429 with back-pressure logic).
  ///
  /// To also handle rate-limiting (429):
  /// ```dart
  /// RetryConfig(retryableStatusCodes: {429, 500, 502, 503, 504})
  /// ```
  final Set<int> retryableStatusCodes;

  /// When `true` (default), a **429 Too Many Requests** response will use the
  /// server-supplied `Retry-After` header value as the wait delay instead of
  /// the calculated exponential backoff.
  ///
  /// Example header: `Retry-After: 42` → waits 42 seconds before retrying.
  final bool respectRetryAfterHeader;
}

// ─── RetryInterceptor ─────────────────────────────────────────────────────────

/// Dio interceptor implementing **Exponential Backoff with Jitter** for
/// transient server errors and network timeouts.
///
/// ### Retry policy
/// | Condition                                 | Retry? |
/// |-------------------------------------------|--------|
/// | HTTP 5xx (configurable via [RetryConfig]) | ✅ Yes  |
/// | HTTP 429 (if in [RetryConfig.retryableStatusCodes]) | ✅ Yes (uses `Retry-After` header) |
/// | Connection timeout / receive timeout      | ✅ Yes  |
/// | HTTP 4xx (except 429 when configured)     | ❌ No   |
/// | HTTP 401 (handled by [QueuedAuthInterceptor]) | ❌ No |
/// | Request cancelled via [CancelToken]       | ❌ No   |
///
/// ### Usage
/// ```dart
/// NetworkClientBuilder()
///   .enableRetry(
///     config: RetryConfig(
///       maxAttempts: 4,
///       initialDelay: Duration(seconds: 1),
///       jitterFactor: 0.3,
///       retryableStatusCodes: {429, 500, 502, 503, 504},
///       respectRetryAfterHeader: true,
///     ),
///   )
///   .build();
/// ```
class RetryInterceptor extends Interceptor {
  RetryInterceptor({required Dio dio, RetryConfig? config})
    : _dio = dio,
      _config = config ?? const RetryConfig();

  final Dio _dio;
  final RetryConfig _config;
  final _random = math.Random();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra['_retryAttempt'] as int?) ?? 0;

    if (!_shouldRetry(err, attempt)) {
      handler.next(err);
      return;
    }

    final delay = _resolveDelay(err, attempt);

    // Non-blocking wait – does not block the Dart event loop or UI thread.
    await Future<void>.delayed(delay);

    // Increment the attempt counter in request extras.
    options.extra['_retryAttempt'] = attempt + 1;

    try {
      final response = await _dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (retryErr) {
      handler.next(retryErr);
    }
  }

  // ─── Decision logic ────────────────────────────────────────────────────────

  bool _shouldRetry(DioException err, int currentAttempt) {
    if (currentAttempt >= _config.maxAttempts) return false;

    // Never retry a cancelled request.
    if (err.type == DioExceptionType.cancel) return false;

    // Retry on network-level errors (no response).
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    // Retry on configured HTTP error codes.
    final statusCode = err.response?.statusCode;
    if (statusCode != null &&
        _config.retryableStatusCodes.contains(statusCode)) {
      return true;
    }

    return false;
  }

  // ─── Delay resolution ──────────────────────────────────────────────────────

  /// Returns the delay to wait before the next attempt.
  ///
  /// For **429** responses: uses the `Retry-After` header value when
  /// [RetryConfig.respectRetryAfterHeader] is enabled (capped at [RetryConfig.maxDelay]).
  ///
  /// For everything else: standard exponential backoff + full jitter.
  Duration _resolveDelay(DioException err, int attempt) {
    final statusCode = err.response?.statusCode;

    if (statusCode == 429 && _config.respectRetryAfterHeader) {
      final retryAfterValue =
          err.response?.headers.value('Retry-After') ??
          err.response?.headers.value('retry-after');

      if (retryAfterValue != null) {
        final seconds = int.tryParse(retryAfterValue.trim());
        if (seconds != null && seconds > 0) {
          final capped = Duration(
            seconds: seconds,
          ).clamp(Duration.zero, _config.maxDelay);
          return capped;
        }
      }
    }

    return _calculateBackoffDelay(attempt);
  }

  /// Exponential backoff with full jitter.
  ///
  /// Formula:
  /// ```
  /// base   = min(initialDelay × backoffMultiplier^attempt, maxDelay)
  /// jitter = random(±jitterFactor × base)
  /// delay  = clamp(base + jitter, 0, maxDelay)
  /// ```
  Duration _calculateBackoffDelay(int attempt) {
    final base =
        _config.initialDelay.inMilliseconds *
        math.pow(_config.backoffMultiplier, attempt);
    final cappedBase = base
        .clamp(0, _config.maxDelay.inMilliseconds)
        .toDouble();

    final jitter = _config.jitterFactor > 0
        ? (_random.nextDouble() * 2 - 1) * _config.jitterFactor * cappedBase
        : 0.0;

    final ms = (cappedBase + jitter)
        .clamp(0, _config.maxDelay.inMilliseconds)
        .round();

    return Duration(milliseconds: ms);
  }
}

// ─── Duration clamp extension ─────────────────────────────────────────────────

extension on Duration {
  Duration clamp(Duration min, Duration max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }
}
