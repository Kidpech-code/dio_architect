import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_failure.freezed.dart';

/// Exhaustive sealed union of every network-layer failure.
///
/// The compiler enforces that every case is handled in `.when()` — there
/// is no way for an unhandled error to silently slip through to the UI.
///
/// ```dart
/// result.fold(
///   (failure) => failure.when(
///     noConnection: () => showOfflineBanner(),
///     timeout:      () => showRetryDialog(),
///     unauthorized: (_) => router.go('/login'),
///     badRequest:   (msg) => showValidationError(msg),
///     serverError:  (code, _) => Sentry.captureMessage('$code'),
///     unknown:      (_, __, ___) => showGenericError(),
///   ),
///   (data) => state = Success(data),
/// );
/// ```
@freezed
sealed class NetworkFailure with _$NetworkFailure {
  /// Device has no active internet connection (no DNS / socket error).
  const factory NetworkFailure.noConnection() = NoConnection;

  /// Request exceeded the connect / send / receive timeout.
  const factory NetworkFailure.timeout() = _Timeout;

  /// Server returned HTTP 401 – token is missing, expired, or invalid.
  ///
  /// After `QueuedAuthInterceptor` has already attempted (and failed) to
  /// refresh the token, this failure bubbles up to the UI so the app can
  /// redirect to the login screen.
  const factory NetworkFailure.unauthorized({String? message}) = _Unauthorized;

  /// Server returned a 4xx error indicating the *request itself* is invalid
  /// (e.g. validation failure, missing required fields).
  ///
  /// The [message] is extracted directly from the API's error body so it
  /// can be displayed verbatim to the user.
  const factory NetworkFailure.badRequest({required String message}) =
      _BadRequest;

  /// Server returned a 5xx error or an unexpected non-success HTTP code
  /// (e.g. 429 Too Many Requests after all retries are exhausted).
  const factory NetworkFailure.serverError({
    required int statusCode,
    String? message,
  }) = _ServerError;

  /// Any other unclassified failure (parsing error, unexpected exception, etc.).
  const factory NetworkFailure.unknown({
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) = _Unknown;
}
