import 'dart:async';

import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/loaders/full_screen_loader.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _resendCooldown = 60;

/// State is the number of seconds left before a resend is allowed; 0 means
/// resend is available.
class ForgotPasswordController extends Notifier<int> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  Timer? _resendTimer;

  @override
  int build() {
    ref.onDispose(() {
      _resendTimer?.cancel();
      emailController.dispose();
    });
    return 0;
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    state = _resendCooldown;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state <= 1) {
        timer.cancel();
        state = 0;
      } else {
        state--;
      }
    });
  }

  void sendPasswordResetEmail() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing request...',
        animation: TImages.loadingAnimation,
      );

      // check Internet Connectivity
      final isConnected = await ref.read(networkManagerProvider).isConnected();
      if (!isConnected) {
        await TFullScreenLoader.stopLoading();
        TSnacksLoader.errorSnackBar(title: 'No Internet Connection');
        // TAppToasts.error('No Internet Connection.');
        return;
      }

      if (!formKey.currentState!.validate()) {
        await TFullScreenLoader.stopLoading();
        return;
      }

      final email = emailController.text.trim();

      await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);

      // Close the dialog before pushing the next route — both live on the
      // same root navigator, so pushing first would leave the dialog's pop
      // closing the wrong (just-pushed) route instead.
      await TFullScreenLoader.stopLoading();

      TSnacksLoader.successSnackBar(
        title: 'Email Sent',
        message: 'Password reset link has been set to your email',
      );

      _startResendCooldown();

      ref
          .read(goRouterProvider)
          .push(
            '${AppRoutes.resetPassword}?email=${Uri.encodeComponent(email)}',
          );
    } catch (e) {
      await TFullScreenLoader.stopLoading();
      TSnacksLoader.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void resendPasswordResetEamil(String email) async {
    if (state > 0) return;

    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing request...',
        animation: TImages.loadingAnimation,
      );

      // check Internet Connectivity
      final isConnected = await ref.read(networkManagerProvider).isConnected();
      if (!isConnected) {
        TSnacksLoader.errorSnackBar(title: 'No Internet Connection');
        // TAppToasts.error('No Internet Connection.');
        return;
      }

      await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);

      TSnacksLoader.successSnackBar(
        title: 'Email Sent',
        message: 'Password reset link has been set to your email',
      );

      _startResendCooldown();
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}

final forgotPasswordProvider = NotifierProvider.autoDispose<ForgotPasswordController, int>(ForgotPasswordController.new);
