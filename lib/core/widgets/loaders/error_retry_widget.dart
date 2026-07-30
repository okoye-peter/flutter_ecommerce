import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Compact error message with an optional retry action, used in place of
/// raw `Text(error.toString())` wherever an [AsyncValue.when]'s `error`
/// branch renders.
class TErrorRetryWidget extends StatelessWidget {
  const TErrorRetryWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.textColor,
  });

  final String message;
  final VoidCallback? onRetry;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.spaceBtwItem),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: TSizes.iconLg,
              color: textColor ?? TColors.error,
            ),
            const SizedBox(height: TSizes.spaceBtwItem / 2),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.apply(color: textColor),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: TSizes.spaceBtwItem / 2),
              OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ],
        ),
      ),
    );
  }
}
