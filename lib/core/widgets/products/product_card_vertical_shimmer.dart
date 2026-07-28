import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Skeleton placeholder matching [TProductCardVertical]'s layout, shown
/// while featured/product-list data is still loading.
class TProductCardVerticalShimmer extends StatelessWidget {
  const TProductCardVerticalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // thumbnail placeholder
            Container(
              height: 180 - TSizes.sm * 2,
              width: double.infinity,
              margin: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItem / 2),

            // title + brand placeholders
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 130, height: 12, color: Colors.white),
                  const SizedBox(height: TSizes.spaceBtwItem / 2),
                  Container(width: 80, height: 10, color: Colors.white),
                ],
              ),
            ),

            const Spacer(),

            // price + add-to-cart placeholders
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 50, height: 14, color: Colors.white),
                  Container(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRadiusMd),
                        bottomRight: Radius.circular(TSizes.productImageRadius),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
