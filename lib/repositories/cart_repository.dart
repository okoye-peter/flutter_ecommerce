import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartRepository {
  CartRepository({ FirebaseFirestore? firebaseStore})
      : db = firebaseStore ?? FirebaseFirestore.instance;

  FirebaseFirestore db;

  Future<List<CartItemModel>> fetchCartItems(String userId) async {
    try {
      final snapshot = await db
          .collection('Users')
          .doc(userId)
          .collection('Carts')
          .get();

      return snapshot.docs
          .map((snap) => CartItemModel.fromSnapShot(snap))
          .toList();
    } catch (e, s) {
      debugPrint('CartRepository.fetchCartItems failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upserts [item] using a deterministic doc id (product + variation), so
  /// re-adding the same product/variation combo updates the existing line
  /// instead of creating a duplicate cart entry.
  Future<void> saveCartItem(String userId, CartItemModel item) async {
    try {
      final docId = item.variationId.isNotEmpty
          ? '${item.productId}_${item.variationId}'
          : item.productId;

      await db
          .collection('Users')
          .doc(userId)
          .collection('Carts')
          .doc(docId)
          .set(item.toJson());
    } catch (e, s) {
      debugPrint('CartRepository.saveCartItem failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }
}