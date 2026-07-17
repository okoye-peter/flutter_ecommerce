import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

class TBillingAddress extends StatelessWidget {
  const TBillingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: () {},),
        Text('Okoye Dev Mode', style: Theme.of(context).textTheme.bodyLarge,),
        const SizedBox(height: TSizes.spaceBtwItem / 2,),

        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItem,),
            Text('+2348103078096', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItem / 2,),

        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItem,),
            Expanded(child: Text('50 Palmbay Estate Lekki Abijo GRA', style: Theme.of(context).textTheme.bodyMedium, softWrap: true,)),
          ],
        ),
      ],
    );
  }
}
