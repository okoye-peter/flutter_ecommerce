import 'package:ecommerce/core/helpers/halper_functions.dart';
import 'package:ecommerce/core/styles/spacing_styles.dart';
import 'package:ecommerce/views/auth/widgets/login/login_divider.dart';
import 'package:ecommerce/views/auth/widgets/login/login_form.dart';
import 'package:ecommerce/views/auth/widgets/login/login_header.dart';
import 'package:ecommerce/views/auth/widgets/login/login_social_buttons.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight(context),
          child: Column(
            children: [
              TLoginHeader(dark: dark),

              TLoginForm(),

              // divider
              TLoginDivider(dark: dark),

              TLoginSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
