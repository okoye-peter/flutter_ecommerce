import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/errors/firebase_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:ecommerce/models/order_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class OrderRepository {
  OrderRepository({FirebaseFirestore? firebaseFirestore})
    : _db = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _orders(String userId) =>
      _db.collection('Users').doc(userId).collection('Orders');

  /// Reserves a Firestore-generated document id for a new order, so the
  /// [OrderModel] can be constructed with its final id before it's saved.
  String newOrderId(String userId) => _orders(userId).doc().id;

  /// Fetches orders newest-first, [limit] at a time. Pass the previous
  /// call's `lastDocument` as [startAfter] to fetch the next page — cursor
  /// pagination, so each page only reads the documents it actually returns
  /// (unlike offset/skip, which re-reads every earlier page on each call).
  Future<
    ({
      List<OrderModel> items,
      DocumentSnapshot<Map<String, dynamic>>? lastDocument,
      bool hasMore,
    })
  >
  fetchOrders({
    required String userId,
    int limit = 10,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _orders(
        userId,
      ).orderBy('OrderDate', descending: true).limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.get();
      final items = snapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .toList();

      return (
        items: items,
        lastDocument: snapshot.docs.isEmpty ? null : snapshot.docs.last,
        hasMore: snapshot.docs.length == limit,
      );
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('OrderRepository.fetchOrders failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> createOrder(OrderModel order) async {
    try {
      await _orders(order.userId).doc(order.id).set(order.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('OrderRepository.createOrder failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }
}
