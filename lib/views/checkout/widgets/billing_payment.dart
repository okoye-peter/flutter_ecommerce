import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/utils/pricing_calculator/pricing_calculator.dart';
import 'package:ecommerce/viewmodels/carts/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TBillingPayment extends ConsumerWidget {
  const TBillingPayment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(cartControllerProvider.notifier);
    final subTotal = controller.getTotalCartPrice();
    final shippingFee = TPricingCalculator.calculateShippingCost(
      double.parse(subTotal),
      'US',
    );
    final taxFee = TPricingCalculator.calculateTax(double.parse(subTotal), 'US');
    final total = double.parse(taxFee) + double.parse(shippingFee) + double.parse(subTotal);

    return Column(
      // - subtotal
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SubTotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$$subTotal', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItem / 2),

        // - shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text(
              '\$${shippingFee.toString()}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItem / 2),

        // - Tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${taxFee.toString()}', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItem / 2),

        // - Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}