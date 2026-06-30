import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/products/product_price_and_add_to_cart.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/texts/product_title_text.dart';
import 'package:ecommerce/core/widgets/products/choice_chip.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        TRoundedContainer(
          padding: EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              // Title, Price, and Stock Status
              Row(
                children: [
                  const Expanded(
                    child: TSectionHeading(
                      title: 'Variation',
                      showActionButton: false,
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItem),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Price: ',
                            smallSize: true,
                          ),
                          const SizedBox(width: TSizes.spaceBtwItem),

                          // actual price
                          Text(
                            '\$25',
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.apply(),
                          ),

                          const SizedBox(width: TSizes.spaceBtwItem),

                          // sale price
                          TProductPriceText(price: '20'),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Stock: ',
                            smallSize: true,
                          ),
                          const SizedBox(width: TSizes.spaceBtwItem),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(width: TSizes.spaceBtwItem),

              // Variation
              const TProductTitleText(
                title:
                    'This is the Description of the Product and it can go up to 4 lines ',
                maxLines: 4,
                smallSize: true,
              ),
            ],
          ),
        ),

        const SizedBox(width: TSizes.spaceBtwItem),

        // Attribute
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: 'Colors', showActionButton: false),
            SizedBox(height: TSizes.spaceBtwItem / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                  text: 'Green',
                  selected: true,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'Indigo',
                  selected: true,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'Yellow',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
            // const TChoiceChip(text: '', selected: false),
          ],
        ),

        Column(
          children: [
            TSectionHeading(title: 'Sizes', showActionButton: false),
            SizedBox(height: TSizes.spaceBtwItem / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'EU 34', selected: true, onSelected: (value) {}),
                TChoiceChip(text: 'EU 36', selected: false, onSelected: (value) {}),
                TChoiceChip(text: 'Eu 36', selected: false, onSelected: (value) {}),
                TChoiceChip(text: 'EU 38', selected: false, onSelected: (value) {}),
              ],
            ),
            
          ],
        ),
      ],
    );
  }
}
