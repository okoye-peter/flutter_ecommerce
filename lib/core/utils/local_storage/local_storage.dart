import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends GetxService {
  static LocalStorage get instance => Get.find();

  late final SharedPreferences _prefs;

  Future<LocalStorage> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // ── Primitives ──────────────────────────────────────────────────────────────
  
  Future<void> writeString(String key, String value) =>
      _prefs.setString(key, value);

  String? readString(String key) => _prefs.getString(key);

  Future<void> writeBool(String key, {required bool value}) =>
      _prefs.setBool(key, value);

  bool readBool(String key, {bool fallback = false}) =>
      _prefs.getBool(key) ?? fallback;

  Future<void> writeInt(String key, int value) => _prefs.setInt(key, value);

  int readInt(String key, {int fallback = 0}) =>
      _prefs.getInt(key) ?? fallback;

  Future<void> writeDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  double readDouble(String key, {double fallback = 0.0}) =>
      _prefs.getDouble(key) ?? fallback;

  // ── JSON object ─────────────────────────────────────────────────────────────

  Future<void> writeObject(String key, Map<String, dynamic> value) =>
      _prefs.setString(key, jsonEncode(value));

  Map<String, dynamic>? readObject(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  // ── JSON list ───────────────────────────────────────────────────────────────

  Future<void> writeList(String key, List<dynamic> value) =>
      _prefs.setString(key, jsonEncode(value));

  List<dynamic>? readList(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return null;
    return jsonDecode(raw) as List<dynamic>;
  }

  // ── Cart ─────────────────────────────────────────────────────────────────────

  static const _cartKey = 'cart_ids';

  List<String> getCartIds() =>
      _prefs.getStringList(_cartKey) ?? [];

  int get cartCount => getCartIds().length;

  bool isInCart(String productId) => getCartIds().contains(productId);

  Future<void> addToCart(String productId) async {
    final ids = getCartIds();
    if (!ids.contains(productId)) {
      await _prefs.setStringList(_cartKey, [...ids, productId]);
    }
  }

  Future<void> removeFromCart(String productId) async {
    final ids = getCartIds()..remove(productId);
    await _prefs.setStringList(_cartKey, ids);
  }

  Future<void> clearCart() => _prefs.remove(_cartKey);

  // ── Wishlist ─────────────────────────────────────────────────────────────────

  static const _wishlistKey = 'wishlist_ids';

  List<String> getWishlistIds() =>
      _prefs.getStringList(_wishlistKey) ?? [];

  int get wishlistCount => getWishlistIds().length;

  bool isInWishlist(String productId) => getWishlistIds().contains(productId);

  Future<void> addToWishlist(String productId) async {
    final ids = getWishlistIds();
    if (!ids.contains(productId)) {
      await _prefs.setStringList(_wishlistKey, [...ids, productId]);
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    final ids = getWishlistIds()..remove(productId);
    await _prefs.setStringList(_wishlistKey, ids);
  }

  Future<void> clearWishlist() => _prefs.remove(_wishlistKey);

  // ── Helpers ─────────────────────────────────────────────────────────────────

  bool hasKey(String key) => _prefs.containsKey(key);

  Future<void> remove(String key) => _prefs.remove(key);

  Future<void> clearAll() => _prefs.clear();
}
