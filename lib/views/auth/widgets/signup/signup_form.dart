import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Username
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Icons.face_unlock_sharp),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Email
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Icons.email),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Phone
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Icons.call),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(Icons.lock_open),
              suffixIcon: Icon(Icons.remove_red_eye_outlined),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // term & condition
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(value: true, onChanged: (value) {}),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${TTexts.iAgreeTo} ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: '${TTexts.privacyPolicy} ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.white : TColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: 'and ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: TTexts.termsOfUse,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.white : TColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.emailVerification);
              },
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
