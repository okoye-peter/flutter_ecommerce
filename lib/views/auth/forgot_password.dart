import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/utils/validators/validator.dart';
import 'package:ecommerce/viewmodels/auth/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(forgotPasswordProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwItem,),
              Text(TTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: TSizes.spaceBtwSections * 2,),

              // Text field
              TextFormField(
                controller: controller.emailController,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      ref.read(forgotPasswordProvider.notifier).sendPasswordResetEmail(),
                  child: const Text(TTexts.submit),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
