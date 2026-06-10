import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:flutter/material.dart';

class TLoginSocialButtons extends StatelessWidget {
  const TLoginSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(TImages.google),
              width: TSizes.iconMd,
              height: TSizes.iconMd,
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItem),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(TImages.facebook),
              width: TSizes.iconMd,
              height: TSizes.iconMd,
            ),
          ),
        ),
      ],
    );
  }
}
