import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:ecommerce/viewmodels/categories/category_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_products_provider.g.dart';

@riverpod
Future<List<ProductModel>> categoryProducts(
  Ref ref,
  String categoryId, {
  int limit = 4,
}) {
  final categoryIds = ref
      .read(categoriesProvider.notifier)
      .getCategoryAndDescendantIds(categoryId);

  return ProductRepository().getProductsForCategory(
    categoryIds: categoryIds,
    limit: limit,
  );
}
