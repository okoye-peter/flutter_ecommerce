import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:ecommerce/core/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical_shimmer.dart';
import 'package:ecommerce/viewmodels/products/favorites/favorite_products_controller.dart';
import 'package:ecommerce/views/navigation/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProducts = ref.watch(favoriteProductsControllerProvider);

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Icons.add,
            onPressed: () =>
                ref.read(navigationIndexProvider.notifier).state = 0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            favoriteProducts.when(
              loading: () => GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 304,
                  mainAxisSpacing: TSizes.gridViewSpacing,
                  crossAxisSpacing: TSizes.gridViewSpacing,
                ),
                itemBuilder: (_, _) => TProductCardVerticalShimmer(),
              ),
              error: (_, _) => TErrorRetryWidget(
                message: 'Something went wrong loading your wishlist.',
                onRetry: () => ref.invalidate(favoriteProductsControllerProvider),
              ),
              data: (products) {
                if (products.isEmpty) {
                  return const TAnimationLoaderWidget(
                    text: 'Nothing in your wishlist yet',
                    animation: TImages.emptyWishlistAnimation,
                  );
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
      ),
    );
  }
}
