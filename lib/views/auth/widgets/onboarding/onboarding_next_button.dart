import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/utils/device/device_utility.dart';
import 'package:ecommerce/viewmodels/auth/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = OnboardingController.instance;
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => controller.isLastPage
            ? context.go(AppRoutes.login)
            : controller.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.primary : TColors.dark,
          // elevation: 0,
          // shadowColor: Colors.transparent,
          side: BorderSide(color: dark ? TColors.primary : TColors.dark),
        ),
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
