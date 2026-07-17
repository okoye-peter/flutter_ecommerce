import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/utils/device/device_utility.dart';
import 'package:ecommerce/viewmodels/auth/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingNextButton extends ConsumerWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);
    final notifier = ref.read(onboardingProvider.notifier);
    final isLastPage = ref.watch(
      onboardingProvider.select(
        (i) => i == OnboardingNotifier.pages.length - 1,
      ),
    );

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () {
          if (!isLastPage) {
            notifier.nextPage();
            return;
          }
          ref.read(localStorageProvider).completeOnboarding();
          context.go(AppRoutes.login);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.primary : TColors.dark,
          side: BorderSide(color: dark ? TColors.primary : TColors.dark),
        ),
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
