import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/repositories/cloudinary_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

/// One-time dev utility to populate the `Products` collection with sample
/// products. Uses deterministic document IDs (via `.doc(id).set(...)`)
/// instead of auto-IDs so running it more than once just overwrites the same
/// documents instead of duplicating them.
///
/// Assumes [seedCategories] has already been run — products reference
/// category doc IDs (e.g. `sport`, `mens_wear`, `gadgets`) created there.
///
/// Product thumbnails and brand logos start out as bundled Flutter assets,
/// but a Firestore document shouldn't point at a path baked into one
/// specific app build — so each unique asset is uploaded to Cloudinary
/// first, and the resulting `secure_url` is what actually gets stored.
Future<void> seedProducts(CloudinaryRepository cloudinaryRepository) async {
  final db = FirebaseFirestore.instance;

  final assetPaths = {
    TImages.productImage1,
    TImages.productImage2,
    TImages.productImage3,
    TImages.productImage4,
    TImages.productImage5,
    TImages.productImage6,
    TImages.productImage7,
    TImages.productImage8,
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

  Map<String, dynamic> brand(String id, String name, String logoAssetPath) {
    return {
      'Id': id,
      'Name': name,
      'Image': uploadedUrls[logoAssetPath],
      'ProductsCount': null,
      'IsFeatured': null,
    };
  }

  final nike = brand('nike', 'Nike', TImages.nikeBrandLogo);
  final adidas = brand('adidas', 'Adidas', TImages.adidasBrandLogo);
  final puma = brand('puma', 'Puma', TImages.pumaBrandLogo);
  final jordan = brand('jordan', 'Jordan', TImages.jordanBrandLogo);

  void addProduct(
    String id, {
    required String title,
    required Map<String, dynamic> brand,
    required String categoryId,
    required String thumbnailAssetPath,
    required double price,
    required double salePrice,
    required int stock,
    bool isFeatured = false,
    String productType = 'Single',
  }) {
    batch.set(db.collection('Products').doc(id), {
      'SKU': id.toUpperCase(),
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': [uploadedUrls[thumbnailAssetPath]],
      'Thumbnail': uploadedUrls[thumbnailAssetPath],
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand,
      'Description': title,
      'ProductType': productType,
      'ProductAttributes': [],
      'ProductVariations': [],
    });
  }

  addProduct(
    'jordan_duffle_bag',
    title: 'Air Jordan Velocity Duffle Bag',
    brand: jordan,
    categoryId: 'sport',
    thumbnailAssetPath: TImages.productImage1,
    price: 89.99,
    salePrice: 69.99,
    stock: 25,
    isFeatured: true,
  );

  addProduct(
    'wireless_headphones',
    title: 'Best Sounding Wireless Headphones',
    brand: puma,
    categoryId: 'gadgets',
    thumbnailAssetPath: TImages.productImage2,
    price: 59.99,
    salePrice: 44.99,
    stock: 40,
    isFeatured: true,
  );

  addProduct(
    'hiking_boots',
    title: 'Lightweight Breathable Hiking Boots',
    brand: nike,
    categoryId: 'sport',
    thumbnailAssetPath: TImages.productImage3,
    price: 74.99,
    salePrice: 59.99,
    stock: 30,
  );

  addProduct(
    'palm_tree_shirt_set',
    title: 'Palm Tree Print Shirt & Shorts Set',
    brand: adidas,
    categoryId: 'mens_wear',
    thumbnailAssetPath: TImages.productImage4,
    price: 34.99,
    salePrice: 24.99,
    stock: 60,
    isFeatured: true,
  );

  addProduct(
    'textured_shirt_set',
    title: 'Textured Shirt & Shorts Set',
    brand: nike,
    categoryId: 'mens_wear',
    thumbnailAssetPath: TImages.productImage5,
    price: 39.99,
    salePrice: 29.99,
    stock: 45,
  );

  addProduct(
    'mens_casual_tee',
    title: "Men's Casual Tee",
    brand: puma,
    categoryId: 'mens_wear',
    thumbnailAssetPath: TImages.productImage6,
    price: 19.99,
    salePrice: 14.99,
    stock: 100,
  );

  addProduct(
    'solar_watch',
    title: 'Splash Eclipse Solar Watch',
    brand: adidas,
    categoryId: 'gadgets',
    thumbnailAssetPath: TImages.productImage7,
    price: 129.99,
    salePrice: 99.99,
    stock: 15,
    isFeatured: true,
  );

  addProduct(
    'adventure_tumbler',
    title: 'Adventure Quencher Tumbler',
    brand: jordan,
    categoryId: 'beverages',
    thumbnailAssetPath: TImages.productImage8,
    price: 44.99,
    salePrice: 34.99,
    stock: 50,
  );

  await batch.commit();
}
