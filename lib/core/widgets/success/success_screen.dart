import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:ecommerce/core/styles/spacing_styles.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight(context) * 2,
          child: Column(
            children: [
              Image(
                image: AssetImage(image),
                width: THelperFunctions.screenWidth(context) * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItem),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItem),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(TTexts.tContinue),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItem),
            ],
          ),
        ),
      ),
    );
  }
}
