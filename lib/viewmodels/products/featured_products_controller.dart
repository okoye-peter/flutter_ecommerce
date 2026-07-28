import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'featured_products_controller.g.dart';

@riverpod
Future<List<ProductModel>> featuredProducts(Ref ref) {
  return ProductRepository().getFeaturedProducts();
}
