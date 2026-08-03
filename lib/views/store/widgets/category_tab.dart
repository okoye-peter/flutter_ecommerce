import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/viewmodels/products/category_products_provider.dart';
import 'package:ecommerce/views/store/widgets/category_brands.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TCategoryTab extends ConsumerWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryProducts = ref.watch(categoryProductsProvider(category.id));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          CategoryBrands(category: category),

          const SizedBox(height: TSizes.spaceBtwItem),
          

          TSectionHeading(title: 'You may also like', onPressed: () {}),

          const SizedBox(height: TSizes.spaceBtwItem),

          categoryProducts.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => TErrorRetryWidget(
              message: error.toString(),
              onRetry: () =>
                  ref.invalidate(categoryProductsProvider(category.id)),
            ),
            data: (products) {
              if (products.isEmpty) {
                return const Center(child: Text('No Data!'));
              }
              return TGridLayout(
                itemCount: products.length,
                itemBuilder: (_, index) =>
                    TProductCardVertical(product: products[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
