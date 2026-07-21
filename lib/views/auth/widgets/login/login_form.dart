import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/utils/validators/validator.dart';
import 'package:ecommerce/viewmodels/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TLoginForm extends ConsumerWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(loginControllerProvider.notifier);

    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: TSizes.spaceBtwInputFields,
        ),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.emailController,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Password
            Consumer(
              builder: (context, ref, _) {
                final hidePassword = ref.watch(
                  loginControllerProvider.select((s) => s.hidePassword),
                );
                return TextFormField(
                  controller: controller.passwordController,
                  obscureText: hidePassword,
                  validator: (value) => TValidator.validateEmptyText('password', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: TTexts.password,
                    suffixIcon: IconButton(
                      onPressed: controller.togglePasswordVisibility,
                      icon: Icon(hidePassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            // Remember & forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer(
                  builder: (context, ref, _) {
                    final isRememberChecked = ref.watch(
                      loginControllerProvider.select((s) => s.isRememberChecked),
                    );
                    return Row(
                      children: [
                        Checkbox(
                          value: isRememberChecked,
                          onChanged: (value) => controller.toggleRememberMe(value),
                        ),
                        const Text(TTexts.rememberMe),
                      ],
                    );
                  },
                ),
                // Forgot Password
                TextButton(
                  onPressed: () {
                    context.push(AppRoutes.forgotPassword);
                  },
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Sign in Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.emailAndPasswordSignIn,
                child: Text(TTexts.signIn),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.push(AppRoutes.signup),
                child: Text(TTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
