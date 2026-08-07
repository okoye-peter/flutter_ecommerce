import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/loaders/shimmer_effect.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:flutter/material.dart';

/// Skeleton placeholder matching [OrderItem]'s layout, shown while the
/// orders list is still loading.
class OrderItemShimmer extends StatelessWidget {
  const OrderItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.light,
      padding: const EdgeInsets.all(TSizes.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const TShimmerEffect(width: 24, height: 24, radius: 12),
              const SizedBox(width: TSizes.spaceBtwItem / 2),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TShimmerEffect(width: 80, height: 14),
                    const SizedBox(height: TSizes.spaceBtwItem / 2),
                    const TShimmerEffect(width: 120, height: 16),
                  ],
                ),
              ),
              const TShimmerEffect(width: 16, height: 16, radius: 8),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const TShimmerEffect(width: 24, height: 24, radius: 12),
                    const SizedBox(width: TSizes.spaceBtwItem / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TShimmerEffect(width: 50, height: 10),
                          const SizedBox(height: TSizes.spaceBtwItem / 2),
                          const TShimmerEffect(width: 70, height: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const TShimmerEffect(width: 24, height: 24, radius: 12),
                    const SizedBox(width: TSizes.spaceBtwItem / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TShimmerEffect(width: 80, height: 10),
                          const SizedBox(height: TSizes.spaceBtwItem / 2),
                          const TShimmerEffect(width: 70, height: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
