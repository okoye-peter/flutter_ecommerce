import 'package:ecommerce/viewmodels/auth/onboarding_viewmodel.dart';
import 'package:ecommerce/views/auth/widgets/onboarding/onboarding_navigation.dart';
import 'package:ecommerce/views/auth/widgets/onboarding/onboarding_next_button.dart';
import 'package:ecommerce/views/auth/widgets/onboarding/onboarding_page.dart';
import 'package:ecommerce/views/auth/widgets/onboarding/onboarding_skip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: notifier.pageController,
            itemCount: OnboardingNotifier.pages.length,
            onPageChanged: notifier.updatePageIndicator,
            itemBuilder: (_, index) =>
                OnboardingPage(page: OnboardingNotifier.pages[index]),
          ),
          const OnboardingSkip(),
          const OnboardingNavigation(),
          const OnboardingNextButton(),
        ],
      ),
    );
  }
}
