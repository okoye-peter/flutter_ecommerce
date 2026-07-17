import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/products/product_price_and_add_to_cart.dart';
import 'package:ecommerce/views/cart/widgets/cart_item.dart';
import 'package:ecommerce/views/cart/widgets/cart_quantity_control.dart';
import 'package:flutter/material.dart';

class TCartList extends StatelessWidget {
  const TCartList({super.key, this.showQuantityControl = true});

  final bool showQuantityControl;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (context, index) =>
          const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (BuildContext _, int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TCartItem(dark: dark),
          const SizedBox(height: TSizes.spaceBtwItem),
          if (showQuantityControl)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // item quantity control
                TCartQuantityControl(dark: dark),
                // Price
                TProductPriceText(price: '256'),
              ],
            ),
        ],
      ),
    );
  }
}
