import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/widgets/products/rounded_container.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

class TBillingPaymentMethods extends StatelessWidget {
  const TBillingPaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        TSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () {},),
        const SizedBox(height: TSizes.spaceBtwItem / 2,),
        Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? TColors.light : TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: const Image(image: AssetImage(TImages.paystack), fit: BoxFit.cover),
            ),
            const SizedBox(width: TSizes.spaceBtwItem / 2,),
            Text('Paystack', style: Theme.of(context).textTheme.bodyLarge,)
          ],
        )
      ],
    );
  }
}