import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/loaders/animation_loader.dart';
import 'package:flutter/material.dart';

/// Utility for showing/hiding a full-screen, non-dismissible loading dialog.
class TFullScreenLoader {
  const TFullScreenLoader._();

  static void openLoadingDialog(String text, {String? animation}) {
    final context = rootNavigatorKey.currentContext!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(context)
              ? TColors.dark
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: TAnimationLoaderWidget(text: text, animation: animation),
        ),
      ),
    );
  }

  static void stopLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigator = Navigator.of(
        rootNavigatorKey.currentContext!,
        rootNavigator: true,
      );
      if (navigator.canPop()) {
        navigator.pop();
      }
    });
  }
}
