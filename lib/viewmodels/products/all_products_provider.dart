import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_products_provider.g.dart';

@riverpod
Future<List<ProductModel>> allProducts(Ref ref) {
  return ProductRepository().fetchProductsByQuery(
    FirebaseFirestore.instance.collection('Products'),
  );
}
