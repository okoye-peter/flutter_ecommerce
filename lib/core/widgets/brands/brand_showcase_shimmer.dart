import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/brands/brand_card_shimmer.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Skeleton placeholder matching [TBrandShowCase]'s layout, shown while
/// a brand's products are still loading.
class TBrandShowCaseShimmer extends StatelessWidget {
  const TBrandShowCaseShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItem),
      child: Column(
        children: [
          const TBrandCardShimmer(showBorder: false),
          const SizedBox(height: TSizes.spaceBtwItem),
          Row(
            children: List.generate(
              3,
              (_) => Expanded(
                child: Shimmer.fromColors(
                  baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
                  highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(right: TSizes.sm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(TSizes.md),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          Shimmer.fromColors(
            baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
            highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 120, height: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
