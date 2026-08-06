import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/models/address_model.dart';
import 'package:ecommerce/viewmodels/addresses/address_controller.dart';
import 'package:ecommerce/views/checkout/widgets/address_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TBillingAddress extends ConsumerWidget {
  const TBillingAddress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(addressControllerProvider);
    final controller = ref.read(addressControllerProvider.notifier);
    final AddressModel selectedAddress = controller.getSelectedAddress();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => const TAddressBottomSheet(),
          ),
        ),
        Text(
          selectedAddress.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: TSizes.spaceBtwItem / 2),

        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItem),
            Text(
              selectedAddress.formattedPhoneNo,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItem / 2),

        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItem),
            Expanded(
              child: Text(
                selectedAddress.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
