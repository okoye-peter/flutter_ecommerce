import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/icons/circular_icon.dart';
import 'package:flutter/material.dart';

class TCartQuantityControl extends StatelessWidget {
  const TCartQuantityControl({
    super.key,
    required this.dark, this.onAdd, this.onRemove, required this.quantity,
  });

  final bool dark;
  final VoidCallback? onAdd, onRemove;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 70,),
        // Add Remove Buttons
        TCircularIcon(
          icon: Icons.remove,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: dark ? TColors.white : TColors.black,
          backgroundColor: dark ? TColors.darkerGrey : TColors.light,
          onPressed: quantity >= 1 ? onRemove : null,
        ),
    
        const SizedBox(width: TSizes.spaceBtwItem,),
        Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: TSizes.spaceBtwItem,),
    
        TCircularIcon(
          icon: Icons.add,
          width: 32,
          height: 32,
          size: TSizes.md,
          color: TColors.white,
          backgroundColor: TColors.primary,
          onPressed: onAdd,
        ),
      ],
    );
  }
}