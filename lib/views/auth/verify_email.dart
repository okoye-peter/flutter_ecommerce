import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/success/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // if (context.canPop()) {
              //   context.pop();
              // }
              context.go(AppRoutes.login);
            },
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // image
              Image(
                image: AssetImage(TImages.emailVerified),
                width: THelperFunctions.screenWidth(context) * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Title & SubTitle
              Text(
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItem),
              Text(
                'okoyepeter039@gmail.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItem),
              Text(
                TTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final router = GoRouter.of(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SuccessScreen(
                          image: TImages.successIllustrator,
                          title: TTexts.yourAccountCreatedTitle,
                          subtitle: TTexts.yourAccountCreatedSubTitle,
                          onPressed: () => router.go(AppRoutes.login),
                        ),
                      ),
                    );
                  },
                  child: const Text(TTexts.tContinue),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItem),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(TTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
