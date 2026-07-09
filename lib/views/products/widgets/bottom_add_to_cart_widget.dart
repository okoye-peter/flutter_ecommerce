import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:flutter/material.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.only(
        left: TSizes.defaultSpace,
        right: TSizes.defaultSpace,
        top: TSizes.defaultSpace / 2,
        bottom: TSizes.defaultSpace / 2 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(TSizes.cardRadiusLg),
        //   topRight: Radius.circular(TSizes.cardRadiusLg),
        // ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Icons.subway_rounded,
                backgroundColor: TColors.grey,
                width: 40,
                height: 40,
                color: TColors.white,
              ),
              const SizedBox(width: TSizes.spaceBtwItem),
              Text('2', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: TSizes.spaceBtwItem),
              TCircularIcon(
                icon: Icons.add,
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: TColors.white,
              ),
            ],
          ),

          ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(
              padding:  const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.black,
              side: const BorderSide(color: TColors.black)
            ), 
            child: const Text('Add to Cart')
          ),
        ],
      ),
    );
  }
}
