import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/loaders/shimmer_effect.dart';
import 'package:flutter/material.dart';

class TProfileDetailsShimmer extends StatelessWidget {
  const TProfileDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TShimmerEffect(width: 80, height: 80, radius: 80),
        const SizedBox(height: TSizes.spaceBtwItem / 2),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItem),
        for (int i = 0; i < 5; i++) ...[
          const TShimmerEffect(width: double.infinity, height: 18),
          const SizedBox(height: TSizes.spaceBtwItem),
        ],
      ],
    );
  }
}
