import 'dart:async';

import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/loaders/animation_loader.dart';
import 'package:flutter/material.dart';

/// Utility for showing/hiding a full-screen, non-dismissible loading dialog.
class TFullScreenLoader {
  const TFullScreenLoader._();

  static bool _isShowing = false;

  static void openLoadingDialog(String text, {String? animation}) {
    final context = rootNavigatorKey.currentContext!;

    _isShowing = true;
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
      // Fires no matter how the dialog route ends up closed — including a
      // go_router redirect (e.g. logout) tearing down the stack out from
      // under it — so this stays in sync with reality even when nothing
      // here called pop() itself.
    ).then((_) => _isShowing = false);
  }

  /// Closes the loading dialog. The returned future completes once the pop
  /// has actually happened, so callers that need to navigate afterwards can
  /// `await` it to avoid pushing a new route on top of the still-open dialog.
  static Future<void> stopLoading() {
    final completer = Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // A redirect (e.g. auth-state-driven logout) may have already closed
      // the dialog by replacing the whole route stack. Popping again here
      // would then pop whatever page is left instead, which can empty the
      // stack entirely and crash go_router.
      if (_isShowing) {
        final navigator = Navigator.of(
          rootNavigatorKey.currentContext!,
          rootNavigator: true,
        );
        if (navigator.canPop()) {
          navigator.pop();
        }
      }
      completer.complete();
    });
    return completer.future;
  }
}
