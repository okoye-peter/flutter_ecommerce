import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/viewmodels/checkout/checkout_controller.dart';
import 'package:ecommerce/views/checkout/widgets/payment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TPaymentMethodBottomSheet extends ConsumerWidget {
  const TPaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(checkoutControllerProvider.notifier);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TSectionHeading(
              title: 'Select Payment Method',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            ...controller.getPaymentMethods().map(
              (method) => TPaymentTile(paymentMethod: method),
            ),
          ],
        ),
      ),
    );
  }
}
