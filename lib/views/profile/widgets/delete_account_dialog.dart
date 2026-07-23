import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/constants/sizes.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/viewmodels/auth/user_controller.dart';
import 'package:ecommerce/views/profile/widgets/reauthenticate_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows a warning dialog, then (on confirm) a password re-authentication
/// sheet, then deletes the account only if both steps succeed.
Future<void> openDeleteAccountConfirmation(
  BuildContext context,
  WidgetRef ref, {
  required String email,
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
      title: const Text('Delete Account'),
      content: const Text(
        'This will permanently delete your account and all associated data. This action cannot be undone.',
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

  if (confirmed != true || !context.mounted) return;

  // Require the owner to prove their identity before an irreversible delete.
  final reauthenticated =
      await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => TReauthenticateSheet(email: email),
      ) ??
      false;

  if (!reauthenticated || !context.mounted) return;

  final success = await ref
      .read(userControllerProvider.notifier)
      .deleteAccount();

  if (success) {
    TSnacksLoader.successSnackBar(title: 'Account deleted');
  }
}
