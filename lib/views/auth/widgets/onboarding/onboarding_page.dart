import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:ecommerce/models/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.page});

  final OnboardingModel page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image.asset(
            page.image,
            width: THelperFunctions.screenWidth(context) * 0.8,
            height: THelperFunctions.screenHeight(context) * 0.6,
          ),
          Text(
            page.title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.spaceBtwItem),
          Text(
            page.subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
