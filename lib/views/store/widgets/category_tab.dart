import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/grids/grid_layout.dart';
import 'package:ecommerce/core/widgets/products/product_card_vertical.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/brand_model.dart';
import 'package:ecommerce/viewmodels/products/featured_products_controller.dart';
import 'package:ecommerce/views/store/widgets/brand_showcase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TCategoryTab extends ConsumerWidget {
  const TCategoryTab({
    super.key,
    required this.brand,
    required this.imgUrl1,
    required this.imgUrl2,
    required this.imgUrl3,
  });

  final BrandModel brand;
  final String imgUrl1;
  final String imgUrl2;
  final String imgUrl3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredProducts = ref.watch(featuredProductsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          TBrandShowCase(
            imgUrl1: imgUrl1,
            imgUrl2: imgUrl2,
            imgUrl3: imgUrl3,
            brand: brand,
          ),

          const SizedBox(height: TSizes.spaceBtwItem),

          TSectionHeading(title: 'You may also like', onPressed: () {},),

          const SizedBox(height: TSizes.spaceBtwItem),

          featuredProducts.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text(error.toString()),
            data: (products) {
              if (products.isEmpty) return const Center(child: Text('No Data!'));
              return TGridLayout(
                itemCount: products.length,
                mainAxisExtent: 276,
                itemBuilder: (_, index) => TProductCardVertical(product: products[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
