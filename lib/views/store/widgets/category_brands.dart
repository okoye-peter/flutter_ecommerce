import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/widgets/brands/brand_showcase_shimmer.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/viewmodels/brands/brand_category_provider.dart';
import 'package:ecommerce/viewmodels/brands/brand_products_provider.dart';
import 'package:ecommerce/views/store/widgets/brand_showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryBrands extends ConsumerWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(bransForCategoryProvider(category.id));

    return brands.when(
      loading: () => ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, _) => const TBrandShowCaseShimmer(),
      ),
      error: (_, _) => TErrorRetryWidget(
        message: 'Something went wrong loading brands.',
        onRetry: () => ref.invalidate(bransForCategoryProvider(category.id)),
      ),
      data: (brands) => brands.isEmpty
          ? const Center(child: Text('No brands found for this category.'))
          : ListView.builder(
              shrinkWrap: true,
              itemCount: brands.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final brand = brands[index];
                final brandProducts = ref.watch(
                  brandProductsProvider(brand.id, limit: 3),
                );
                return brandProducts.when(
                  loading: () => const TBrandShowCaseShimmer(),
                  error: (_, _) => TErrorRetryWidget(
                    message: 'Something went wrong loading products.',
                    onRetry: () =>
                        ref.invalidate(brandProductsProvider(brand.id, limit: 3)),
                  ),
                  data: (products) => TBrandShowCase(
                    brand: brand,
                    imgUrl1: products.isNotEmpty && products[0].thumbnail.isNotEmpty
                        ? products[0].thumbnail
                        : TImages.productImage1,
                    imgUrl2: products.length > 1 && products[1].thumbnail.isNotEmpty
                        ? products[1].thumbnail
                        : TImages.productImage2,
                    imgUrl3: products.length > 2 && products[2].thumbnail.isNotEmpty
                        ? products[2].thumbnail
                        : TImages.productImage3,
                  ),
                );
              },
            ),
    );
  }
}
