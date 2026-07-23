import 'dart:io';

import 'package:ecommerce/core/widgets/loaders/full_screen_loader.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/viewmodels/auth/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Lets the user pick a photo (camera or gallery), then uploads it via
/// [UserController.updateProfilePicture].
Future<void> pickAndUploadProfilePicture(
  BuildContext context,
  WidgetRef ref,
) async {
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: const Text('Take a photo'),
            onTap: () => Navigator.of(context).pop(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Choose from gallery'),
            onTap: () => Navigator.of(context).pop(ImageSource.gallery),
          ),
        ],
      ),
    ),
  );

  if (source == null) return;

  final pickedFile = await ImagePicker().pickImage(
    source: source,
    imageQuality: 80,
  );

  if (pickedFile == null || !context.mounted) return;

  TFullScreenLoader.openLoadingDialog('Uploading photo...');
  final success = await ref
      .read(userControllerProvider.notifier)
      .updateProfilePicture(File(pickedFile.path));
  await TFullScreenLoader.stopLoading();

  if (success) {
    TSnacksLoader.successSnackBar(title: 'Profile picture updated');
  }
}
