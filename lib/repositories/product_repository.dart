import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/errors/firebase_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ProductRepository {
  ProductRepository({FirebaseFirestore? firebaseStore})
    : _db = firebaseStore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  Future<({List<ProductModel> items, int lastPage})> fetchProducts({
    required int page,
    int limit = 10,
  }) async {
    try {
      final collection = _db.collection('Products');

      final countSnapshot = await collection.count().get();
      final total = countSnapshot.count ?? 0;
      final lastPage = total == 0 ? 1 : (total / limit).ceil();

      final snapshot = await collection
          .orderBy('Title')
          .limit(page * limit)
          .get();

      final items = snapshot.docs
          .skip((page - 1) * limit)
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();

      return (items: items, lastPage: lastPage);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('ProductRepository.fetchProducts failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<ProductModel> getProduct(String productId) async {
    try {
      final doc = await _db.collection('Products').doc(productId).get();
      return ProductModel.fromSnapshot(doc);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('ProductRepository.getProduct failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getFeaturedProducts({int? limit = 4}) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(limit!)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromQuerySnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('ProductRepository.fetchProducts failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }
}
