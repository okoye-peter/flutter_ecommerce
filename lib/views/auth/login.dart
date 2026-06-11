import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/styles/spacing_styles.dart';
import 'package:ecommerce/views/auth/widgets/form_divider.dart';
import 'package:ecommerce/views/auth/widgets/login/login_form.dart';
import 'package:ecommerce/views/auth/widgets/login/login_header.dart';
import 'package:ecommerce/views/auth/widgets/form_social_buttons.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight(context),
          child: Column(
            children: [
              const TLoginHeader(),

              const TLoginForm(),

              // divider
              TFormDivider(dividerText: TTexts.orSignInWith),

              const SizedBox(height: TSizes.spaceBtwSections,),

              const TFormSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
