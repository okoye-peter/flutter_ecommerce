import 'dart:async';

import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationState {
  const EmailVerificationState({this.isVerified = false});

  final bool isVerified;
}

class EmailVerificationController
    extends AutoDisposeNotifier<EmailVerificationState> {
  Timer? _pollTimer;

  @override
  EmailVerificationState build() {
    sendEmailVerification();
    _pollTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => checkEmailVerified(),
    );
    ref.onDispose(() => _pollTimer?.cancel());
    return const EmailVerificationState();
  }

  // manually check if email is verified
  Future<void> checkEmailVerified() async {
    final verified = await ref
        .read(authRepositoryProvider)
        .reloadAndCheckEmailVerified();
    if (verified) {
      _pollTimer?.cancel();
      state = const EmailVerificationState(isVerified: true);
    }
  }

  // send email verification link
  Future<void> sendEmailVerification() async {
    try {
      await ref.read(authRepositoryProvider).sendEmailVerification();
      TSnacksLoader.successSnackBar(
        title: 'Email Sent',
        message: 'Please check your inbox to verify your email',
      );
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

final emailVerificationProvider = NotifierProvider.autoDispose<
  EmailVerificationController,
  EmailVerificationState
>(EmailVerificationController.new);
