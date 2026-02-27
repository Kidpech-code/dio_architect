import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../error/network_failure.dart';

// ─── Request Option Helpers ───────────────────────────────────────────────────

/// Opt a single request out of auth-header injection.
Options skipAuth([Options? options]) => (options ?? Options()).copyWith(
      extra: {...?options?.extra, 'skipAuth': true},
    );

// ─── NetworkClient ────────────────────────────────────────────────────────────

/// The main network facade.
///
/// Every method returns `Future<Either<NetworkFailure, T>>`:
/// - **Left**  → a typed [NetworkFailure] (never throws).
/// - **Right** → the decoded success value.
///
/// ### Usage
/// ```dart
/// final result = await client.get<User>(
///   '/users/42',
///   decoder: (data) => User.fromJson(data as Map<String, dynamic>),
/// );
///
/// result.fold(
///   (failure) => failure.when(
///     unauthorized: (_) => context.go('/login'),
///     noConnection: () => showOfflineBanner(),
///     badRequest: (msg) => showValidationSnackBar(msg),
///     serverError: (code, _) => showErrorSnackBar(),
///     timeout: () => showRetryDialog(),
///     unknown: (_, __, ___) => showGenericError(),
///   ),
///   (user) => state = UserLoaded(user),
/// );
/// ```
///
/// Construct via [NetworkClientBuilder] – never directly.
class NetworkClient {
  const NetworkClient(this._dio);

  final Dio _dio;

  /// Exposes the underlying [Dio] instance for advanced use cases.
  Dio get rawDio => _dio;

  // ─── GET ──────────────────────────────────────────────────────────────────

  Future<Either<NetworkFailure, T>> get<T>(
    String path, {
    required T Function(dynamic data) decoder,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) =>
      _execute<T>(
        () => _dio.get<dynamic>(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ),
        decoder: decoder,
      );

  // ─── POST ─────────────────────────────────────────────────────────────────

  Future<Either<NetworkFailure, T>> post<T>(
    String path, {
    required T Function(dynamic data) decoder,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _execute<T>(
        () => _dio.post<dynamic>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
        decoder: decoder,
      );

  // ─── PUT ──────────────────────────────────────────────────────────────────

  Future<Either<NetworkFailure, T>> put<T>(
    String path, {
    required T Function(dynamic data) decoder,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _execute<T>(
        () => _dio.put<dynamic>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
        decoder: decoder,
      );

  // ─── PATCH ────────────────────────────────────────────────────────────────

  Future<Either<NetworkFailure, T>> patch<T>(
    String path, {
    required T Function(dynamic data) decoder,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _execute<T>(
        () => _dio.patch<dynamic>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
        decoder: decoder,
      );

  // ─── DELETE ───────────────────────────────────────────────────────────────

  Future<Either<NetworkFailure, T>> delete<T>(
    String path, {
    required T Function(dynamic data) decoder,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _execute<T>(
        () => _dio.delete<dynamic>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        decoder: decoder,
      );

  // ─── DELETE (no response body) ────────────────────────────────────────────

  Future<Either<NetworkFailure, Unit>> deleteVoid(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _execute<Unit>(
        () => _dio.delete<dynamic>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        decoder: (_) => unit,
      );

  // ─── MULTIPART / FORM-DATA ────────────────────────────────────────────────

  /// Sends a `multipart/form-data` request.
  ///
  /// ```dart
  /// final formData = FormData.fromMap({
  ///   'title': 'My Profile Photo',
  ///   'file': await MultipartFile.fromFile(
  ///     filePath,
  ///     filename: 'avatar.jpg',
  ///     contentType: MediaType('image', 'jpeg'),
  ///   ),
  /// });
  ///
  /// final result = await client.upload<UploadResponse>(
  ///   '/users/me/photo',
  ///   formData: formData,
  ///   decoder: (data) => UploadResponse.fromJson(data as Map<String, dynamic>),
  ///   onSendProgress: (sent, total) => setState(() => _progress = sent / total),
  /// );
  /// ```
  Future<Either<NetworkFailure, T>> upload<T>(
    String path, {
    required FormData formData,
    required T Function(dynamic data) decoder,
    String method = 'POST',
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) =>
      _execute<T>(
        () => _dio.request<dynamic>(
          path,
          data: formData,
          queryParameters: queryParameters,
          options: Options(method: method, contentType: 'multipart/form-data'),
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
        decoder: decoder,
      );

  // ─── Core execute wrapper ─────────────────────────────────────────────────

  Future<Either<NetworkFailure, T>> _execute<T>(
    Future<Response<dynamic>> Function() request, {
    required T Function(dynamic data) decoder,
  }) async {
    try {
      final response = await request();
      final decoded = decoder(response.data);
      return Right(decoded);
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } on SocketException {
      return const Left(NetworkFailure.noConnection());
    } catch (e, st) {
      return Left(
        NetworkFailure.unknown(message: e.toString(), error: e, stackTrace: st),
      );
    }
  }

  // ─── DioException → NetworkFailure mapper ────────────────────────────────

  NetworkFailure _mapDioException(DioException e) {
    // Connection-level errors – no HTTP response available.
    if (e.type == DioExceptionType.connectionError) {
      return const NetworkFailure.noConnection();
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const NetworkFailure.timeout();
    }

    // Cancelled requests and other non-response errors fall through to unknown.
    if (e.type == DioExceptionType.cancel) {
      return NetworkFailure.unknown(message: 'Request was cancelled', error: e);
    }

    // HTTP-level errors.
    final statusCode = e.response?.statusCode;
    if (statusCode != null) {
      // freeapi.kidpech.app error shape: { "success": false, "error": "..." }
      final message = _parseErrorMessage(e.response?.data);
      return switch (statusCode) {
        400 => NetworkFailure.badRequest(message: message ?? 'Bad request'),
        401 => NetworkFailure.unauthorized(message: message),
        >= 500 => NetworkFailure.serverError(
            statusCode: statusCode,
            message: message,
          ),
        _ => NetworkFailure.serverError(
            statusCode: statusCode,
            message: message ?? 'HTTP $statusCode',
          ),
      };
    }

    return NetworkFailure.unknown(
      message: e.message,
      error: e,
      stackTrace: e.stackTrace,
    );
  }

  String? _parseErrorMessage(dynamic data) {
    if (data == null) return null;
    if (data is Map) {
      // Common API error shapes: { "error": "..." } | { "message": "..." } | { "detail": "..." }
      return (data['error'] ?? data['message'] ?? data['detail'])?.toString();
    }
    if (data is String) return data;
    return null;
  }
}
