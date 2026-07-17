import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/enums.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/images/rounded_image.dart';
import 'package:ecommerce/core/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/core/widgets/texts/product_title_text.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image
        TRoundedImage(
          imageUrl: TImages.productImage3,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: dark ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(width: 15,),
        // Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleWithVerifiedIcon(title: 'Nike', brandTextSizes: TextSizes.small,),
              Flexible(child: TProductTitleText(title: 'Black sport shoes sslkfa f okkclcalkcsclkk.  jjascj a d. nfonoin fn ncnoci', maxLines: 1)),
              // - Attributes
              Text.rich(
                TextSpan(children: [
                  TextSpan(text: 'Color', style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: 'Green', style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: 'Size', style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(text: 'UK 08', style: Theme.of(context).textTheme.bodyLarge),
                ])
              )
            ],
          ),
        )
      ],
    );
  }
}
