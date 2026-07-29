import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/products/product_price_and_add_to_cart.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/texts/product_title_text.dart';
import 'package:ecommerce/core/widgets/products/choice_chip.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/product_attribute_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/viewmodels/products/details/variation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TProductAttributes extends ConsumerWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attributes = product.productAttributes ?? [];
    if (attributes.isEmpty) return const SizedBox.shrink();

    final controller = ref.read(variationControllerProvider.notifier);
    final variationState = ref.watch(variationControllerProvider);
    final selected = variationState.selectedAttributes;
    final variation = variationState.resolvedVariation;

    final dark = THelperFunctions.isDarkMode(context);
    final price = variation?.price ?? product.price;
    final salePrice = variation?.salePrice ?? product.salePrice;
    final hasSale = salePrice > 0 && salePrice < price;
    final stock = variation?.stock ?? product.stock;
    final description = (variation?.description?.isNotEmpty ?? false)
        ? variation!.description!
        : (product.description ?? '');

    return Column(
      children: [
        TRoundedContainer(
          padding: EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title, Price, and Stock Status
              Row(
                children: [
                  const TSectionHeading(
                    title: 'Variation',
                    showActionButton: false,
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

                          if (hasSale) ...[
                            Text(
                              '\$$price',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .apply(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwItem),
                          ],

                          TProductPriceText(
                            price: (hasSale ? salePrice : price).toString(),
                          ),
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
                            stock > 0 ? 'In Stock' : 'Out of Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              if (description.isNotEmpty) ...[
                const SizedBox(height: TSizes.spaceBtwItem),
                TProductTitleText(
                  title: description,
                  maxLines: 4,
                  smallSize: true,
                ),
              ],
            ],
          ),
        ),

        for (final attribute in attributes)
          if (attribute.name != null && (attribute.values?.isNotEmpty ?? false))
            _buildAttributeSection(controller, selected, attribute),
      ],
    );
  }

  Widget _buildAttributeSection(
    VariationController controller,
    Map<String, String> selected,
    ProductAttributeModel attribute,
  ) {
    final availableValues = controller.getAttributesAvailabilityInVariation(
      product.productVariations ?? [],
      attribute.name!,
    );

    return Padding(
      padding: const EdgeInsets.only(top: TSizes.spaceBtwItem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHeading(title: attribute.name!, showActionButton: false),
          const SizedBox(height: TSizes.spaceBtwItem / 2),
          Wrap(
            spacing: 8,
            children: [
              for (final value in attribute.values!)
                TChoiceChip(
                  text: value,
                  selected: selected[attribute.name!] == value,
                  onSelected: availableValues.contains(value)
                      ? (_) => controller.onSelectAttribute(
                          product,
                          attribute.name!,
                          value,
                        )
                      : null,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
