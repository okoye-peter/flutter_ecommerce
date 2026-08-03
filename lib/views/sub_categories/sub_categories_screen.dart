import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/images/rounded_image.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/products/product_card_horizontal.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/viewmodels/categories/category_viewmodel.dart';
import 'package:ecommerce/viewmodels/products/category_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoriesScreen extends ConsumerWidget {
  const SubCategoriesScreen({super.key, this.categoryId});

  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider).value ?? [];
    final category = categoryId == null
        ? null
        : categories.where((cat) => cat.id == categoryId).firstOrNull;
    final subCategories = categoryId == null
        ? const <CategoryModel>[]
        : categories.where((cat) => cat.parentId == categoryId).toList();

    return Scaffold(
      appBar: TAppBar(
        title: Text(category?.name ?? 'Sports shirts'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              TRoundedImage(
                width: double.infinity,
                height: null,
                imageUrl: TImages.subCategoryBanner,
                applyImageRadius: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // sub-categories
              // if (subCategories.isNotEmpty)
              //   Column(
              //     children: [
              //       // - Heading
              //       // TSectionHeading(title: 'Sub Categories', showActionButton: false),
              //       // const SizedBox(height: TSizes.spaceBtwItem / 2),

              //       SizedBox(
              //         height: 80,
              //         child: ListView.separated(
              //           itemCount: subCategories.length,
              //           scrollDirection: Axis.horizontal,
              //           separatorBuilder: (context, index) =>
              //               const SizedBox(width: TSizes.spaceBtwItem),
              //           itemBuilder: (context, index) {
              //             final subCategory = subCategories[index];
              //             return TRoundedImage(
              //               imageUrl: subCategory.image,
              //               isNetworkImage: true,
              //               width: 80,
              //               height: 80,
              //               applyImageRadius: true,
              //             );
              //           },
              //         ),
              //       ),
              //       const SizedBox(height: TSizes.spaceBtwSections),
              //     ],
              //   ),

              // products by sub-category
              if (subCategories.isNotEmpty)
                Column(
                  children: [
                    for (final subCategory in subCategories) ...[
                      _SubCategoryProducts(subCategory: subCategory),
                      const SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ],
                )
              else if (categoryId != null)
                Consumer(
                  builder: (context, ref, _) {
                    final products = ref.watch(
                      categoryProductsProvider(categoryId!),
                    );

                    return products.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => TErrorRetryWidget(
                        message: error.toString(),
                        onRetry: () => ref.invalidate(
                          categoryProductsProvider(categoryId!),
                        ),
                      ),
                      data: (products) {
                        if (products.isEmpty) {
                          return const Center(
                            child: Text('No products found.'),
                          );
                        }
                        return SizedBox(
                          height: 120,
                          child: ListView.separated(
                            itemCount: products.length,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: TSizes.spaceBtwItem),
                            itemBuilder: (context, index) =>
                                TProductCardHorizontal(
                                  product: products[index],
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubCategoryProducts extends ConsumerWidget {
  const _SubCategoryProducts({required this.subCategory});

  final CategoryModel subCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(categoryProductsProvider(subCategory.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: subCategory.name, showActionButton: false),
        const SizedBox(height: TSizes.spaceBtwItem / 2),
        products.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => TErrorRetryWidget(
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(categoryProductsProvider(subCategory.id)),
          ),
          data: (products) {
            if (products.isEmpty) {
              return const Text('No products found.');
            }
            return SizedBox(
              height: 120,
              child: ListView.separated(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: TSizes.spaceBtwItem),
                itemBuilder: (context, index) =>
                    TProductCardHorizontal(product: products[index]),
              ),
            );
          },
        ),
      ],
    );
  }
}
