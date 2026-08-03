import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:ecommerce/viewmodels/products/favorites/favorite_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_products_controller.g.dart';

/// Resolves the current user's favorite product ids into [ProductModel]s.
///
/// Keeps a local id->product cache so that toggling a favorite only ever
/// fetches ids that haven't been seen before; removals are dropped from the
/// cache and the returned list without hitting Firestore again.
@Riverpod(keepAlive: true)
class FavoriteProductsController extends _$FavoriteProductsController {
  final Map<String, ProductModel> _cache = {};

  @override
  Future<List<ProductModel>> build() async {
    final favorites = await ref.watch(favoriteControllerProvider.future);
    final ids = favorites.map((fav) => fav.productId).toList();
    final idSet = ids.toSet();

    final missingIds = idSet.where((id) => !_cache.containsKey(id)).toList();
    if (missingIds.isNotEmpty) {
      final fetched = await ProductRepository().getSelectedProducts(
        productIds: missingIds,
      );
      for (final product in fetched) {
        _cache[product.id] = product;
      }
    }

    _cache.removeWhere((id, _) => !idSet.contains(id));

    return ids.map((id) => _cache[id]).whereType<ProductModel>().toList();
  }
}
