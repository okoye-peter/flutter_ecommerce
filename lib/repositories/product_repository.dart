import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/constants/enums.dart';
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
      // Firestore can't query array length directly, so filter to variable
      // products (which always carry attributes/variations) here and check
      // the image count client-side.
      final snapshot = await _db
          .collection('Products')
          .where('ProductType', isEqualTo: ProductType.variable.name)
          .limit((limit ?? 4) * 3)
          .get();

      // final snapshot = await _db
      // .collection('Products')
      // .where('IsFeatured', isEqualTo: true)
      // .limit(limit!)
      // .get();

      final items = snapshot.docs
          .map((e) => ProductModel.fromQuerySnapshot(e))
          .where(
            (product) =>
                (product.images?.length ?? 0) > 1 &&
                (product.productAttributes?.isNotEmpty ?? false) &&
                (product.productVariations?.isNotEmpty ?? false),
          )
          .take(limit ?? 4)
          .toList();

      return items;
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

  /// Case-insensitive title match. Firestore has no native substring query,
  /// so this filters client-side — fine for a catalog this size, but won't
  /// scale to a large one without a dedicated search index/service.
  Future<List<ProductModel>> searchProducts(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return [];

    try {
      final snapshot = await _db.collection('Products').get();

      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .where((product) => product.title.toLowerCase().contains(normalized))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('ProductRepository.searchProducts failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('ProductRepository.fetchProductsByQuery failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }
}
