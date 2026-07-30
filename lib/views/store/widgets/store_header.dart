import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/brands/brand_card.dart';
import 'package:ecommerce/core/widgets/brands/brand_card_shimmer.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/search/search_container.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/viewmodels/brands/brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TStoreHeader extends ConsumerWidget {
  const TStoreHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(brandControllerProvider);
    final controller = ref.read(brandControllerProvider.notifier);
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: TSizes.spaceBtwItem),
        GestureDetector(
          onTap: () => context.push(AppRoutes.search),
          child: const TSearchContainer(
            text: '',
            showBorder: true,
            showBackground: false,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TSectionHeading(
          title: 'Feature Brands',
          onPressed: () => context.push(AppRoutes.brands),
        ),
        const SizedBox(height: TSizes.spaceBtwItem / 1.5),

        brands.when(
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
            final featuredBrand = controller.getFeaturedBrands();
            if (featuredBrand.isEmpty) {
              return const Center(child: Text('No featured brands yet.'));
            }
            return TGridLayout(
              itemCount: featuredBrand.length,
              mainAxisExtent: 80,
              itemBuilder: (_, index) {
                final brand = featuredBrand[index];
                return TBrandCard(
                  image: brand.image,
                  title: brand.name,
                  productCount: '${brand.productsCount ?? 0} products',
                  onTap: () => context.push(AppRoutes.brandProducts(brand.id)),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
