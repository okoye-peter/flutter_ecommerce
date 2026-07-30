import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical_shimmer.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/viewmodels/products/featured_products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _sortOptions = [
  'name',
  'Higher Price',
  'Lower Price',
  'Sale',
  'Newest',
  'Popularity',
];

class TSortableProducts extends ConsumerStatefulWidget {
  const TSortableProducts({super.key, this.products, this.onRetry});

  /// Products to display. When omitted, falls back to [featuredProductsProvider].
  final AsyncValue<List<ProductModel>>? products;

  /// Called when the user taps retry after an error. When [products] is
  /// omitted, defaults to invalidating [featuredProductsProvider]; callers
  /// that pass [products] from their own provider should pass this too.
  final VoidCallback? onRetry;

  @override
  ConsumerState<TSortableProducts> createState() => _TSortableProductsState();
}

class _TSortableProductsState extends ConsumerState<TSortableProducts> {
  String _sortBy = _sortOptions.first;

  double _effectivePrice(ProductModel product) =>
      product.salePrice > 0 ? product.salePrice : product.price;

  List<ProductModel> _sortProducts(List<ProductModel> products) {
    final sorted = [...products];
    switch (_sortBy) {
      case 'name':
        sorted.sort((a, b) => a.title.compareTo(b.title));
      case 'Higher Price':
        sorted.sort((a, b) => _effectivePrice(b).compareTo(_effectivePrice(a)));
      case 'Lower Price':
        sorted.sort((a, b) => _effectivePrice(a).compareTo(_effectivePrice(b)));
      case 'Sale':
        sorted.retainWhere((p) => p.salePrice > 0 && p.salePrice < p.price);
      case 'Newest':
        sorted.sort(
          (a, b) => (b.date ?? DateTime(0)).compareTo(a.date ?? DateTime(0)),
        );
      case 'Popularity':
        // No popularity/sales metric in ProductModel yet — featured status is the closest proxy.
        sorted.sort(
          (a, b) => (b.isFeatured == true ? 1 : 0).compareTo(
            a.isFeatured == true ? 1 : 0,
          ),
        );
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ProductModel>> featuredProducts =
        widget.products ?? ref.watch(featuredProductsProvider);

    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.sort)),
          initialValue: _sortBy,
          items: _sortOptions
              .map(
                (option) =>
                    DropdownMenuItem(value: option, child: Text(option)),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            setState(() => _sortBy = value);
          },
        ),

        const SizedBox(height: TSizes.spaceBtwSections),

        // Products
        featuredProducts.when(
          loading: () => TGridLayout(
            itemCount: 6,
            itemBuilder: (_, _) => const TProductCardVerticalShimmer(),
          ),
          error: (error, stackTrace) => TErrorRetryWidget(
            message: error.toString(),
            onRetry:
                widget.onRetry ??
                (() => ref.invalidate(featuredProductsProvider)),
          ),
          data: (products) {
            if (products.isEmpty) return const Center(child: Text('No Data!'));
            final sorted = _sortProducts(products);
            return TGridLayout(
              itemCount: sorted.length,
              itemBuilder: (context, index) =>
                  TProductCardVertical(product: sorted[index]),
            );
          },
        ),
      ],
    );
  }
}
