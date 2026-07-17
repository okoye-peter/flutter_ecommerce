import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/appbar/appbar.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/success/success_screen.dart';
import 'package:ecommerce/views/cart/widgets/cart_list.dart';
import 'package:ecommerce/views/checkout/widgets/billing_address.dart';
import 'package:ecommerce/views/checkout/widgets/billing_payment.dart';
import 'package:ecommerce/views/checkout/widgets/billing_payment_methods.dart';
import 'package:ecommerce/views/checkout/widgets/checkout_coupon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TCartList(showQuantityControl: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              // - Coupon TextField
              TCheckoutCoupon(dark: dark),
              const SizedBox(height: TSizes.spaceBtwSections),

              // - Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    // Pricing
                    TBillingPayment(),
                    const SizedBox(height: TSizes.spaceBtwItem),

                    // Divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItem),

                    // Payment Methods
                    TBillingPaymentMethods(),
                    const SizedBox(height: TSizes.spaceBtwItem),

                    // Address
                    TBillingAddress()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SuccessScreen(
                  image: TImages.success,
                  title: 'Payment Success!',
                  subtitle: 'Your item will be shipped soon.',
                  onPressed: () => context.go(AppRoutes.navigation),
                ),
              ),
            );
          },
          child: Text('Checkout \$250'),
        ),
      ),
    );
  }
}
