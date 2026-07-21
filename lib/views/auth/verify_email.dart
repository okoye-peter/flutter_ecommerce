import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/success/success_screen.dart';
import 'package:ecommerce/viewmodels/auth/email_verification_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void _goToSuccessScreen(BuildContext context) {
  final router = GoRouter.of(context);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => SuccessScreen(
        image: TImages.successIllustrator,
        title: TTexts.yourAccountCreatedTitle,
        subtitle: TTexts.yourAccountCreatedSubTitle,
        onPressed: () => router.go(AppRoutes.navigation),
      ),
    ),
  );
}

class VerifyEmailScreen extends ConsumerWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(emailVerificationProvider.notifier);

    ref.listen<EmailVerificationState>(emailVerificationProvider, (
      previous,
      next,
    ) {
      if (next.isVerified && previous?.isVerified != true) {
        _goToSuccessScreen(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authRepositoryProvider).logout();
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
                email ?? '',
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
                  onPressed: () => _goToSuccessScreen(context),
                  child: const Text(TTexts.tContinue),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItem),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
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
