import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:flutter/material.dart';

/// Shows a small, dismiss-proof circular spinner centered over a dimmed
/// scrim — for quick in-place actions (e.g. selecting an address) where
/// [TFullScreenLoader]'s solid full-screen takeover would be too heavy.
class TLoadingOverlay {
  const TLoadingOverlay._();

  static void show() {
    final context = rootNavigatorKey.currentContext!;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black45,
      builder: (_) => Center(
        child: Container(
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          ),
          child: const SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: TColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  static void hide() {
    final navigator = Navigator.of(
      rootNavigatorKey.currentContext!,
      rootNavigator: true,
    );
    if (navigator.canPop()) navigator.pop();
  }
}
