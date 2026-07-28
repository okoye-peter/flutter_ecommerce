import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/helpers/pricing_helper.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/styles/shadow.dart';
import 'package:ecommerce/core/widgets/images/rounded_image.dart';
import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:ecommerce/core/widgets/products/product_price_and_add_to_cart.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/texts/brand_title_text.dart';
import 'package:ecommerce/core/widgets/texts/product_title_text.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TProductCardVertical extends ConsumerWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);
    final salePercentage = TPricingHelper.calculateSalePercentage(
      product.price,
      product.salePrice,
    );

    return GestureDetector(
      onTap: () => context.push(AppRoutes.productDetails(product.id)),
      child: Container(
        width: 180,
        // padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white,
        ),

        child: Column(
          children: [
            // thumbnail, wishlist button, discount tag
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  // Thumbnail images
                  TRoundedImage(
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                    fit: BoxFit.contain,
                  ),

                  // Sale tag
                  if (salePercentage != null)
                    Positioned(
                      top: 8,
                      left: 5,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withAlpha(204),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm,
                          vertical: TSizes.xs,
                        ),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.copyWith(color: TColors.black),
                        ),
                      ),
                    ),

                  // Favorite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: const TCircularIcon(
                      icon: Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItem / 2),

            // details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: product.title, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItem / 2),
                  Row(
                    children: [
                      TBrandTitleText(title: product.brand!.name),
                      const SizedBox(width: TSizes.xs),
                      Icon(
                        Icons.check_circle,
                        size: TSizes.iconXs,
                        color: TColors.primary,
                      ),
                    ],
                  ),

                  // const SizedBox(height: TSizes.spaceBtwItem / 2),
                ],
              ),
            ),

            Spacer(),

            // Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(
                    price: TPricingHelper.getProductPrice(product),
                  ),
                ),

                // add to cart
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: const Icon(Icons.add, color: TColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
