import 'package:ecommerce/viewmodels/auth/onboarding_viewmodel.dart';
import 'package:ecommerce/views/auth/widgets/onboarding/onboarding_navigation.dart';
import 'package:ecommerce/views/auth/widgets/onboarding/onboarding_next_button.dart';
import 'package:ecommerce/views/auth/widgets/onboarding/onboarding_page.dart';
import 'package:ecommerce/views/auth/widgets/onboarding/onboarding_skip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.pages.length,
            onPageChanged: controller.updatePageIndicator,
            itemBuilder: (_, index) =>
                OnboardingPage(page: controller.pages[index]),
          ),
          const OnboardingSkip(),
          const OnboardingNavigation(),
          const OnboardingNextButton(),
        ],
      ),
    );
  }
}
