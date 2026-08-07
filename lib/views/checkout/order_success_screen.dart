import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/constants/text_strings.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

/// Shown once an order is placed successfully, celebrating the moment with
/// the "Order Confirmed" animation before routing the user back to shopping
/// or over to their order history.
class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Column(
            children: [
              const Spacer(),
              Lottie.asset(
                TImages.orderConfirmedAnimation,
                width: THelperFunctions.screenWidth(context) * 0.75,
                repeat: false,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Text(
                TTexts.orderConfirmedTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItem),
              Text(
                TTexts.orderConfirmedSubTitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go(AppRoutes.orders),
                  child: const Text('Track Order'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItem),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go(AppRoutes.navigation),
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
