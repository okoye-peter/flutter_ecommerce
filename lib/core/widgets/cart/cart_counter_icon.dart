import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/viewmodels/carts/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TCartCounterIcon extends ConsumerWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
  });

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    ref.watch(cartControllerProvider);
    final controller = ref.read(cartControllerProvider.notifier);
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.shopping_bag_outlined, color: iconColor),
        ),
        Positioned(
          right: 3,
          top: 2,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: TColors.black.withAlpha(126),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                controller.getTotalCartItems(),
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  color: TColors.white,
                  fontSizeFactor: 0.8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
