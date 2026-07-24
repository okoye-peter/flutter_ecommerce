import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/repositories/cloudinary_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

/// One-time dev utility to populate the `Categories` collection with parent
/// categories and a couple of subcategories under each. Uses deterministic
/// document IDs (via `.doc(id).set(...)`) instead of auto-IDs so running it
/// more than once just overwrites the same documents instead of duplicating
/// them.
///
/// Category images start out as bundled Flutter assets (`TImages.category*`),
/// but a Firestore document shouldn't point at a path baked into one specific
/// app build — so each unique asset is uploaded to Cloudinary first, and the
/// resulting `secure_url` is what actually gets stored as `Image`.
Future<void> seedCategories(CloudinaryRepository cloudinaryRepository) async {
  final db = FirebaseFirestore.instance;

  final assetPaths = {
    TImages.categorySport,
    TImages.categoryAutoMobile,
    TImages.categoryClothing,
    TImages.categoryFood,
    TImages.categoryGadget,
    TImages.categoryGames,
  };

  final uploadedUrls = <String, String>{};
  for (final assetPath in assetPaths) {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    uploadedUrls[assetPath] = await cloudinaryRepository.uploadBytes(bytes, assetPath.split('/').last);
  }

  final batch = db.batch();

  void addCategory(String id, {required String name, required String assetPath, String parentId = '', bool isFeatured = true}) {
    batch.set(db.collection('Categories').doc(id), {
      'Name': name,
      'Image': uploadedUrls[assetPath],
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    });
  }

  addCategory('sport', name: 'Sport', assetPath: TImages.categorySport);
  addCategory('football', name: 'Football', assetPath: TImages.categorySport, parentId: 'sport', isFeatured: false);
  addCategory('basketball', name: 'Basketball', assetPath: TImages.categorySport, parentId: 'sport', isFeatured: false);

  addCategory('automobile', name: 'Automobile', assetPath: TImages.categoryAutoMobile);
  addCategory('cars', name: 'Cars', assetPath: TImages.categoryAutoMobile, parentId: 'automobile', isFeatured: false);
  addCategory('motorcycles', name: 'Motorcycles', assetPath: TImages.categoryAutoMobile, parentId: 'automobile', isFeatured: false);

  addCategory('clothing', name: 'Clothing', assetPath: TImages.categoryClothing);
  addCategory('mens_wear', name: "Men's Wear", assetPath: TImages.categoryClothing, parentId: 'clothing', isFeatured: false);
  addCategory('womens_wear', name: "Women's Wear", assetPath: TImages.categoryClothing, parentId: 'clothing', isFeatured: false);

  addCategory('food', name: 'Food', assetPath: TImages.categoryFood);
  addCategory('snacks', name: 'Snacks', assetPath: TImages.categoryFood, parentId: 'food', isFeatured: false);
  addCategory('beverages', name: 'Beverages', assetPath: TImages.categoryFood, parentId: 'food', isFeatured: false);

  addCategory('gadgets', name: 'Gadgets', assetPath: TImages.categoryGadget);
  addCategory('phones', name: 'Phones', assetPath: TImages.categoryGadget, parentId: 'gadgets', isFeatured: false);
  addCategory('laptops', name: 'Laptops', assetPath: TImages.categoryGadget, parentId: 'gadgets', isFeatured: false);

  addCategory('games', name: 'Games', assetPath: TImages.categoryGames);
  addCategory('console', name: 'Console', assetPath: TImages.categoryGames, parentId: 'games', isFeatured: false);
  addCategory('pc', name: 'PC', assetPath: TImages.categoryGames, parentId: 'games', isFeatured: false);

  await batch.commit();
}
