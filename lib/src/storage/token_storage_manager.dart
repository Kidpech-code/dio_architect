/// Contract for secure token persistence.
///
/// Implement this interface to plug in any storage backend
/// (e.g. `flutter_secure_storage`, `hive`, `shared_preferences`).
///
/// ```dart
/// class SecureTokenStorage implements TokenStorageManager {
///   final FlutterSecureStorage _storage;
///   SecureTokenStorage(this._storage);
///
///   @override
///   Future<String?> readAccessToken() => _storage.read(key: 'access_token');
///
///   @override
///   Future<void> writeAccessToken(String token) =>
///       _storage.write(key: 'access_token', value: token);
///
///   @override
///   Future<String?> readRefreshToken() => _storage.read(key: 'refresh_token');
///
///   @override
///   Future<void> writeRefreshToken(String token) =>
///       _storage.write(key: 'refresh_token', value: token);
///
///   @override
///   Future<void> clearTokens() => _storage.deleteAll();
/// }
/// ```
abstract interface class TokenStorageManager {
  /// Returns the current short-lived access token, or `null` if absent.
  Future<String?> readAccessToken();

  /// Persists a new access token.
  Future<void> writeAccessToken(String token);

  /// Returns the long-lived refresh token, or `null` if absent.
  Future<String?> readRefreshToken();

  /// Persists a new refresh token.
  Future<void> writeRefreshToken(String token);

  /// Wipes all tokens – call on logout or after a fatal 401.
  Future<void> clearTokens();
}
