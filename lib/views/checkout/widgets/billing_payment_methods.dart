import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/viewmodels/checkout/checkout_controller.dart';
import 'package:ecommerce/views/checkout/widgets/payment_method_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TBillingPaymentMethods extends ConsumerWidget {
  const TBillingPaymentMethods({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);
    final selectedMethod = ref.watch(checkoutControllerProvider);

    return Column(
      children: [
        TSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => const TPaymentMethodBottomSheet(),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItem / 3,),
        Row(
          children: [
            TRoundedContainer(
              width: 70,
              height: 60,
              backgroundColor: dark ? TColors.light : TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: Image(image: AssetImage(selectedMethod.image), fit: BoxFit.contain),
            ),
            const SizedBox(width: TSizes.spaceBtwItem / 2,),
            Text(selectedMethod.name, style: Theme.of(context).textTheme.bodyLarge,)
          ],
        )
      ],
    );
  }
}