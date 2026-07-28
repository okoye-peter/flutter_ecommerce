import 'dart:async';

import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_controller.g.dart';

class ProductData {
  ProductData({
    this.page = 1,
    this.limit = 10,
    this.data = const [],
    this.lastPage = 1,
  });

  final int page;
  final int limit;
  final List<ProductModel> data;
  final int lastPage;

  ProductData copyWith({int? page, int? limit, List<ProductModel>? data, int? lastPage}) {
    return ProductData(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      data: data ?? this.data,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}

@riverpod
class ProductController extends _$ProductController {
  late final ProductRepository _productRepository;

  @override
  FutureOr<ProductData> build() {
    _productRepository = ProductRepository();
    return _fetchState(page: 1);
  }

  Future<void> fetchProducts({required int page}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchState(page: page));
  }

  Future<ProductData> _fetchState({required int page, int limit = 10}) async {
    final result = await _productRepository.fetchProducts(
      page: page,
      limit: limit,
    );
    return ProductData(
      page: page,
      limit: limit,
      data: result.items,
      lastPage: result.lastPage,
    );
  }
}
