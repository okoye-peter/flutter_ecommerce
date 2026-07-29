import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_controller.g.dart';

@riverpod
class SearchController extends _$SearchController {
  late final ProductRepository _repo;

  @override
  FutureOr<List<ProductModel>> build(String query) {
    _repo = ProductRepository();
    return _repo.searchProducts(query);
  }
}
