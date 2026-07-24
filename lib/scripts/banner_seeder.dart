import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/repositories/cloudinary_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

/// One-time dev utility to populate the `Banners` collection with promo
/// banners. Uses deterministic document IDs (via `.doc(id).set(...)`) instead
/// of auto-IDs so running it more than once just overwrites the same
/// documents instead of duplicating them.
///
/// Banner images start out as bundled Flutter assets (`TImages.promoBanner*`),
/// but a Firestore document shouldn't point at a path baked into one specific
/// app build — so each unique asset is uploaded to Cloudinary first, and the
/// resulting `secure_url` is what actually gets stored as `ImageUrl`.
Future<void> seedBanners(CloudinaryRepository cloudinaryRepository) async {
  final db = FirebaseFirestore.instance;

  final assetPaths = {
    TImages.promoBanner1,
    TImages.promoBanner2,
    TImages.promoBanner3,
    TImages.promoBanner6,
  };

  final uploadedUrls = <String, String>{};
  for (final assetPath in assetPaths) {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    uploadedUrls[assetPath] = await cloudinaryRepository.uploadBytes(bytes, assetPath.split('/').last);
  }

  final batch = db.batch();

  final today = DateTime.now();
  final start = DateTime(today.year, today.month, today.day);
  final end = start.add(const Duration(days: 30));

  void addBanner(String id, {required String assetPath, required String targetScreen}) {
    batch.set(db.collection('Banners').doc(id), {
      'StartDate': start.toIso8601String(),
      'EndDate': end.toIso8601String(),
      'ImageUrl': uploadedUrls[assetPath],
      'TargetScreen': targetScreen,
    });
  }

  addBanner('promo_products', assetPath: TImages.promoBanner1, targetScreen: AppRoutes.products);
  addBanner('promo_brands', assetPath: TImages.promoBanner2, targetScreen: AppRoutes.brands);
  addBanner('promo_sub_categories', assetPath: TImages.promoBanner3, targetScreen: AppRoutes.subCategories);
  addBanner('promo_carts', assetPath: TImages.promoBanner6, targetScreen: AppRoutes.carts);

  await batch.commit();
}
