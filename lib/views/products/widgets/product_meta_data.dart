import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/enums.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/pricing_helper.dart';
import 'package:ecommerce/core/widgets/images/circular_image.dart';
import 'package:ecommerce/core/widgets/products/product_price_and_add_to_cart.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce/core/widgets/texts/product_title_text.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/viewmodels/products/details/variation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TProductMetaData extends ConsumerWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variation = ref.watch(variationControllerProvider).resolvedVariation;
    final price = variation?.price ?? product.price;
    final salePrice = variation?.salePrice ?? product.salePrice;
    final salePercentage = TPricingHelper.calculateSalePercentage(
      price,
      salePrice,
    );
    final hasSale = salePercentage != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price & Sale Price
        Row(
          children: [
            // sale Tag
            if (hasSale) ...[
              TRoundedContainer(
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
                  ).textTheme.labelLarge!.apply(color: TColors.black),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItem),

              // Price
              Text(
                '\$$price',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItem),
            ],

            TProductPriceText(
              price: TPricingHelper.getProductPrice(product, variation: variation),
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItem / 1.5),

        // Title
        TProductTitleText(title: product.title),
        const SizedBox(height: TSizes.spaceBtwItem / 1.5),

        // Stock Status
        if (product.productType == ProductType.single.name)
          Row(
            children: [
              const TProductTitleText(title: 'Status'),
              const SizedBox(width: TSizes.spaceBtwItem),
              Text(
                TPricingHelper.getProductStockStatus(product.stock),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        const SizedBox(height: TSizes.spaceBtwItem / 1.5),

        // Brand
        if (product.brand != null)
          Row(
            children: [
              TCircularImage(
                image: product.brand?.image ?? '',
                isNetworkImage: product.brand != null,
                height: 32,
                width: 32,
              ),
              TBrandTitleWithVerifiedIcon(
                title: product.brand?.name ?? '',
                brandTextSizes: TextSizes.medium,
              ),
            ],
          ),
      ],
    );
  }
}
