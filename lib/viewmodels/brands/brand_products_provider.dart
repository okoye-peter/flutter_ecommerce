import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/brand_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'brand_products_provider.g.dart';

@riverpod
Future<List<ProductModel>> brandProducts(Ref ref, String brandId, {int? limit}) {
  return BrandRepository().fetchBrandProducts(brandId, limit: limit ?? -1);
}
