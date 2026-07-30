import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/errors/firebase_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:ecommerce/models/brand_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class BrandRepository {
  BrandRepository({FirebaseFirestore? firebaseFirestore})
    : _db = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();

      return snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('CategoryRepository.getAllCategories failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> fetchBrandProducts(
    String brandId, {
    int? limit = -1,
  }) async {
    try {
      final snapshot = limit! > 0
          ? await _db
                .collection('Products')
                .where('Brand.Id', isEqualTo: brandId)
                .limit(limit)
                .get()
          : await _db
                .collection('Products')
                .where('Brand.Id', isEqualTo: brandId)
                .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('CategoryRepository.getAllCategories failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }
}
