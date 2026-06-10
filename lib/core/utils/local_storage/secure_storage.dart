import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SecureStorage extends GetxService {
  static SecureStorage get instance => Get.find();

  late final FlutterSecureStorage _storage;

  Future<SecureStorage> init() async {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    );
    return this;
  }

  // ── Tokens ──────────────────────────────────────────────────────────────────

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveAccessToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  Future<String?> readAccessToken() => _storage.read(key: _accessTokenKey);

  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _refreshTokenKey, value: token);

  Future<String?> readRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> saveTokenPair({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }

  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
    ]);
  }

  // ── Generic API ─────────────────────────────────────────────────────────────

  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  Future<String?> read(String key) => _storage.read(key: key);

  Future<bool> containsKey(String key) => _storage.containsKey(key: key);

  Future<void> delete(String key) => _storage.delete(key: key);

  Future<void> clearAll() => _storage.deleteAll();
}
