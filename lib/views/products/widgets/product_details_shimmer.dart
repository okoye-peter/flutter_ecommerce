import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/curved_edges/curved_edge_widget.dart';
import 'package:ecommerce/core/widgets/loaders/shimmer_effect.dart';
import 'package:flutter/material.dart';

/// Skeleton placeholder matching the product details screen's layout, shown
/// while the product is still loading.
class TProductDetailsShimmer extends StatelessWidget {
  const TProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // image slider placeholder
          TCurvedEdgeWidget(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
              child: const TShimmerEffect(
                width: double.infinity,
                height: 400,
                radius: TSizes.productImageRadius,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              right: TSizes.defaultSpace,
              left: TSizes.defaultSpace,
              top: TSizes.defaultSpace,
              bottom: TSizes.defaultSpace,
            ),
            child: Column(
              children: [
                // rating & share
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TShimmerEffect(width: 80, height: 16),
                    const TShimmerEffect(width: 24, height: 24, radius: 24),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItem),

                // price + sale tag
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TShimmerEffect(width: 40, height: 20),
                    const SizedBox(width: TSizes.spaceBtwItem),
                    const TShimmerEffect(width: 80, height: 24),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItem / 1.5),

                // title
                const Align(
                  alignment: Alignment.centerLeft,
                  child: TShimmerEffect(width: 220, height: 16),
                ),
                const SizedBox(height: TSizes.spaceBtwItem / 1.5),

                // stock status
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TShimmerEffect(width: 40, height: 14),
                    const SizedBox(width: TSizes.spaceBtwItem),
                    const TShimmerEffect(width: 60, height: 14),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItem / 1.5),

                // brand
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TShimmerEffect(width: 32, height: 32, radius: 32),
                    const SizedBox(width: TSizes.spaceBtwItem / 2),
                    const TShimmerEffect(width: 70, height: 14),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // checkout button
                const TShimmerEffect(
                  width: double.infinity,
                  height: 45,
                  radius: TSizes.borderRadiusMd,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // description heading + lines
                Align(
                  alignment: Alignment.centerLeft,
                  child: const TShimmerEffect(width: 120, height: 18),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TShimmerEffect(width: double.infinity, height: 12),
                const SizedBox(height: TSizes.spaceBtwItem / 2),
                const TShimmerEffect(width: double.infinity, height: 12),
                const SizedBox(height: TSizes.spaceBtwItem / 2),
                const TShimmerEffect(width: 180, height: 12),
                const SizedBox(height: TSizes.spaceBtwSections),

                // reviews heading
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwSections),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TShimmerEffect(width: 110, height: 18),
                    const TShimmerEffect(width: 18, height: 18),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
