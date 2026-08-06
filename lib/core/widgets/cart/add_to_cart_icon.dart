import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/enums.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/viewmodels/carts/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TAddToCartIcon extends ConsumerWidget {
  const TAddToCartIcon({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(cartControllerProvider);
    final controller =  ref.read(cartControllerProvider.notifier);
    int productCartQuantity = controller.getProductQuantityInCart(product.id);
        
    return InkWell(
      onTap: () {
        
        if(product.productType == ProductType.single.name) {
          controller.addToCart(product, 1);
        } else {
          context.push(AppRoutes.productDetails(product.id));
        }
        // Handle add to cart action here
      },
      child: Container(
        decoration:  BoxDecoration(
          color: productCartQuantity > 0  ? TColors.primary : TColors.dark,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusMd),
            bottomRight: Radius.circular(TSizes.productImageRadius),
          ),
        ),
        child: SizedBox(
          width: TSizes.iconLg * 1.2,
          height: TSizes.iconLg * 1.2,
          child: Center(
            child: productCartQuantity > 0 ? Text(productCartQuantity.toString() , style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.white),) : Icon(Icons.add, color: TColors.white),
          ),
        ),
      ),
    );
  }
}
