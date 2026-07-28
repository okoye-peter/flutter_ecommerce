import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:ecommerce/viewmodels/products/featured_products_controller.dart';
import 'package:ecommerce/views/navigation/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredProducts = ref.watch(featuredProductsProvider);

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
            featuredProducts.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Text(error.toString()),
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
      ),
    );
  }
}
