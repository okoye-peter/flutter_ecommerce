import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/repositories/cloudinary_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

/// One-time dev utility to populate the `Brands` collection. Uses
/// deterministic document IDs (via `.doc(id).set(...)`) — matching the brand
/// IDs embedded in each product's `Brand` field by [seedProducts] — instead
/// of auto-IDs, so running it more than once just overwrites the same
/// documents instead of duplicating them.
///
/// Brand logos start out as bundled Flutter assets (`TImages.*BrandLogo`),
/// but a Firestore document shouldn't point at a path baked into one specific
/// app build — so each unique asset is uploaded to Cloudinary first, and the
/// resulting `secure_url` is what actually gets stored as `Image`.
Future<void> seedBrands(CloudinaryRepository cloudinaryRepository) async {
  final db = FirebaseFirestore.instance;

  final assetPaths = {
    TImages.nikeBrandLogo,
    TImages.adidasBrandLogo,
    TImages.pumaBrandLogo,
    TImages.jordanBrandLogo,
  };

  final uploadedUrls = <String, String>{};
  for (final assetPath in assetPaths) {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    uploadedUrls[assetPath] = await cloudinaryRepository.uploadBytes(bytes, assetPath.split('/').last);
  }

  final batch = db.batch();

  void addBrand(String id, {required String name, required String logoAssetPath, bool isFeatured = true}) {
    batch.set(db.collection('Brands').doc(id), {
      'Name': name,
      'Image': uploadedUrls[logoAssetPath],
      'ProductCount': null,
      'IsFeatured': isFeatured,
    });
  }

  addBrand('nike', name: 'Nike', logoAssetPath: TImages.nikeBrandLogo);
  addBrand('adidas', name: 'Adidas', logoAssetPath: TImages.adidasBrandLogo);
  addBrand('puma', name: 'Puma', logoAssetPath: TImages.pumaBrandLogo);
  addBrand('jordan', name: 'Jordan', logoAssetPath: TImages.jordanBrandLogo);

  await batch.commit();
}
