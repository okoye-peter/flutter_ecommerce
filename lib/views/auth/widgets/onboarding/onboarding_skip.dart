import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/viewmodels/auth/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingSkip extends ConsumerWidget {
  const OnboardingSkip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingProvider.notifier);

    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          notifier.skipPage();
          ref.read(localStorageProvider).completeOnboarding();
        },
        child: const Text('Skip'),
      ),
    );
  }
}
