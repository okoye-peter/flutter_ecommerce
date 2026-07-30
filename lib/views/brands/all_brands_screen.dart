import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/brands/brand_card.dart';
import 'package:ecommerce/core/widgets/brands/brand_card_shimmer.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/viewmodels/brands/brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AllBrandsScreen extends ConsumerWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandAsyncValue = ref.watch(brandControllerProvider);
    return Scaffold(
      appBar: TAppBar(title: Text('Brands'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // - Heading
              TSectionHeading(title: 'Brands'),
              const SizedBox(height: TSizes.spaceBtwItem),

              // - Brands
              brandAsyncValue.when(
                loading: () => TGridLayout(
                  itemCount: 6,
                  mainAxisExtent: 80,
                  itemBuilder: (_, _) => const TBrandCardShimmer(),
                ),
                error: (error, stackTrace) => TErrorRetryWidget(
                  message: error.toString(),
                  onRetry: () => ref.invalidate(brandControllerProvider),
                ),
                data: (brands) {
                  if (brands.isEmpty) {
                    return const Center(child: Text('No brands found.'));
                  }
                  return TGridLayout(
                    itemCount: brands.length,
                    mainAxisExtent: 80.0,
                    itemBuilder: (context, index) {
                      final brand = brands[index];
                      return TBrandCard(
                        image: brand.image,
                        title: brand.name,
                        productCount: '${brand.productsCount ?? 0} products',
                        onTap: () =>
                            context.push(AppRoutes.brandProducts(brand.id)),
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
