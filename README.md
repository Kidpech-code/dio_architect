<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.
-->

# dio_architect

Enterprise-grade, highly customizable, zero-jank, and ultra-resilient Flutter HTTP package wrapping [Dio](https://pub.dev/packages/dio).

[![pub package](https://img.shields.io/pub/v/dio_architect.svg)](https://pub.dev/packages/dio_architect)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Features

- **Functional error handling** — every HTTP method returns `Future<Either<NetworkFailure, T>>`, no more try/catch scattered across your codebase.
- **Concurrency-safe JWT refresh** — `QueuedAuthInterceptor` queues all simultaneous 401 responses and refreshes the token exactly once.
- **Exponential backoff retry** — `RetryInterceptor` with full jitter, configurable status codes, and `Retry-After` header support.
- **Zero-jank JSON decoding** — `IsolateTransformer` offloads JSON encoding/decoding to a background isolate.
- **SSL certificate pinning** — SHA-256 fingerprint pinning compatible with `openssl x509 -fingerprint -sha256`.
- **HTTP/2 support** — opt-in via `enableHttp2()`.
- **Fluent builder API** — configure everything with a chainable `NetworkClientBuilder`.
- **Pluggable token storage** — implement `TokenStorageManager` with any backend (`flutter_secure_storage`, Hive, etc.).

## Getting started

Add `dio_architect` to your `pubspec.yaml`:

```yaml
dependencies:
  dio_architect: ^0.1.0
```

Then run:

```sh
flutter pub get
```

## Usage

### Minimal setup

```dart
import 'package:dio_architect/dio_architect.dart';

final client = NetworkClientBuilder()
  .baseUrl('https://api.example.com/v1/')
  .build();

final result = await client.get<User>(
  '/users/1',
  decoder: (data) => User.fromJson(data as Map<String, dynamic>),
);

result.fold(
  (failure) => failure.when(
    noConnection: () => showOfflineBanner(),
    timeout: () => showRetryDialog(),
    unauthorized: (_) => router.go('/login'),
    badRequest: (msg) => showSnackBar(msg),
    serverError: (code, _) => reportToSentry(code),
    unknown: (_, __, ___) => showGenericError(),
  ),
  (user) => setState(() => _user = user),
);
```

### Full production setup

```dart
final client = NetworkClientBuilder()
  .baseUrl('https://api.example.com/v1/')
  .connectTimeout(const Duration(seconds: 10))
  .receiveTimeout(const Duration(seconds: 30))
  .auth(
    storage: SecureTokenStorage(),        // implements TokenStorageManager
    delegate: AuthRepository(),           // implements TokenRefreshDelegate
    onRefreshFailed: (_) => signOut(),
  )
  .enableRetry(
    config: RetryConfig(
      maxAttempts: 3,
      retryableStatusCodes: {429, 500, 502, 503, 504},
      respectRetryAfterHeader: true,
    ),
  )
  .setCertificatePins([
    CertificatePin(
      host: 'api.example.com',
      sha256Fingerprints: ['AA:BB:CC:DD:...'],  // from: openssl x509 -fingerprint -sha256
    ),
  ])
  .enableLogging(level: LogLevel.body)    // gate with kDebugMode in production
  .defaultHeaders({'X-App-Version': '1.0.0'})
  .build();
```

### Token storage

Implement `TokenStorageManager` with any secure storage backend:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage implements TokenStorageManager {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @override
  Future<String?> readAccessToken() => _storage.read(key: 'access_token');
  @override
  Future<void> writeAccessToken(String token) =>
      _storage.write(key: 'access_token', value: token);
  @override
  Future<String?> readRefreshToken() => _storage.read(key: 'refresh_token');
  @override
  Future<void> writeRefreshToken(String token) =>
      _storage.write(key: 'refresh_token', value: token);
  @override
  Future<void> clearTokens() => _storage.deleteAll();
}
```

### Token refresh delegate

```dart
class AuthRepository implements TokenRefreshDelegate {
  @override
  Future<TokenPair> refreshTokens(String refreshToken) async {
    final response = await _remoteDataSource.refreshTokens(refreshToken);
    return TokenPair(
      access: response.accessToken,
      refresh: response.refreshToken,
    );
  }
}
```

### Opting out of auth on a single request

```dart
final result = await client.get<Map<String, dynamic>>(
  '/public/health',
  options: skipAuth(),
  decoder: (data) => data as Map<String, dynamic>,
);
```

### File upload

```dart
final formData = FormData.fromMap({
  'file': await MultipartFile.fromFile(filePath, filename: 'avatar.jpg'),
});

final result = await client.upload<UploadResponse>(
  '/users/me/photo',
  formData: formData,
  decoder: (data) => UploadResponse.fromJson(data as Map<String, dynamic>),
  onSendProgress: (sent, total) => setState(() => _progress = sent / total),
);
```

## Additional information

- **Example**: See the [`example/`](example/) folder for a complete, runnable example covering all HTTP methods and error scenarios.
- **Issues**: Please file bugs and feature requests on the [GitHub issue tracker](https://github.com/Kidpech-code/dio_architect/issues).
- **Contributing**: Pull requests are welcome. Open an issue first for major changes.
