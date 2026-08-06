import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/core/widgets/loaders/error_retry_widget.dart';
import 'package:ecommerce/core/widgets/products/product_price_and_add_to_cart.dart';
import 'package:ecommerce/viewmodels/carts/cart_controller.dart';
import 'package:ecommerce/views/cart/widgets/cart_item.dart';
import 'package:ecommerce/views/cart/widgets/cart_quantity_control.dart';
import 'package:ecommerce/views/cart/widgets/remove_cart_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TCartList extends ConsumerWidget {
  const TCartList({super.key, this.showQuantityControl = true});

  final bool showQuantityControl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);
    final carts = ref.watch(cartControllerProvider);

    return carts.when(
      loading: () => const TAnimationLoaderWidget(
        text: 'Loading your cart...',
        animation: TImages.loadingAnimation,
      ),
      error: (_, _) => TErrorRetryWidget(
        message: 'Something went wrong loading your cart.',
        onRetry: () => ref.invalidate(cartControllerProvider),
      ),
      data: (items) {
        if (items.isEmpty) {
          return TAnimationLoaderWidget(
            text: 'Your cart is empty',
            animation: TImages.emptyCartAnimation,
            showAction: true,
            actionText: 'Shop Now',
            onActionPressed: () => context.push(AppRoutes.products),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          itemCount: items.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: TSizes.spaceBtwSections),
          itemBuilder: (BuildContext _, int index) {
            final cartItem = items[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TCartItem(dark: dark, cartItem: cartItem),
                const SizedBox(height: TSizes.spaceBtwItem),
                if (showQuantityControl)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // item quantity control
                      TCartQuantityControl(
                        dark: dark,
                        quantity: cartItem.quantity,
                        onAdd: () {
                          ref.read(cartControllerProvider.notifier).updateCartItemQuantity(
                                cartItem,
                                cartItem.quantity + 1,
                              );
                        },
                        onRemove: () {
                          if (cartItem.quantity - 1 <= 0) {
                            openRemoveCartItemConfirmation(
                              context,
                              ref,
                              cartItem: cartItem,
                            );
                            return;
                          }
                          ref.read(cartControllerProvider.notifier).updateCartItemQuantity(
                              cartItem,
                              cartItem.quantity - 1,
                          );
                        }
                      ),
                      // Price
                      TProductPriceText(price: (cartItem.price * cartItem.quantity).toStringAsFixed(2) ),
                    ],
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
