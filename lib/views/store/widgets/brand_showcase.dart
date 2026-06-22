import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/brands/brand_card.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/brand_model.dart';
import 'package:flutter/material.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
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
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItem),
      child: Column(
        children: [
          TBrandCard(
            image: brand.image,
            title: brand.title,
            productCount: brand.products,
            showBorder: false,
          ),
          Row(
            children: [imgUrl1, imgUrl2, imgUrl3]
                .map((url) => _BrandProductImage(imageUrl: url, dark: dark))
                .toList(),
          ),

          // products
          TSectionHeading(title: 'You might like', onPressed: () {},),
        ],
      ),
    );
  }
}

class _BrandProductImage extends StatelessWidget {
  const _BrandProductImage({required this.imageUrl, required this.dark});

  final String imageUrl;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        backgroundColor: dark ? TColors.darkGrey : TColors.light,
        margin: const EdgeInsets.only(right: TSizes.sm),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(TSizes.md),
          child: Image(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
