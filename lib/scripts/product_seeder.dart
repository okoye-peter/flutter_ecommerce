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
    TImages.productImage9,
    TImages.productImage10,
    TImages.productImage11,
    TImages.productImage12,
    TImages.productImage13,
    TImages.productImage14,
    TImages.productImage15,
    TImages.productImage16,
    TImages.nikeBrandLogo,
    TImages.adidasBrandLogo,
    TImages.pumaBrandLogo,
    TImages.jordanBrandLogo,
  };

  final uploadedUrls = <String, String>{};
  for (final assetPath in assetPaths) {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    uploadedUrls[assetPath] = await cloudinaryRepository.uploadBytes(
      bytes,
      assetPath.split('/').last,
    );
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

  // Keys here follow ProductAttributeModel.fromJson/ProductVariationModel.fromJson,
  // which aren't symmetric with their own toJson (e.g. variation stock/image are
  // read lowercase while everything else in this schema is PascalCase).
  Map<String, dynamic> attribute(String name, List<String> values) {
    return {'Name': name, 'Values': values};
  }

  Map<String, dynamic> variation(
    String id, {
    required Map<String, String> attributeValues,
    required double price,
    required double salePrice,
    required int stock,
    required String thumbnailAssetPath,
  }) {
    return {
      'Id': id,
      'SKU': id.toUpperCase(),
      'image': uploadedUrls[thumbnailAssetPath],
      'Description': '',
      'Price': price,
      'SalePrice': salePrice,
      'stock': stock,
      'AttributeValues': attributeValues,
    };
  }

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
    String productType = 'single',
    List<Map<String, dynamic>> productAttributes = const [],
    List<Map<String, dynamic>> productVariations = const [],
    List<String> galleryAssetPaths = const [],
  }) {
    batch.set(db.collection('Products').doc(id), {
      'SKU': id.toUpperCase(),
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': [
        uploadedUrls[thumbnailAssetPath],
        ...galleryAssetPaths.map((path) => uploadedUrls[path]),
      ],
      'Thumbnail': uploadedUrls[thumbnailAssetPath],
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand,
      'Description': title,
      'ProductType': productType,
      'ProductAttributes': productAttributes,
      'ProductVariations': productVariations,
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
    productType: 'variable',
    galleryAssetPaths: [TImages.productImage9, TImages.productImage14],
    productAttributes: [
      attribute('Color', ['Grey', 'Brown']),
      attribute('Size', ['EU 41', 'EU 42', 'EU 43']),
    ],
    productVariations: [
      variation(
        'hiking_boots_grey_41',
        attributeValues: {'Color': 'Grey', 'Size': 'EU 41'},
        price: 74.99,
        salePrice: 59.99,
        stock: 8,
        thumbnailAssetPath: TImages.productImage3,
      ),
      variation(
        'hiking_boots_grey_42',
        attributeValues: {'Color': 'Grey', 'Size': 'EU 42'},
        price: 74.99,
        salePrice: 59.99,
        stock: 10,
        thumbnailAssetPath: TImages.productImage3,
      ),
      variation(
        'hiking_boots_brown_42',
        attributeValues: {'Color': 'Brown', 'Size': 'EU 42'},
        price: 79.99,
        salePrice: 64.99,
        stock: 6,
        thumbnailAssetPath: TImages.productImage9,
      ),
      variation(
        'hiking_boots_brown_43',
        attributeValues: {'Color': 'Brown', 'Size': 'EU 43'},
        price: 79.99,
        salePrice: 64.99,
        stock: 6,
        thumbnailAssetPath: TImages.productImage9,
      ),
    ],
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
    productType: 'variable',
    galleryAssetPaths: [TImages.productImage10, TImages.productImage15],
    productAttributes: [
      attribute('Color', ['Black', 'White', 'Navy']),
      attribute('Size', ['S', 'M', 'L', 'XL']),
    ],
    productVariations: [
      variation(
        'mens_casual_tee_black_m',
        attributeValues: {'Color': 'Black', 'Size': 'M'},
        price: 19.99,
        salePrice: 14.99,
        stock: 25,
        thumbnailAssetPath: TImages.productImage6,
      ),
      variation(
        'mens_casual_tee_black_l',
        attributeValues: {'Color': 'Black', 'Size': 'L'},
        price: 19.99,
        salePrice: 14.99,
        stock: 25,
        thumbnailAssetPath: TImages.productImage6,
      ),
      variation(
        'mens_casual_tee_white_m',
        attributeValues: {'Color': 'White', 'Size': 'M'},
        price: 19.99,
        salePrice: 14.99,
        stock: 20,
        thumbnailAssetPath: TImages.productImage6,
      ),
      variation(
        'mens_casual_tee_navy_xl',
        attributeValues: {'Color': 'Navy', 'Size': 'XL'},
        price: 21.99,
        salePrice: 16.99,
        stock: 15,
        thumbnailAssetPath: TImages.productImage6,
      ),
    ],
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

  addProduct(
    'soccer_ball',
    title: 'Champions Match Soccer Ball',
    brand: adidas,
    categoryId: 'football',
    thumbnailAssetPath: TImages.productImage11,
    price: 24.99,
    salePrice: 19.99,
    stock: 80,
  );

  addProduct(
    'nike_tracksuit',
    title: 'Nike Tracksuit Set',
    brand: nike,
    categoryId: 'clothing',
    thumbnailAssetPath: TImages.productImage16,
    price: 79.99,
    salePrice: 59.99,
    stock: 40,
    isFeatured: true,
    productType: 'variable',
    galleryAssetPaths: [TImages.productImage6, TImages.productImage10],
    productAttributes: [
      attribute('Color', ['Black', 'Grey']),
      attribute('Size', ['M', 'L', 'XL']),
    ],
    productVariations: [
      variation(
        'nike_tracksuit_black_m',
        attributeValues: {'Color': 'Black', 'Size': 'M'},
        price: 79.99,
        salePrice: 59.99,
        stock: 12,
        thumbnailAssetPath: TImages.productImage16,
      ),
      variation(
        'nike_tracksuit_black_l',
        attributeValues: {'Color': 'Black', 'Size': 'L'},
        price: 79.99,
        salePrice: 59.99,
        stock: 14,
        thumbnailAssetPath: TImages.productImage16,
      ),
      variation(
        'nike_tracksuit_grey_l',
        attributeValues: {'Color': 'Grey', 'Size': 'L'},
        price: 79.99,
        salePrice: 59.99,
        stock: 10,
        thumbnailAssetPath: TImages.productImage16,
      ),
      variation(
        'nike_tracksuit_grey_xl',
        attributeValues: {'Color': 'Grey', 'Size': 'XL'},
        price: 84.99,
        salePrice: 64.99,
        stock: 8,
        thumbnailAssetPath: TImages.productImage16,
      ),
    ],
  );

  addProduct(
    'basketball_grip',
    title: 'Pro Grip Streetball',
    brand: jordan,
    categoryId: 'basketball',
    thumbnailAssetPath: TImages.productImage14,
    price: 27.99,
    salePrice: 21.99,
    stock: 65,
  );

  addProduct(
    'timberland_boots',
    title: 'Rugged All-Terrain Boots',
    brand: puma,
    categoryId: 'mens_wear',
    thumbnailAssetPath: TImages.productImage9,
    price: 94.99,
    salePrice: 74.99,
    stock: 35,
  );

  addProduct(
    'vintage_denim_shorts',
    title: 'Vintage Wash Denim Shorts',
    brand: adidas,
    categoryId: 'mens_wear',
    thumbnailAssetPath: TImages.productImage10,
    price: 32.99,
    salePrice: 24.99,
    stock: 55,
  );

  addProduct(
    'smart_fitness_band',
    title: 'Smart Fitness Tracker Band',
    brand: nike,
    categoryId: 'gadgets',
    thumbnailAssetPath: TImages.productImage12,
    price: 49.99,
    salePrice: 39.99,
    stock: 90,
  );

  addProduct(
    'laptop_sleeve',
    title: 'Padded 15" Laptop Sleeve',
    brand: puma,
    categoryId: 'laptops',
    thumbnailAssetPath: TImages.productImage13,
    price: 22.99,
    salePrice: 17.99,
    stock: 70,
  );

  addProduct(
    'stylish_shades',
    title: 'Statement Aviator Sunglasses',
    brand: jordan,
    categoryId: 'womens_wear',
    thumbnailAssetPath: TImages.productImage15,
    price: 18.99,
    salePrice: 13.99,
    stock: 100,
  );

  addProduct(
    'car_phone_mount',
    title: 'Universal Car Phone Mount',
    brand: adidas,
    categoryId: 'cars',
    thumbnailAssetPath: TImages.productImage1,
    price: 15.99,
    salePrice: 11.99,
    stock: 120,
  );

  addProduct(
    'motorcycle_gloves',
    title: 'Waterproof Motorcycle Gloves',
    brand: puma,
    categoryId: 'motorcycles',
    thumbnailAssetPath: TImages.productImage2,
    price: 34.99,
    salePrice: 27.99,
    stock: 45,
  );

  addProduct(
    'energy_drink_pack',
    title: 'Energy Drink 12-Pack',
    brand: nike,
    categoryId: 'beverages',
    thumbnailAssetPath: TImages.productImage7,
    price: 18.99,
    salePrice: 14.99,
    stock: 150,
  );

  addProduct(
    'protein_snack_bar',
    title: 'Protein Snack Bar Box',
    brand: jordan,
    categoryId: 'snacks',
    thumbnailAssetPath: TImages.productImage4,
    price: 12.99,
    salePrice: 9.99,
    stock: 200,
  );

  addProduct(
    'chips_variety_pack',
    title: 'Chips Variety Pack',
    brand: adidas,
    categoryId: 'snacks',
    thumbnailAssetPath: TImages.productImage5,
    price: 9.99,
    salePrice: 7.49,
    stock: 180,
  );

  addProduct(
    'gaming_console_pro',
    title: 'Next-Gen Gaming Console',
    brand: puma,
    categoryId: 'console',
    thumbnailAssetPath: TImages.productImage6,
    price: 399.99,
    salePrice: 349.99,
    stock: 20,
    isFeatured: true,
  );

  addProduct(
    'gaming_headset',
    title: 'Surround Sound Gaming Headset',
    brand: nike,
    categoryId: 'pc',
    thumbnailAssetPath: TImages.productImage8,
    price: 69.99,
    salePrice: 54.99,
    stock: 55,
  );

  addProduct(
    'wireless_mouse',
    title: 'Precision Wireless Gaming Mouse',
    brand: jordan,
    categoryId: 'pc',
    thumbnailAssetPath: TImages.productImage11,
    price: 29.99,
    salePrice: 22.99,
    stock: 85,
  );

  addProduct(
    'smartphone_case',
    title: 'Shockproof Smartphone Case',
    brand: adidas,
    categoryId: 'phones',
    thumbnailAssetPath: TImages.productImage12,
    price: 14.99,
    salePrice: 10.99,
    stock: 140,
  );

  addProduct(
    'wireless_earbuds',
    title: 'True Wireless Earbuds',
    brand: puma,
    categoryId: 'phones',
    thumbnailAssetPath: TImages.productImage13,
    price: 59.99,
    salePrice: 44.99,
    stock: 95,
    isFeatured: true,
    productType: 'variable',
    galleryAssetPaths: [TImages.productImage2, TImages.productImage12],
    productAttributes: [
      attribute('Color', ['Black', 'White', 'Blue']),
    ],
    productVariations: [
      variation(
        'wireless_earbuds_black',
        attributeValues: {'Color': 'Black'},
        price: 59.99,
        salePrice: 44.99,
        stock: 40,
        thumbnailAssetPath: TImages.productImage13,
      ),
      variation(
        'wireless_earbuds_white',
        attributeValues: {'Color': 'White'},
        price: 59.99,
        salePrice: 44.99,
        stock: 35,
        thumbnailAssetPath: TImages.productImage13,
      ),
      variation(
        'wireless_earbuds_blue',
        attributeValues: {'Color': 'Blue'},
        price: 62.99,
        salePrice: 47.99,
        stock: 20,
        thumbnailAssetPath: TImages.productImage13,
      ),
    ],
  );

  addProduct(
    'laptop_stand',
    title: 'Ergonomic Aluminum Laptop Stand',
    brand: nike,
    categoryId: 'laptops',
    thumbnailAssetPath: TImages.productImage14,
    price: 27.99,
    salePrice: 21.99,
    stock: 60,
  );

  addProduct(
    'womens_summer_dress',
    title: "Women's Floral Summer Dress",
    brand: jordan,
    categoryId: 'womens_wear',
    thumbnailAssetPath: TImages.productImage15,
    price: 44.99,
    salePrice: 34.99,
    stock: 50,
  );

  addProduct(
    'womens_running_shoes',
    title: "Women's Lightweight Running Shoes",
    brand: adidas,
    categoryId: 'womens_wear',
    thumbnailAssetPath: TImages.productImage16,
    price: 64.99,
    salePrice: 49.99,
    stock: 70,
    isFeatured: true,
    productType: 'variable',
    galleryAssetPaths: [TImages.productImage14, TImages.productImage3],
    productAttributes: [
      attribute('Color', ['Pink', 'White']),
      attribute('Size', ['EU 36', 'EU 38', 'EU 40']),
    ],
    productVariations: [
      variation(
        'womens_running_shoes_pink_36',
        attributeValues: {'Color': 'Pink', 'Size': 'EU 36'},
        price: 64.99,
        salePrice: 49.99,
        stock: 18,
        thumbnailAssetPath: TImages.productImage16,
      ),
      variation(
        'womens_running_shoes_pink_38',
        attributeValues: {'Color': 'Pink', 'Size': 'EU 38'},
        price: 64.99,
        salePrice: 49.99,
        stock: 20,
        thumbnailAssetPath: TImages.productImage16,
      ),
      variation(
        'womens_running_shoes_white_38',
        attributeValues: {'Color': 'White', 'Size': 'EU 38'},
        price: 64.99,
        salePrice: 49.99,
        stock: 16,
        thumbnailAssetPath: TImages.productImage16,
      ),
      variation(
        'womens_running_shoes_white_40',
        attributeValues: {'Color': 'White', 'Size': 'EU 40'},
        price: 67.99,
        salePrice: 52.99,
        stock: 16,
        thumbnailAssetPath: TImages.productImage16,
      ),
    ],
  );

  addProduct(
    'car_seat_cover',
    title: 'Premium Car Seat Cover Set',
    brand: puma,
    categoryId: 'cars',
    thumbnailAssetPath: TImages.productImage9,
    price: 54.99,
    salePrice: 42.99,
    stock: 30,
  );

  await batch.commit();
}
