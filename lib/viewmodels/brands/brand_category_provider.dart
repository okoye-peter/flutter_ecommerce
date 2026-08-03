import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/models/brand_model.dart';
import 'package:ecommerce/repositories/brand_repository.dart';
import 'package:ecommerce/viewmodels/categories/category_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'brand_category_provider.g.dart';

@riverpod
Future<List<BrandModel>> bransForCategory(Ref ref, String categoryId) async {
  try {
    final categoryIds = ref
        .read(categoriesProvider.notifier)
        .getCategoryAndDescendantIds(categoryId);
    return await BrandRepository().getBrandsForCategory(categoryIds);
  } catch (e) {
    TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    return [];
  }
}
