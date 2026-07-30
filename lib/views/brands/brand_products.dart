import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/brands/brand_card.dart';
import 'package:ecommerce/core/widgets/products/sortable_products.dart';
import 'package:ecommerce/viewmodels/brands/brand_controller.dart';
import 'package:ecommerce/viewmodels/brands/brand_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandProductsScreen extends ConsumerWidget {
  const BrandProductsScreen({super.key, required this.brandId});

  final String brandId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(brandControllerProvider);
    final brand = brands
        .whenData((brands) => brands.firstWhere((b) => b.id == brandId))
        .value;

    final products = ref.watch(brandProductsProvider(brandId));

    return Scaffold(
      appBar: TAppBar(title: Text(brand?.name ?? ''), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Brand Details
              TBrandCard(
                image: brand?.image ?? '',
                title: brand?.name ?? '',
                productCount: '${brand?.productsCount ?? 0} products',
                showBorder: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              TSortableProducts(
                products: products,
                onRetry: () => ref.invalidate(brandProductsProvider(brandId)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
