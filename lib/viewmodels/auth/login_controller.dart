import 'package:ecommerce/core/constants/image_strings.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce/core/utils/local_storage/secure_storage.dart';
import 'package:ecommerce/core/widgets/loaders/full_screen_loader.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final bool isRememberChecked;
  final bool hidePassword;
  final bool isLoading;

  LoginState({
    this.isRememberChecked = false,
    this.hidePassword = true,
    this.isLoading = false,
  });

  LoginState copyWith({
    bool? isRememberChecked,
    bool? hidePassword,
    bool? isLoading,
  }) {
    return LoginState(
      isRememberChecked: isRememberChecked ?? this.isRememberChecked,
      hidePassword: hidePassword ?? this.hidePassword,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoginController extends Notifier<LoginState> {
  late final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late LocalStorage localStorage;
  late SecureStorage secureStorage;

  final localStorageEmailKey = 'REMEMBER_ME_EMAIL';
  final localStoragePasswordKey = 'REMEMBER_ME_PASSWORD';

  @override
  LoginState build() {
    localStorage = ref.watch(localStorageProvider);
    secureStorage = ref.watch(secureStorageProvider);

    emailController.text = localStorage.readString(localStorageEmailKey) ?? '';
    passwordController.text =
        localStorage.readString(localStoragePasswordKey) ?? '';

    ref.onDispose(() {
      emailController.dispose();
      passwordController.dispose();
    });
    return LoginState();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(hidePassword: !state.hidePassword);
  }

  void toggleRememberMe(bool? value) {
    state = state.copyWith(
      isRememberChecked: value ?? !state.isRememberChecked,
    );
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing Login...',
        animation: TImages.loadingAnimation,
      );

      // check Internet Connectivity
      final isConnected = await ref.read(networkManagerProvider).isConnected();
      if (!isConnected) {
        TSnacksLoader.errorSnackBar(title: 'No Internet Connection');
        // TAppToasts.error('No Internet Connection.');
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        return;
      }

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (state.isRememberChecked) {
        localStorage.writeString(localStorageEmailKey, email);
        localStorage.writeString(localStoragePasswordKey, password);
      } else {
        localStorage.remove(localStorageEmailKey);
        localStorage.remove(localStoragePasswordKey);
      }

      await ref
          .read(authRepositoryProvider)
          .loginWithEmailAndPassword(email, password);
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing Login...',
        animation: TImages.loadingAnimation,
      );

      // check Internet Connectivity
      final isConnected = await ref.read(networkManagerProvider).isConnected();
      if (!isConnected) {
        TSnacksLoader.errorSnackBar(title: 'No Internet Connection');
        // TAppToasts.error('No Internet Connection.');
        return;
      }

      final userCredential = await ref
          .read(authRepositoryProvider)
          .signInWithGoogle();

      // Only write a record for brand-new accounts. Returning users' data
      // already exists in Firestore and is picked up lazily (and correctly)
      // the first time userControllerProvider is read — going through the
      // notifier here would trigger its build() fetch before the doc exists
      // for new users, and risks overwriting existing data for returning ones.
      final isNewUser = userCredential?.additionalUserInfo?.isNewUser ?? false;
      if (userCredential != null && isNewUser) {
        final userData = userCredential.user!;
        final nameParts = UserModel.nameParts(userData.displayName ?? '');
        final username = UserModel.generateUsername(userData.displayName ?? '');

        final user = UserModel(
          id: userData.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userData.email ?? '',
          phoneNumber: userData.phoneNumber ?? '',
          profilePicture: userData.photoURL ?? '',
        );

        try {
          await ref.read(userRepositoryProvider).saveUserRecord(user);
        } catch (e) {
          TSnacksLoader.warningSnackBar(
            title: 'Data not saved',
            message:
                'Something went wrong while saving your information. You can re-save your data in your Profile',
          );
        }
      }
    } catch (e) {
      TSnacksLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}

final loginControllerProvider = NotifierProvider.autoDispose<LoginController, LoginState>(
  LoginController.new,
);
