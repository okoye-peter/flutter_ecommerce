import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/models/cart_item_model.dart';
import 'package:ecommerce/viewmodels/carts/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows a warning dialog, then (on confirm) removes the item from the cart.
Future<void> openRemoveCartItemConfirmation(
  BuildContext context,
  WidgetRef ref, {
  required CartItemModel cartItem,
}) async {
  final dark = THelperFunctions.isDarkMode(context);

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: dark ? TColors.dark : TColors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg + 4),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          TSizes.lg,
          TSizes.lg,
          TSizes.lg,
          TSizes.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: TColors.error.withValues(alpha: 0.1),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: TColors.error,
                size: 28,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            Text(
              'Remove item?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.xs),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                    color: dark ? TColors.darkGrey : TColors.textSecondary,
                  ),
                  children: [
                    const TextSpan(text: '“'),
                    TextSpan(
                      text: cartItem.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(
                      text: '” will be removed from your cart.',
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: TSizes.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: dark
                            ? TColors.darkerGrey
                            : TColors.borderPrimary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          TSizes.cardRadiusMd,
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: dark ? TColors.white : TColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItem),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: TColors.error,
                      foregroundColor: TColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          TSizes.cardRadiusMd,
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'Remove',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  if (confirmed != true) return;

  ref.read(cartControllerProvider.notifier).updateCartItemQuantity(cartItem, 0);
}
