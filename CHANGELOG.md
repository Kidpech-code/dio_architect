## 0.1.1

- Upgraded `freezed_annotation` to `^3.1.0` and `freezed` to `^3.2.5` — resolves pub.dev dependency scoring (0/10 → 10/10).
- Updated `@freezed` class declarations to use `abstract class` as required by freezed 3.x.
- Added MIT License file.
- Fixed SSL pinning SHA-256 computation using the `crypto` package.

## 0.1.0

- Initial release.
- `NetworkClientBuilder` — fluent builder for fully-configured Dio clients.
- `NetworkClient` — typed HTTP facade with `Either<NetworkFailure, T>` return values for every method (GET, POST, PUT, PATCH, DELETE, upload).
- `QueuedAuthInterceptor` — concurrency-safe JWT refresh with Completer queue; prevents N parallel refresh calls on simultaneous 401 responses.
- `RetryInterceptor` — exponential backoff with full jitter, configurable retryable status codes, and `Retry-After` header support for 429.
- `IsolateTransformer` — decodes JSON responses and encodes request bodies in a background isolate, keeping the UI thread free.
- `SslPinningManager` — SHA-256 certificate pinning (compatible with `openssl x509 -fingerprint -sha256`) to prevent MITM attacks.
- `NetworkFailure` — exhaustive sealed union of all error cases (`noConnection`, `timeout`, `unauthorized`, `badRequest`, `serverError`, `unknown`).
- `TokenStorageManager` — abstract interface for pluggable token storage backends.
- `BaseResponse<T>` / `BaseListResponse<T>` — generic Freezed envelope models for standard REST responses.
