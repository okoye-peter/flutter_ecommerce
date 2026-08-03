import 'package:cloud_firestore/cloud_firestore.dart';

/// One-time dev utility to populate the `BrandCategory` join collection, by
/// pairing each product's embedded `Brand.Id` with its `CategoryId` (rather
/// than a second hardcoded list that could drift). Run after [seedProducts]
/// — deterministic doc IDs (`brandId_categoryId`) keep reruns idempotent and
/// naturally dedupe repeated brand/category pairs.
Future<void> seedBrandCategories() async {
  final db = FirebaseFirestore.instance;
  final products = await db.collection('Products').get();

  final batch = db.batch();
  for (final doc in products.docs) {
    final data = doc.data();
    final categoryId = data['CategoryId'] as String?;
    final brand = data['Brand'] as Map<String, dynamic>?;
    final brandId = brand?['Id'] as String?;
    if (categoryId == null ||
        categoryId.isEmpty ||
        brandId == null ||
        brandId.isEmpty) {
      continue;
    }

    batch.set(db.collection('BrandCategory').doc('${brandId}_$categoryId'), {
      'brandId': brandId,
      'categoryId': categoryId,
    });
  }

  await batch.commit();
}
