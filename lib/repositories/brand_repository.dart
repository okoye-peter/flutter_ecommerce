import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/errors/firebase_exception.dart';
import 'package:ecommerce/core/errors/format_exception.dart';
import 'package:ecommerce/core/errors/platform_exception.dart';
import 'package:ecommerce/models/brand_category_model.dart';
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
      final brands = snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return _withProductCounts(brands);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('BrandRepository.getAllBrands failed: $e\n$s');
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
      debugPrint('BrandRepository.fetchBrandProducts failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<BrandModel>> getBrandsForCategory(List<String> categoryIds) async {
    try {
      final links = await _db
          .collection('BrandCategory')
          .where('categoryId', whereIn: categoryIds)
          .get();

      final brandIds = links.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc).brandId)
          .toSet()
          .toList();
      if (brandIds.isEmpty) return [];

      final snapshot = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .get();

      final brands = snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return _withProductCounts(brands);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, s) {
      debugPrint('BrandRepository.getBrandsForCategory failed: $e\n$s');
      throw 'Something went wrong. Please try again';
    }
  }

  /// [BrandModel.productsCount] is never written by the seeder, so it's
  /// filled in here from an aggregate count query instead of trusting a
  /// stale/absent stored field.
  Future<List<BrandModel>> _withProductCounts(List<BrandModel> brands) async {
    final counts = await Future.wait(
      brands.map(
        (brand) => _db
            .collection('Products')
            .where('Brand.Id', isEqualTo: brand.id)
            .count()
            .get(),
      ),
    );

    return [
      for (var i = 0; i < brands.length; i++)
        brands[i].copyWith(productsCount: counts[i].count ?? 0),
    ];
  }
}
