import 'package:cloud_firestore/cloud_firestore.dart';

/// One-time dev utility to populate the `ProductCategory` join collection,
/// derived from the `CategoryId` already stored on each `Products` document
/// (rather than a second hardcoded list that could drift). Run after
/// [seedProducts] — deterministic doc IDs (`productId_categoryId`) keep
/// reruns idempotent.
Future<void> seedProductCategories() async {
  final db = FirebaseFirestore.instance;
  final products = await db.collection('Products').get();

  final batch = db.batch();
  for (final doc in products.docs) {
    final categoryId = doc.data()['CategoryId'] as String?;
    if (categoryId == null || categoryId.isEmpty) continue;

    batch.set(db.collection('ProductCategory').doc('${doc.id}_$categoryId'), {
      'productId': doc.id,
      'categoryId': categoryId,
    });
  }

  await batch.commit();
}
