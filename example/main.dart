// ignore_for_file: avoid_print, unawaited_futures
//
// example/main.dart — dio_architect enterprise pattern demo
//
// Demonstrates:
//   • Plain-Dart models (no code generation needed for examples)
//   • AuthRepository backed by POST /auth/login with zero try-catch
//   • TokenRefreshDelegate calling POST /auth/refresh
//   • QueuedAuthInterceptor + RetryInterceptor wired together
//   • Exhaustive failure.when(…) covering all 6 NetworkFailure cases
//   • ProductRepository with cursor pagination
//   • Simulated offline / bad-host failure handling
//
// Base URL: https://freeapi.kidpech.app
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_architect/dio_architect.dart';

// ════════════════════════════════════════════════════════════════════════════
// Models
// ════════════════════════════════════════════════════════════════════════════

class UserProfile {
  final String id;
  final String username;
  final String email;

  const UserProfile({
    required this.id,
    required this.username,
    required this.email,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as String? ?? '',
        username: json['username'] as String? ?? '',
        email: json['email'] as String? ?? '',
      );

  @override
  String toString() => 'UserProfile(id: $id, username: $username)';
}

class AuthLoginResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final UserProfile? user;

  const AuthLoginResponse({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType = 'Bearer',
    this.user,
  });

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) {
    // Support both flat and nested { "data": { ... } } envelopes.
    final d = (json['data'] as Map<String, dynamic>?) ?? json;
    final userJson = d['user'] as Map<String, dynamic>?;
    return AuthLoginResponse(
      accessToken: d['access_token'] as String,
      refreshToken: d['refresh_token'] as String,
      tokenType: d['token_type'] as String? ?? 'Bearer',
      user: userJson != null ? UserProfile.fromJson(userJson) : null,
    );
  }
}

class Product {
  final String id;
  final String name;
  final num price;
  final String? description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String,
        name: json['name'] as String,
        price: json['price'] as num,
        description: json['description'] as String?,
      );

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}

// ════════════════════════════════════════════════════════════════════════════
// Token storage  (in-memory — swap for flutter_secure_storage in production)
// ════════════════════════════════════════════════════════════════════════════

class InMemoryTokenStorage implements TokenStorageManager {
  String? _access;
  String? _refresh;

  @override
  Future<String?> readAccessToken() async => _access;

  @override
  Future<void> writeAccessToken(String token) async => _access = token;

  @override
  Future<String?> readRefreshToken() async => _refresh;

  @override
  Future<void> writeRefreshToken(String token) async => _refresh = token;

  @override
  Future<void> clearTokens() async {
    _access = null;
    _refresh = null;
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Token Refresh Delegate  —  calls POST /auth/refresh
// ════════════════════════════════════════════════════════════════════════════

/// Performs a silent token refresh using [POST /auth/refresh].
///
/// The [QueuedAuthInterceptor] calls this automatically whenever it receives
/// a 401 response.  Concurrent 401s are serialised — only one refresh flight
/// is in-flight at any given time.
class AppTokenRefreshDelegate implements TokenRefreshDelegate {
  final NetworkClient _unauthClient;

  const AppTokenRefreshDelegate(this._unauthClient);

  @override
  Future<TokenPair> refreshTokens(String refreshToken) async {
    final result = await _unauthClient.post<Map<String, dynamic>>(
      '/auth/refresh',
      decoder: (d) => d as Map<String, dynamic>,
      data: {'refresh_token': refreshToken},
    );

    // Use fold so the refresh path is also try-catch-free.
    return result.fold(
      (failure) => throw DioException(
        requestOptions: RequestOptions(path: '/auth/refresh'),
        message: failure.when(
          noConnection: () => 'No internet during token refresh',
          timeout: () => 'Token refresh timed out',
          unauthorized: (msg) => msg ?? 'Refresh token rejected',
          badRequest: (msg) => 'Refresh request invalid: $msg',
          serverError: (code, msg) => 'Server error $code during refresh',
          unknown: (msg, _, __) => msg ?? 'Unknown refresh error',
        ),
      ),
      (data) {
        final d = (data['data'] as Map<String, dynamic>?) ?? data;
        return TokenPair(
          access: d['access_token'] as String,
          refresh: d['refresh_token'] as String,
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// AuthRepository  —  zero try-catch, pure Either
// ════════════════════════════════════════════════════════════════════════════

class AuthRepository {
  final NetworkClient _client;

  const AuthRepository(this._client);

  /// Authenticates the user.
  ///
  /// Returns [AuthLoginResponse] on success or a typed [NetworkFailure] —
  /// no exceptions are ever thrown.
  Future<Either<NetworkFailure, AuthLoginResponse>> login({
    required String username,
    required String password,
  }) async {
    final result = await _client.post<Map<String, dynamic>>(
      '/auth/login',
      decoder: (d) => d as Map<String, dynamic>,
      data: {'username': username, 'password': password},
    );

    return result.flatMap((data) {
      try {
        return right(AuthLoginResponse.fromJson(data));
      } catch (e, st) {
        return left(
          NetworkFailure.unknown(
            message: 'Failed to parse login response',
            error: e,
            stackTrace: st,
          ),
        );
      }
    });
  }
}

// ════════════════════════════════════════════════════════════════════════════
// ProductRepository  —  cursor-paginated list
// ════════════════════════════════════════════════════════════════════════════

typedef ProductPage = ({List<Product> items, String? nextCursor, bool hasMore});

class ProductRepository {
  final NetworkClient _client;

  const ProductRepository(this._client);

  Future<Either<NetworkFailure, ProductPage>> listProducts({
    String? cursor,
    int limit = 20,
  }) async {
    final result = await _client.get<Map<String, dynamic>>(
      '/api/v1/products',
      decoder: (d) => d as Map<String, dynamic>,
      queryParameters: {if (cursor != null) 'cursor': cursor, 'limit': limit},
    );

    return result.flatMap((envelope) {
      try {
        final rawList = envelope['data'] as List;
        final items =
            rawList.cast<Map<String, dynamic>>().map(Product.fromJson).toList();
        final meta = envelope['meta'] as Map?;
        final hasMore = (meta?['has_more'] as bool?) ?? false;
        final nextCursor = hasMore ? (meta?['next_cursor'] as String?) : null;
        return right((items: items, nextCursor: nextCursor, hasMore: hasMore));
      } catch (e, st) {
        return left(
          NetworkFailure.unknown(
            message: 'Failed to parse product list',
            error: e,
            stackTrace: st,
          ),
        );
      }
    });
  }
}

// ════════════════════════════════════════════════════════════════════════════
// HomeController  —  exhaustive failure.when(), zero try-catch
// ════════════════════════════════════════════════════════════════════════════

class HomeController {
  final AuthRepository _auth;
  final ProductRepository _products;
  final TokenStorageManager _storage;

  HomeController({
    required AuthRepository auth,
    required ProductRepository products,
    required TokenStorageManager storage,
  })  : _auth = auth,
        _products = products,
        _storage = storage;

  // ── State ─────────────────────────────────────────────────────────────────

  // ignore: unused_field
  AuthLoginResponse? _session;
  final List<Product> _items = [];
  String? _nextCursor;
  bool _hasMore = true;

  // ── Login ─────────────────────────────────────────────────────────────────

  /// Logs in and updates internal session state.
  ///
  /// All six [NetworkFailure] variants are handled explicitly — the compiler
  /// will flag any missing case if the union ever changes.
  Future<void> login({
    required String username,
    required String password,
  }) async {
    final result = await _auth.login(username: username, password: password);

    result.fold(
      // ── Failure branch ────────────────────────────────────────────────────
      (failure) {
        final userMessage = failure.when(
          noConnection: () =>
              '📶 No internet connection. Check your network and try again.',
          timeout: () =>
              '⏱️ Request timed out. The server may be busy — retry in a moment.',
          unauthorized: (msg) =>
              '🔑 Invalid credentials: ${msg ?? 'Please check username/password.'}',
          badRequest: (msg) => '⚠️ Validation error: $msg',
          serverError: (code, msg) =>
              '🔥 Server error $code: ${msg ?? 'Please try again later.'}',
          unknown: (msg, _, __) =>
              '❓ Unexpected error: ${msg ?? 'Something went wrong.'}',
        );
        _showToast('[Login failed] $userMessage');
      },
      // ── Success branch ────────────────────────────────────────────────────
      (auth) {
        _session = auth;
        // InMemoryTokenStorage is synchronous under the hood;
        // unawaited is safe here.  Swap for flutter_secure_storage
        // in production and await within a TaskEither chain.
        unawaited(_storage.writeAccessToken(auth.accessToken));
        unawaited(_storage.writeRefreshToken(auth.refreshToken));
        _showToast(
          '[Login OK] Welcome ${auth.user?.username ?? 'user'}! '
          'Token: ${auth.accessToken.substring(0, 20)}…',
        );
      },
    );
  }

  // ── Products ──────────────────────────────────────────────────────────────

  /// Loads the next page of products and appends them to [_items].
  Future<void> loadNextPage() async {
    if (!_hasMore) {
      _showToast('[Products] No more pages to load.');
      return;
    }

    final result = await _products.listProducts(cursor: _nextCursor);

    result.fold(
      (failure) {
        final userMessage = failure.when(
          noConnection: () => 'You appear to be offline.',
          timeout: () => 'Request timed out — tap retry.',
          unauthorized: (_) => 'Session expired — please log in again.',
          badRequest: (msg) => 'Invalid request: $msg',
          serverError: (code, _) => 'Server error $code — try again shortly.',
          unknown: (msg, _, __) => msg ?? 'Failed to load products.',
        );
        _showToast('[Products error] $userMessage');
      },
      (page) {
        _items.addAll(page.items);
        _nextCursor = page.nextCursor;
        _hasMore = page.hasMore;
        _showToast(
          '[Products] +${page.items.length} items loaded '
          '(total: ${_items.length}, hasMore: ${page.hasMore})',
        );
        for (final p in page.items.take(3)) {
          _showToast('  › $p');
        }
        if (page.items.length > 3) {
          _showToast('  … and ${page.items.length - 3} more');
        }
      },
    );
  }

  void _showToast(String message) => print(message);
}

// ════════════════════════════════════════════════════════════════════════════
// Dependency wiring
// ════════════════════════════════════════════════════════════════════════════

HomeController buildApp() {
  const baseUrl = 'https://freeapi.kidpech.app';
  final storage = InMemoryTokenStorage();

  // ── Unauthenticated client ────────────────────────────────────────────────
  // Used by AuthRepository (login) and AppTokenRefreshDelegate (refresh).
  // Must NOT have the QueuedAuthInterceptor to avoid circular 401 loops.
  final unauthClient = NetworkClientBuilder()
      .baseUrl(baseUrl)
      .connectTimeout(const Duration(seconds: 10))
      .receiveTimeout(const Duration(seconds: 15))
      .build();

  final refreshDelegate = AppTokenRefreshDelegate(unauthClient);

  // ── Authenticated client ──────────────────────────────────────────────────
  // Automatically attaches Bearer tokens and serialises concurrent refreshes.
  final authClient = NetworkClientBuilder()
      .baseUrl(baseUrl)
      .connectTimeout(const Duration(seconds: 10))
      .receiveTimeout(const Duration(seconds: 15))
      .auth(storage: storage, delegate: refreshDelegate)
      .enableRetry(
        config: const RetryConfig(
          maxAttempts: 3,
          retryableStatusCodes: {500, 502, 503, 504, 429},
          respectRetryAfterHeader: true,
        ),
      )
      .build();

  return HomeController(
    auth: AuthRepository(unauthClient),
    products: ProductRepository(authClient),
    storage: storage,
  );
}

// ════════════════════════════════════════════════════════════════════════════
// Entry point
// ════════════════════════════════════════════════════════════════════════════

Future<void> main() async {
  final controller = buildApp();

  // ── Step 1: Login via POST /auth/login ────────────────────────────────────
  print('\n══════════════════════════════════════════════════════');
  print(' Step 1 · POST /auth/login');
  print('══════════════════════════════════════════════════════');
  await controller.login(username: 'alice', password: 's3cr3t');

  // ── Step 2: Fetch products (requires Bearer token) ────────────────────────
  print('\n══════════════════════════════════════════════════════');
  print(' Step 2 · GET /api/v1/products  (first page)');
  print('══════════════════════════════════════════════════════');
  await controller.loadNextPage();

  // ── Step 3: Simulate a server error / unreachable host ───────────────────
  print('\n══════════════════════════════════════════════════════');
  print(' Step 3 · Simulate unreachable host (noConnection)');
  print('══════════════════════════════════════════════════════');
  final offlineClient = NetworkClientBuilder()
      .baseUrl('https://does-not-exist.kidpech.app')
      .connectTimeout(const Duration(seconds: 3))
      .build();

  final offlineRepo = ProductRepository(offlineClient);
  final offlineResult = await offlineRepo.listProducts();
  offlineResult.fold((failure) {
    final label = failure.when(
      noConnection: () => 'noConnection ✓ (expected)',
      timeout: () => 'timeout',
      unauthorized: (_) => 'unauthorized',
      badRequest: (_) => 'badRequest',
      serverError: (code, _) => 'serverError($code)',
      unknown: (msg, _, __) => 'unknown: $msg',
    );
    print('[Offline simulation] Caught failure → $label');
  }, (_) => print('Unexpected success on unreachable host'));

  print('\nDone.');
}
