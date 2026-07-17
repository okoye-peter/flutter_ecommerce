import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Displays an animated loading indicator with optional text and action button.
class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget({
    super.key,
    required this.text,
    this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;

  /// Path to a Lottie animation asset. Falls back to a spinner when omitted.
  final String? animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final animation = this.animation;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (animation != null)
            Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8)
          else
            const CircularProgressIndicator(),
          const SizedBox(height: TSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.defaultSpace),
          if (showAction)
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(backgroundColor: TColors.dark),
                child: Text(
                  actionText!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.apply(color: TColors.white),
                ),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
