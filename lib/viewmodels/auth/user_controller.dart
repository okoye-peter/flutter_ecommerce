import 'dart:io';

import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserController extends AsyncNotifier<UserModel> {
  @override
  Future<UserModel> build() {
    return ref.read(userRepositoryProvider).fetchUserDetails();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(userRepositoryProvider).fetchUserDetails(),
    );
  }

  /// Updates one or more fields on the current user's Firestore record and
  /// refreshes the cached state to match.
  Future<bool> updateField(Map<String, dynamic> data) async {
    try {
      await ref.read(userRepositoryProvider).updateSingleField(data);
      await refresh();
      return true;
    } catch (e) {
      TSnacksLoader.warningSnackBar(
        title: 'Update failed',
        message: 'Something went wrong while updating your profile.',
      );
      return false;
    }
  }

  /// Permanently deletes the user's Firestore record and Firebase Auth
  /// account. The router redirects to login on its own once the auth state
  /// changes, so no navigation happens here.
  Future<bool> deleteAccount() async {
    final currentUser = state.value;
    try {
      if (currentUser != null && currentUser.id.isNotEmpty) {
        await ref.read(userRepositoryProvider).removeUserRecord(currentUser.id);
      }
      await ref.read(authRepositoryProvider).deleteAccount();
      return true;
    } catch (e) {
      TSnacksLoader.errorSnackBar(
        title: 'Could not delete account',
        message: e.toString(),
      );
      return false;
    }
  }

  /// Uploads [image] to Cloudinary and stores the resulting URL as the
  /// user's profile picture.
  Future<bool> updateProfilePicture(File image) async {
    try {
      final url = await ref.read(cloudinaryRepositoryProvider).uploadImage(image);
      return await updateField({'profilePicture': url});
    } catch (e) {
      TSnacksLoader.warningSnackBar(
        title: 'Upload failed',
        message: 'Something went wrong while uploading your photo.',
      );
      return false;
    }
  }
}

final userControllerProvider = AsyncNotifierProvider<UserController, UserModel>(UserController.new);
