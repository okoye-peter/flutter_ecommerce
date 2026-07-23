import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/viewmodels/auth/forget_password_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go(AppRoutes.login);
            },
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // image
              Image(
                image: const AssetImage(TImages.forgotPassword),
                width: THelperFunctions.screenWidth(context) * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // title and subtitle
              Text(
                TTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItem),
              Text(
                TTexts.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItem),

              // buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                  child: const Text(TTexts.done),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItem),

              SizedBox(
                width: double.infinity,
                child: Consumer(
                  builder: (context, ref, _) {
                    final secondsLeft = ref.watch(forgotPasswordProvider);
                    return TextButton(
                      onPressed: secondsLeft > 0
                          ? null
                          : () => ref
                                .read(forgotPasswordProvider.notifier)
                                .resendPasswordResetEamil(email),
                      child: Text(
                        secondsLeft > 0
                            ? 'Resend Email in ${secondsLeft}s'
                            : TTexts.resendEmail,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
