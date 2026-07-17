import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/styles/shadow.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/curved_edges/curved_edge_widget.dart';
import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:ecommerce/core/widgets/images/rounded_image.dart';
import 'package:flutter/material.dart';

class TProductImagesSlider extends StatelessWidget {
  const TProductImagesSlider({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Image(
                  image: AssetImage(TImages.productImage11),
                  fit: BoxFit.contain,
                ),
              )
            ),

            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(TSizes.md),
                      boxShadow: [TShadowStyle.horizontalProductShadow],
                    ),
                    child: TRoundedImage(
                      imageUrl: TImages.productImage11,
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                      backgroundColor: dark ? TColors.dark : TColors.white,
                      padding: const EdgeInsets.all(TSizes.sm),
                    ),
                  ),
                  separatorBuilder: (_, _) => const SizedBox(width: TSizes.spaceBtwItem,),
                  itemCount: 6,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: TSizes.spaceBtwItem),
              child: TAppBar(
                showBackArrow: true,
                actions: [
                  TCircularIcon(icon: Icons.favorite, color: Colors.red)
                ],
              ),
            )
          ],
        )
      )
    );
  }
}
