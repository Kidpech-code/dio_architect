// ignore_for_file: avoid_print, dangling_library_doc_comments

/// ============================================================
///  dio_architect × freeapi.kidpech.app — Production Example
///  ============================================================
///
///  API: https://freeapi.kidpech.app
///  Docs: https://freeapi.kidpech.app/docs.html#auth
///
///  Auth model (stateless JWT):
///    GET /auth/token?user_id=`<any_id>`  → { "token": "eyJ..." }
///    • Token is valid for 72 h
///    • Protected endpoints live under /api/v1/* (Bearer header)
///    • "Refresh" = re-request a new token with the same user_id
///
///  Endpoints covered in this file:
///    ✅  GET  /health             (no auth, health check)
///    ✅  GET  /auth/token         (token generation)
///    ✅  GET  /api/v1/products    (cursor pagination)
///    ✅  POST /api/v1/products    (create)
///    ✅  GET  /api/v1/products/:id
///    ✅  PUT  /api/v1/products/:id
///    ✅  DELETE /api/v1/products/:id
///    ✅  POST /api/v1/products/bulk
///    ✅  GET  /api/v1/weather/locations  (no auth)
///    ✅  Error sandbox  (400 / 401 / 429 / 500)
/// ============================================================

import 'package:dio_architect/dio_architect.dart';

// ═════════════════════════════════════════════════════════════
//  SECTION 1 — Domain Models
// ═════════════════════════════════════════════════════════════

// ──────────────────────────────────────────────────────────────
//  Token
// ──────────────────────────────────────────────────────────────

/// Response from `GET /auth/token?user_id=xxx`
///
/// ```json
/// { "token": "eyJhbGci...", "user_id": "sandbox-user-1", "expires_in": 259200 }
/// ```
class TokenResponse {
  const TokenResponse({
    required this.token,
    required this.userId,
    required this.expiresIn,
  });

  final String token;
  final String userId;
  final int expiresIn; // seconds

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
    token: json['token'] as String,
    userId: json['user_id'] as String,
    expiresIn: (json['expires_in'] as num?)?.toInt() ?? 259200,
  );

  @override
  String toString() =>
      'TokenResponse(userId: $userId, expiresIn: ${expiresIn}s)';
}

// ──────────────────────────────────────────────────────────────
//  Product
// ──────────────────────────────────────────────────────────────

/// A product stored in the API's Redis namespace.
///
/// Fields adapt to what `/api/v1/products` actually returns.
/// Extend as needed based on your create payload.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.category,
    this.stock = 0,
    this.createdAt,
  });

  final String id;
  final String name;
  final double price;
  final String? description;
  final String? category;
  final int stock;
  final String? createdAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as String,
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    description: json['description'] as String?,
    category: json['category'] as String?,
    stock: (json['stock'] as num?)?.toInt() ?? 0,
    createdAt: json['created_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    if (description != null) 'description': description,
    if (category != null) 'category': category,
    'stock': stock,
  };

  @override
  String toString() =>
      'Product(id: $id, name: $name, price: $price, stock: $stock)';
}

// ──────────────────────────────────────────────────────────────
//  Cursor Pagination Meta
//  (shape returned by freeapi.kidpech.app list endpoints)
// ──────────────────────────────────────────────────────────────

/// Meta block from paginated list responses:
/// ```json
/// { "count": 20, "has_more": true, "next_cursor": "1771389457123456789" }
/// ```
class CursorMeta {
  const CursorMeta({
    required this.count,
    required this.hasMore,
    this.nextCursor,
  });

  final int count;
  final bool hasMore;

  /// Pass this value as `?cursor=` in the next request.
  final String? nextCursor;

  factory CursorMeta.fromJson(Map<String, dynamic> json) => CursorMeta(
    count: (json['count'] as num?)?.toInt() ?? 0,
    hasMore: json['has_more'] as bool? ?? false,
    nextCursor: json['next_cursor'] as String?,
  );

  @override
  String toString() =>
      'CursorMeta(count: $count, hasMore: $hasMore, nextCursor: $nextCursor)';
}

/// Cursor-paginated API envelope for list endpoints.
class CursorPage<T> {
  const CursorPage({required this.data, required this.meta});

  final List<T> data;
  final CursorMeta meta;

  factory CursorPage.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) => CursorPage(
    data: (json['data'] as List)
        .map((e) => fromJsonT(e as Map<String, dynamic>))
        .toList(),
    meta: CursorMeta.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

// ──────────────────────────────────────────────────────────────
//  Weather (no-auth endpoint)
// ──────────────────────────────────────────────────────────────

class WeatherLocation {
  const WeatherLocation({required this.code, required this.nameTh});

  final String code;
  final String nameTh;

  factory WeatherLocation.fromJson(Map<String, dynamic> json) =>
      WeatherLocation(
        code: json['code'] as String,
        nameTh: json['name_th'] as String? ?? json['code'] as String,
      );

  @override
  String toString() => 'WeatherLocation(code: $code, nameTh: $nameTh)';
}

// ═════════════════════════════════════════════════════════════
//  SECTION 2 — Token Storage (implements TokenStorageManager)
// ═════════════════════════════════════════════════════════════

/// In-memory token storage for this example.
///
/// In production replace the Map with `flutter_secure_storage`:
/// ```dart
/// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
///
/// class SecureTokenStorage implements TokenStorageManager {
///   final _storage = const FlutterSecureStorage(
///     aOptions: AndroidOptions(encryptedSharedPreferences: true),
///   );
///
///   @override
///   Future<String?> readAccessToken() => _storage.read(key: 'access_token');
///
///   @override
///   Future<void> writeAccessToken(String token) =>
///       _storage.write(key: 'access_token', value: token);
///
///   // freeapi.kidpech.app has no OAuth2 refresh token.
///   // We store the user_id as the "refresh token" so the delegate
///   // can call GET /auth/token?user_id=<userId> to mint a new token.
///   @override
///   Future<String?> readRefreshToken() => _storage.read(key: 'user_id');
///
///   @override
///   Future<void> writeRefreshToken(String userId) =>
///       _storage.write(key: 'user_id', value: userId);
///
///   @override
///   Future<void> clearTokens() async {
///     await _storage.delete(key: 'access_token');
///     await _storage.delete(key: 'user_id');
///   }
/// }
/// ```
class InMemoryTokenStorage implements TokenStorageManager {
  final _store = <String, String>{};

  @override
  Future<String?> readAccessToken() async => _store['access_token'];

  @override
  Future<void> writeAccessToken(String token) async {
    _store['access_token'] = token;
    print('[Storage] ✅ access token saved');
  }

  /// For freeapi.kidpech.app, the "refresh token" is the user_id.
  @override
  Future<String?> readRefreshToken() async => _store['user_id'];

  @override
  Future<void> writeRefreshToken(String userId) async {
    _store['user_id'] = userId;
  }

  @override
  Future<void> clearTokens() async {
    _store.clear();
    print('[Storage] 🔐 tokens cleared — user signed out');
  }
}

// ═════════════════════════════════════════════════════════════
//  SECTION 3 — Token Refresh Delegate
// ═════════════════════════════════════════════════════════════

/// Handles token re-generation for freeapi.kidpech.app.
///
/// The API has no OAuth2 `refresh_token` endpoint.
/// Strategy: store the `user_id` as the "refresh token" and re-call
/// `GET /auth/token?user_id=<user_id>` whenever a 401 is intercepted.
///
/// `QueuedAuthInterceptor` calls this exactly ONCE even when N requests
/// fail simultaneously — all others wait in the Completer queue.
class KidpechTokenDelegate implements TokenRefreshDelegate {
  KidpechTokenDelegate(this._anonClient);

  final NetworkClient _anonClient;

  @override
  Future<TokenPair> refreshTokens(String userId) async {
    print('[Auth] 🔄 re-minting token for user_id: $userId');

    final result = await _anonClient.get<TokenResponse>(
      '/auth/token',
      queryParameters: {'user_id': userId},
      // This is a public endpoint – skip auth header injection.
      options: skipAuth(),
      decoder: (data) => TokenResponse.fromJson(data as Map<String, dynamic>),
    );

    return result.fold(
      (failure) => throw Exception('Token refresh failed: $failure'),
      (resp) => TokenPair(
        access: resp.token,
        // Carry the user_id forward so future refreshes still work.
        refresh: resp.userId,
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  SECTION 4 — Client Assembly
// ═════════════════════════════════════════════════════════════

const _baseUrl = 'https://freeapi.kidpech.app';

/// Your sandbox user_id — change to any string you like.
/// All data is isolated per user_id (strict namespace in Redis).
const _myUserId = 'sandbox-flutter-architect';

final _storage = InMemoryTokenStorage();

/// Anonymous client — only used to call /auth/token (no auth interceptor).
/// We also use this for public weather endpoints.
final anonClient = NetworkClientBuilder()
    .baseUrl(_baseUrl)
    .connectTimeout(const Duration(seconds: 10))
    .receiveTimeout(const Duration(seconds: 20))
    .enableRetry(
      config: RetryConfig(
        maxAttempts: 3,
        initialDelay: const Duration(milliseconds: 500),
        jitterFactor: 0.25,
        // 429 = rate-limit from the API — respect the Retry-After header.
        retryableStatusCodes: {429, 500, 502, 503, 504},
        respectRetryAfterHeader: true,
      ),
    )
    .enableLogging(level: LogLevel.minimal)
    .build();

/// Authenticated client — all /api/v1/* calls go through here.
/// The QueuedAuthInterceptor:
///   1. Injects "Authorization: Bearer `<token>`" automatically.
///   2. Intercepts 401 → calls KidpechTokenDelegate.refreshTokens() ONCE
///      (even when N requests fail simultaneously).
///   3. Retries all queued requests with the new token.
final apiClient = NetworkClientBuilder()
    .baseUrl(_baseUrl)
    .connectTimeout(const Duration(seconds: 10))
    .receiveTimeout(const Duration(seconds: 20))
    .auth(
      storage: _storage,
      delegate: KidpechTokenDelegate(anonClient),
      onRefreshFailed: (error) {
        // In a real app, navigate to the login screen here.
        print('[Auth] ❌ Token refresh failed → sign out: $error');
      },
    )
    .enableRetry(
      config: RetryConfig(
        maxAttempts: 3,
        initialDelay: const Duration(milliseconds: 500),
        jitterFactor: 0.25,
        retryableStatusCodes: {429, 500, 502, 503, 504},
        respectRetryAfterHeader: true,
      ),
    )
    .enableLogging(level: LogLevel.body)
    .build();

// ═════════════════════════════════════════════════════════════
//  SECTION 5 — Main
// ═════════════════════════════════════════════════════════════

Future<void> main() async {
  // ── Step 1: obtain a JWT token from the API ──────────────────
  print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print(' freeapi.kidpech.app × dio_architect — Production Demo');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  await _stepAuthenticate();

  // ── Step 2: CRUD operations ──────────────────────────────────
  await _stepHealthCheck();
  await _stepListProducts();
  final newId = await _stepCreateProduct();
  if (newId != null) {
    await _stepGetProduct(newId);
    await _stepUpdateProduct(newId);
    await _stepDeleteProduct(newId);
  }
  await _stepBulkCreate();

  // ── Step 3: Public weather endpoint (no auth) ────────────────
  await _stepWeatherLocations();

  // ── Step 4: Error sandbox – see NetworkFailure in action ─────
  await _stepErrorSandbox();
}

// ═════════════════════════════════════════════════════════════
//  SECTION 6 — Individual Steps
// ═════════════════════════════════════════════════════════════

// ── Authenticate ─────────────────────────────────────────────

Future<void> _stepAuthenticate() async {
  print('=== Step 1: GET /auth/token?user_id=$_myUserId ===');

  final result = await anonClient.get<TokenResponse>(
    '/auth/token',
    queryParameters: {'user_id': _myUserId},
    decoder: (data) => TokenResponse.fromJson(data as Map<String, dynamic>),
  );

  result.fold((failure) => print('❌ Could not obtain token: $failure'), (
    resp,
  ) async {
    print('✅ Token obtained: ${resp.token.substring(0, 20)}...');
    print('   Expires in: ${resp.expiresIn ~/ 3600}h');

    // Persist token + user_id so the QueuedAuthInterceptor can:
    //   • Inject "Authorization: Bearer <token>" on every request.
    //   • Re-mint the token when 401 is received (using user_id).
    await _storage.writeAccessToken(resp.token);
    await _storage.writeRefreshToken(resp.userId);
  });
}

// ── Health check ──────────────────────────────────────────────

Future<void> _stepHealthCheck() async {
  print('\n=== GET /health (no auth) ===');

  // Public endpoint – skip auth header with skipAuth() helper.
  final result = await anonClient.get<Map<String, dynamic>>(
    '/health',
    options: skipAuth(),
    decoder: (data) => data as Map<String, dynamic>,
  );

  result.fold(
    (f) => print('❌ $f'),
    (body) => print('✅ Server status: ${body['status']}'),
  );
}

// ── List products (cursor pagination) ────────────────────────

Future<void> _stepListProducts() async {
  print('\n=== GET /api/v1/products (first page, limit 5) ===');

  final result = await apiClient.get<CursorPage<Product>>(
    '/api/v1/products',
    queryParameters: {'limit': 5},
    decoder: (data) =>
        CursorPage.fromJson(data as Map<String, dynamic>, Product.fromJson),
  );

  result.fold((f) => print('❌ $f'), (page) {
    print('✅ Got ${page.data.length} products');
    for (final p in page.data) {
      print('   • $p');
    }
    if (page.meta.hasMore) {
      print('   ↪ next cursor: ${page.meta.nextCursor}');
      print('   (use ?cursor=${page.meta.nextCursor} to fetch next page)');
    } else {
      print('   ↪ no more pages');
    }
  });
}

// ── Create product ────────────────────────────────────────────

Future<String?> _stepCreateProduct() async {
  print('\n=== POST /api/v1/products ===');

  final payload = Product(
    id: '', // server assigns
    name: 'Flutter Enterprise Kit',
    price: 2990.00,
    description: 'Built with dio_architect — zero-jank HTTP layer',
    category: 'Software',
    stock: 9999,
  );

  final result = await apiClient.post<Product>(
    '/api/v1/products',
    data: payload.toJson(),
    decoder: (data) => Product.fromJson(data as Map<String, dynamic>),
  );

  return result.fold(
    (f) {
      print('❌ Create failed: $f');
      return null;
    },
    (product) {
      print('✅ Created: $product');
      return product.id;
    },
  );
}

// ── Get single product ────────────────────────────────────────

Future<void> _stepGetProduct(String id) async {
  print('\n=== GET /api/v1/products/$id ===');

  final result = await apiClient.get<Product>(
    '/api/v1/products/$id',
    decoder: (data) => Product.fromJson(data as Map<String, dynamic>),
  );

  result.fold((f) => print('❌ $f'), (p) => print('✅ $p'));
}

// ── Update product ────────────────────────────────────────────

Future<void> _stepUpdateProduct(String id) async {
  print('\n=== PUT /api/v1/products/$id ===');

  final result = await apiClient.put<Product>(
    '/api/v1/products/$id',
    data: {'name': 'Flutter Enterprise Kit (updated)', 'price': 3490.00},
    decoder: (data) => Product.fromJson(data as Map<String, dynamic>),
  );

  result.fold((f) => print('❌ $f'), (p) => print('✅ Updated: $p'));
}

// ── Delete product ────────────────────────────────────────────

Future<void> _stepDeleteProduct(String id) async {
  print('\n=== DELETE /api/v1/products/$id ===');

  final result = await apiClient.deleteVoid('/api/v1/products/$id');

  result.fold((f) => print('❌ $f'), (_) => print('✅ Deleted successfully'));
}

// ── Bulk create ───────────────────────────────────────────────

Future<void> _stepBulkCreate() async {
  print('\n=== POST /api/v1/products/bulk (5 items via Redis Pipeline) ===');

  final items = List.generate(
    5,
    (i) => {
      'name': 'Bulk Item #${i + 1}',
      'price': 99.0 + i,
      'stock': 10 + i,
      'category': 'Sample',
    },
  );

  final result = await apiClient.post<List<Product>>(
    '/api/v1/products/bulk',
    data: items,
    decoder: (data) => (data as List)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  result.fold((f) => print('❌ Bulk create failed: $f'), (products) {
    print('✅ Bulk inserted ${products.length} products:');
    for (final p in products) {
      print('   • $p');
    }
  });
}

// ── Weather (public, no auth) ─────────────────────────────────

Future<void> _stepWeatherLocations() async {
  print('\n=== GET /api/v1/weather/locations (no auth, TMD cache) ===');

  // Weather endpoints don't require a token — use skipAuth().
  final result = await anonClient.get<List<WeatherLocation>>(
    '/api/v1/weather/locations',
    options: skipAuth(),
    decoder: (data) => (data as List)
        .map((e) => WeatherLocation.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  result.fold((f) => print('❌ $f'), (locations) {
    print('✅ ${locations.length} weather locations available');
    print('   First 3: ${locations.take(3).map((l) => l.nameTh).join(', ')}');
  });
}

// ── Error sandbox ─────────────────────────────────────────────

Future<void> _stepErrorSandbox() async {
  print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print(' Error Sandbox — NetworkFailure exhaustive handling');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  // Each error sandbox path deliberately returns that HTTP status code.
  const errorCases = {
    '400': '/sandbox/errors/400',
    '401': '/sandbox/errors/401',
    '403': '/sandbox/errors/403',
    '404': '/sandbox/errors/404',
    '500': '/sandbox/errors/500',
  };

  for (final entry in errorCases.entries) {
    print('--- Hitting ${entry.key} sandbox ---');

    final result = await anonClient.get<Map<String, dynamic>>(
      entry.value,
      options: skipAuth(),
      decoder: (data) => data as Map<String, dynamic>,
    );

    result.fold((failure) {
      // ┌─────────────────────────────────────────────────────┐
      // │  NetworkFailure.when() enforces EXHAUSTIVE handling  │
      // │  The compiler will warn if any case is missing.      │
      // └─────────────────────────────────────────────────────┘
      final msg = failure.when(
        noConnection: () => '📶 Offline — check internet connection',
        timeout: () => '⏱  Request timed out — server overloaded?',
        unauthorized: (message) =>
            '🔐 401 Unauthorized: $message — redirect to login',
        badRequest: (message) => '⚠️ 400 Bad Request: $message',
        serverError: (code, message) =>
            '💥 $code Server Error: $message — report to Sentry',
        unknown: (message, _, __) => '❓ Unknown error: $message',
      );
      print('   $msg');
    }, (body) => print('   (unexpected success: $body)'));
    print('');
  }

  // ── Rate limit demo (429 + Retry-After) ─────────────────────
  print('--- 429 Rate Limit (RetryInterceptor respects Retry-After) ---');

  final rateLimitResult = await anonClient.get<Map<String, dynamic>>(
    '/sandbox/errors/429',
    options: skipAuth(),
    decoder: (data) => data as Map<String, dynamic>,
  );

  rateLimitResult.fold((failure) {
    // After maxAttempts retries, this arrives as serverError(429)
    // or unknown depending on the dio exception type from the API.
    print('   ⚠️  Still rate limited after retries: ${failure.toString()}');
  }, (body) => print('   ✅ Request eventually succeeded after back-off'));
}
