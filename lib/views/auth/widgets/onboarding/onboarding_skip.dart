import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/viewmodels/auth/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: controller.skipPage,
        child: const Text('Skip'),
      ),
    );
  }
}
