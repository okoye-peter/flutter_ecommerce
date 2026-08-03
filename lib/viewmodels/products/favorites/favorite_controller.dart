import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/models/favorite_model.dart';
import 'package:ecommerce/repositories/favorite_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_controller.g.dart';

@Riverpod(keepAlive: true)
class FavoriteController extends _$FavoriteController {
  late final LocalStorage _localStorage;
  late final FavoriteRepository _repo;
  static String get _prefKey => LocalStorage.scopedKey('favorite');

  @override
  Future<List<FavoriteModel>> build() {
    _localStorage = ref.watch(localStorageProvider);
    _repo = FavoriteRepository();
    return _loadFavorites();
  }

  Future<List<FavoriteModel>> _loadFavorites() async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return [];

    final cached = _localStorage.readList(_prefKey);
    if (cached != null && cached.isNotEmpty) {
      return cached
          .map((entry) => FavoriteModel.fromJson(entry as Map<String, dynamic>))
          .toList();
    }

    final favorites = await _repo.fetchFavorites(userId);
    await _cache(favorites);
    return favorites;
  }

  Future<void> _cache(List<FavoriteModel> favorites) {
    return _localStorage.writeList(
      _prefKey,
      favorites.map((fav) => fav.toJson()).toList(),
    );
  }

  bool isFavorite(String productId) {
    return (state.value ?? []).any((fav) => fav.productId == productId);
  }

  /// Adds or removes [productId] from the current user's favorites,
  /// depending on whether it's already favorites, then refreshes both the
  /// state and the local cache to match.
  Future<bool> toggleFavorite(String productId) async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return false;

    try {
      if (isFavorite(productId)) {
        await _repo.removeFavorite(productId, userId);
        TSnacksLoader.successSnackBar(title: 'Removed from Favorites', message: 'Product has been removed from your favorites.');
      } else {
        await _repo.addFavorite(productId, userId);
        TSnacksLoader.successSnackBar(title: 'Added to Favorites', message: 'Product has been added to your favorites.');
      }
      final favorites = await _repo.fetchFavorites(userId);
      await _cache(favorites);
      state = AsyncData(favorites);
      return true;
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return false;
    }
  }
}
