import 'dart:async';

import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryViewModel extends AsyncNotifier<List<CategoryModel>> {
  late final CategoryRepository _categoryRepository;

  @override
  FutureOr<List<CategoryModel>> build() {
    _categoryRepository = CategoryRepository();
    return _categoryRepository.getAllCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _categoryRepository.getAllCategories(),
    );
  }

  List<CategoryModel> getFeatureCategories() {
    final categories = state.value ?? [];
    return categories
        .where((cat) => cat.isFeatured && cat.parentId.isEmpty)
        .take(8)
        .toList();
  }

  /// [categoryId] plus the ID of every category whose `parentId` points to
  /// it. Top-level tabs (e.g. "Automobile") are parent categories, but
  /// products are tagged with their specific subcategory (e.g. "Cars"), so
  /// looking up a parent category's products/brands needs its children's
  /// IDs too, not just its own.
  List<String> getCategoryAndDescendantIds(String categoryId) {
    final categories = state.value ?? [];
    final childIds = categories
        .where((cat) => cat.parentId == categoryId)
        .map((cat) => cat.id);
    return [categoryId, ...childIds];
  }
}

final categoriesProvider =
    AsyncNotifierProvider<CategoryViewModel, List<CategoryModel>>(
      CategoryViewModel.new,
    );
