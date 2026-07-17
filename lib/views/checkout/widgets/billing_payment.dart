import 'package:ecommerce/core/constants/sizes.dart';
import 'package:flutter/material.dart';

class TBillingPayment extends StatelessWidget {
  const TBillingPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // - subtotal 
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SubTotal', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$256', style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItem / 2,),

        // - shipping fee 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$6.0', style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItem / 2,),

        // - Tax fee 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$6.0', style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItem / 2,),

        // - Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$6.0', style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
      ],
    );
  }
}