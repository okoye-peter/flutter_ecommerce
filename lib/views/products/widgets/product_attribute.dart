import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/products/product_price_and_add_to_cart.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/texts/product_title_text.dart';
import 'package:ecommerce/core/widgets/products/choice_chip.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/product_variation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TProductAttributes extends StatefulWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  State<TProductAttributes> createState() => _TProductAttributesState();
}

class _TProductAttributesState extends State<TProductAttributes> {
  late Map<String, String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = _initialSelection();
  }

  Map<String, String> _initialSelection() {
    final variations = widget.product.productVariations ?? [];
    if (variations.isNotEmpty) return Map.of(variations.first.attributeValues);

    final selection = <String, String>{};
    for (final attribute in widget.product.productAttributes ?? []) {
      if (attribute.name != null && (attribute.values?.isNotEmpty ?? false)) {
        selection[attribute.name!] = attribute.values!.first;
      }
    }
    return selection;
  }

  ProductVariationModel? get _selectedVariation {
    for (final variation in widget.product.productVariations ?? const []) {
      if (mapEquals(variation.attributeValues, _selected)) return variation;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final attributes = widget.product.productAttributes ?? [];
    if (attributes.isEmpty) return const SizedBox.shrink();

    final dark = THelperFunctions.isDarkMode(context);
    final variation = _selectedVariation;
    final price = variation?.price ?? widget.product.price;
    final salePrice = variation?.salePrice ?? widget.product.salePrice;
    final hasSale = salePrice > 0 && salePrice < price;
    final stock = variation?.stock ?? widget.product.stock;
    final description = (variation?.description?.isNotEmpty ?? false)
        ? variation!.description!
        : (widget.product.description ?? '');

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
            Padding(
              padding: const EdgeInsets.only(top: TSizes.spaceBtwItem),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TSectionHeading(
                    title: attribute.name!,
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem / 2),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final value in attribute.values!)
                        TChoiceChip(
                          text: value,
                          selected: _selected[attribute.name!] == value,
                          onSelected: (_) => setState(() {
                            _selected[attribute.name!] = value;
                          }),
                        ),
                    ],
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
