import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/loaders/loading_overlay.dart';
import 'package:ecommerce/models/address_model.dart';
import 'package:ecommerce/viewmodels/addresses/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows a warning dialog, then (on confirm) deletes the address.
Future<void> openDeleteAddressConfirmation(
  BuildContext context,
  WidgetRef ref, {
  required AddressModel address,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
      ),
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: TColors.error,
        size: 40,
      ),
      title: const Text('Delete Address'),
      content: Text(
        'Remove "${address.name}" from your saved addresses? This action cannot be undone.',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: TColors.error),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  if (confirmed != true) return;

  TLoadingOverlay.show();
  await ref.read(addressControllerProvider.notifier).deleteAddress(address.id);
  TLoadingOverlay.hide();
}
