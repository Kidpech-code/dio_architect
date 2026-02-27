// ignore_for_file: dangling_library_doc_comments

/// `dio_architect` – Enterprise-grade Flutter HTTP package.
///
/// ### Quick start
/// ```dart
/// import 'package:dio_architect/dio_architect.dart';
///
/// final client = NetworkClientBuilder()
///   .baseUrl('https://api.example.com/v1/')
///   .enableLogging()
///   .build();
///
/// final result = await client.get<User>(
///   '/users/1',
///   decoder: (data) => User.fromJson(data as Map<String, dynamic>),
/// );
/// ```

// Error domain
export 'src/error/network_failure.dart';

// Storage abstraction
export 'src/storage/token_storage_manager.dart';

// Core infrastructure
export 'src/core/background_transformer.dart';
export 'src/core/ssl_pinning_manager.dart';

// Interceptors
export 'src/interceptors/queued_auth_interceptor.dart';
export 'src/interceptors/retry_interceptor.dart';

// Models
export 'src/models/base_response.dart';

// Client
export 'src/client/network_client.dart';
export 'src/client/network_client_builder.dart';

// Re-export commonly needed Dio types so consumers don't need a direct
// dependency on `dio` for everyday types.
export 'package:dio/dio.dart'
    show
        CancelToken,
        FormData,
        MultipartFile,
        Options,
        ProgressCallback,
        Response,
        DioException,
        DioExceptionType;

// Re-export fpdart Either so consumers get typed functional results.
export 'package:fpdart/fpdart.dart'
    show Either, Left, Right, Unit, unit, right, left;
