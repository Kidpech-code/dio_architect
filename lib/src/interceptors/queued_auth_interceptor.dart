import 'dart:async';

import 'package:dio/dio.dart';

import '../storage/token_storage_manager.dart';

/// Contract for the token refresh operation.
///
/// Implement this in your data/auth layer and inject it into [QueuedAuthInterceptor].
///
/// ```dart
/// class AuthRepository implements TokenRefreshDelegate {
///   @override
///   Future<TokenPair> refreshTokens(String refreshToken) async {
///     final response = await _remoteDataSource.refreshTokens(refreshToken);
///     return TokenPair(
///       access: response.accessToken,
///       refresh: response.refreshToken,
///     );
///   }
/// }
/// ```
abstract interface class TokenRefreshDelegate {
  /// Calls your backend's token-refresh endpoint.
  ///
  /// Throw any exception on failure; [QueuedAuthInterceptor] will handle it.
  Future<TokenPair> refreshTokens(String refreshToken);
}

/// Immutable value object returned by [TokenRefreshDelegate.refreshTokens].
class TokenPair {
  const TokenPair({required this.access, required this.refresh});

  final String access;
  final String refresh;
}

// ─── QueuedAuthInterceptor ────────────────────────────────────────────────────

/// A **concurrency-safe** Dio interceptor that handles HTTP 401 responses.
///
/// ### Problem
/// In production apps, multiple requests often fire concurrently. If the access
/// token expires, ALL of them receive 401 responses simultaneously. A naïve
/// implementation would trigger N parallel refresh calls, race-condition the
/// token storage, and potentially invalidate refresh tokens on the server.
///
/// ### Solution: Completer Queue
/// This interceptor uses a **queue of [Completer]s** as a lightweight mutex:
///
/// 1. The **first** 401 sets `_isRefreshing = true` and calls [TokenRefreshDelegate.refreshTokens].
/// 2. All **subsequent** 401s **pause** themselves by adding a `Completer` to [_waitQueue].
/// 3. When the refresh succeeds, ALL queued completers are resolved with the new token.
/// 4. Every paused request then retries with the fresh access token.
/// 5. On refresh failure, all queued requests are rejected.
///
/// ```
/// Request A ─┐
/// Request B ─┼─ All 401 ──► QueuedAuthInterceptor
/// Request C ─┘                │
///                             ├─ [A] starts refresh (acquires lock)
///                             ├─ [B] queues Completer → waits
///                             ├─ [C] queues Completer → waits
///                             │
///                         refresh OK  ──► complete B, C completers
///                             │
///                             ├─ [A] retries with new token
///                             ├─ [B] retries with new token
///                             └─ [C] retries with new token
/// ```
class QueuedAuthInterceptor extends Interceptor {
  QueuedAuthInterceptor({
    required TokenStorageManager storage,
    required TokenRefreshDelegate refreshDelegate,
    required Dio dio,
    this.tokenHeaderName = 'Authorization',
    this.tokenPrefix = 'Bearer',
    this.onRefreshFailed,
  }) : _storage = storage,
       _refreshDelegate = refreshDelegate,
       _dio = dio;

  final TokenStorageManager _storage;
  final TokenRefreshDelegate _refreshDelegate;
  final Dio _dio;

  /// The HTTP header used to send the access token. Defaults to `'Authorization'`.
  final String tokenHeaderName;

  /// The token scheme prefix. Defaults to `'Bearer'`.
  final String tokenPrefix;

  /// Optional callback invoked when a token refresh fails (e.g. to sign out).
  final void Function(Object error)? onRefreshFailed;

  // ── Mutex state ────────────────────────────────────────────────────────────
  bool _isRefreshing = false;
  final List<Completer<String?>> _waitQueue = [];

  // ─── onRequest: Attach access token ───────────────────────────────────────

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header injection for requests that opt out.
    if (options.extra['skipAuth'] == true) {
      handler.next(options);
      return;
    }

    final token = await _storage.readAccessToken();
    if (token != null) {
      options.headers[tokenHeaderName] = '$tokenPrefix $token';
    }

    handler.next(options);
  }

  // ─── onError: Handle 401 with queued refresh ──────────────────────────────

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    // Prevent retry loops – if this request was itself a refresh call, skip.
    if (err.requestOptions.extra['isRefreshRequest'] == true) {
      await _handleRefreshFailure(err);
      handler.reject(err);
      return;
    }

    if (!_isRefreshing) {
      // ── Acquire lock & perform refresh ──────────────────────────────────
      _isRefreshing = true;
      try {
        final refreshToken = await _storage.readRefreshToken();
        if (refreshToken == null) {
          await _handleRefreshFailure(err);
          handler.reject(err);
          return;
        }

        final tokenPair = await _refreshDelegate.refreshTokens(refreshToken);

        // Persist fresh tokens.
        await Future.wait([
          _storage.writeAccessToken(tokenPair.access),
          _storage.writeRefreshToken(tokenPair.refresh),
        ]);

        // Release all queued requests with the new token.
        _resolveQueue(tokenPair.access);

        // Retry the original request.
        final retried = await _retryRequest(
          err.requestOptions,
          tokenPair.access,
        );
        handler.resolve(retried);
      } catch (refreshError) {
        _rejectQueue(refreshError);
        await _handleRefreshFailure(refreshError);
        handler.reject(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      // ── Wait for the in-progress refresh ────────────────────────────────
      final completer = Completer<String?>();
      _waitQueue.add(completer);

      try {
        final newToken = await completer.future;
        final retried = await _retryRequest(err.requestOptions, newToken);
        handler.resolve(retried);
      } catch (_) {
        handler.reject(err);
      }
    }
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  Future<Response<dynamic>> _retryRequest(
    RequestOptions options,
    String? newToken,
  ) {
    final retryOptions = options.copyWith(
      headers: {
        ...options.headers,
        if (newToken != null) tokenHeaderName: '$tokenPrefix $newToken',
      },
    );
    // Mark as a retry so we don't loop on another 401.
    retryOptions.extra['isRetryRequest'] = true;
    return _dio.fetch<dynamic>(retryOptions);
  }

  void _resolveQueue(String? newToken) {
    for (final completer in _waitQueue) {
      if (!completer.isCompleted) completer.complete(newToken);
    }
    _waitQueue.clear();
  }

  void _rejectQueue(Object error) {
    for (final completer in _waitQueue) {
      if (!completer.isCompleted) completer.completeError(error);
    }
    _waitQueue.clear();
  }

  Future<void> _handleRefreshFailure(Object error) async {
    // Clear tokens so the app can redirect to login.
    await _storage.clearTokens();
    onRefreshFailed?.call(error);
  }
}
