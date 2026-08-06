import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/models/payment_model.dart';
import 'package:ecommerce/viewmodels/checkout/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class TPaymentTile extends ConsumerWidget {
  const TPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(checkoutControllerProvider.notifier);
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.saveSelectedPaymentOption(paymentMethod);
        context.pop();
      },
      leading: TRoundedContainer(
        width: 80,
        height: 80,
        backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.light : TColors.white,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
