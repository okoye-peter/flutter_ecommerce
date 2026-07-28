import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:ecommerce/viewmodels/products/featured_products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TSortableProducts extends ConsumerWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredProducts = ref.watch(featuredProductsProvider);

    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.sort)),
          items:
              [
                    'name',
                    'Higher Price',
                    'Lower Price',
                    'Sale',
                    'Newest',
                    'Popularity',
                  ]
                  .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
          onChanged: (value) {},
        ),

        const SizedBox(height: TSizes.spaceBtwSections,),

        // Products
        featuredProducts.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(error.toString()),
          data: (products) {
            if (products.isEmpty) return const Center(child: Text('No Data!'));
            return TGridLayout(
              itemCount: products.length,
              itemBuilder: (context, index) => TProductCardVertical(product: products[index]),
            );
          },
        ),
      ],
    );
  }
}
