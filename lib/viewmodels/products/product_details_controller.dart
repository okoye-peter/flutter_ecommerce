import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_details_controller.g.dart';

@riverpod
class ProductDetailsController extends _$ProductDetailsController {
  late final ProductRepository _repo;

  @override
  FutureOr<ProductModel> build(String productId) {
    _repo = ProductRepository();
    return _repo.getProduct(productId);
  }
}
