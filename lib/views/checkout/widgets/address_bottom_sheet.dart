import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/loaders/loading_overlay.dart';
import 'package:ecommerce/core/widgets/texts/section_heading.dart';
import 'package:ecommerce/viewmodels/addresses/address_controller.dart';
import 'package:ecommerce/views/settings/address/widget/single_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TAddressBottomSheet extends ConsumerWidget {
  const TAddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(addressControllerProvider).value ?? [];
    final controller = ref.read(addressControllerProvider.notifier);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TSectionHeading(
              title: 'Select Address',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            ...addresses.map(
              (address) => TSingleAddress(
                address: address,
                onTap: () async {
                  TLoadingOverlay.show();
                  await controller.selectAddress(address.id);
                  TLoadingOverlay.hide();
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
