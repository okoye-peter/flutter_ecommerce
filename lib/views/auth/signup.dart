import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/views/auth/widgets/form_divider.dart';
import 'package:ecommerce/views/auth/widgets/form_social_buttons.dart';
import 'package:ecommerce/views/auth/widgets/signup/signup_form.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              const TSignUpForm(),

              const SizedBox(height: TSizes.spaceBtwInputFields),
              // Dividers
              const TFormDivider(dividerText: TTexts.orSignUpWith),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Social
              const TFormSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}