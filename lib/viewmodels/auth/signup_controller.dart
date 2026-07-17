import 'package:ecommerce/core/helpers/helper_functions.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/widgets/loaders/full_screen_loader.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupState {
  final bool obscurePassword;
  final bool agreedToTerms;
  final bool isLoading;

  const SignupState({
    this.obscurePassword = true,
    this.agreedToTerms = false,
    this.isLoading = false,
  });

  SignupState copyWith({
    bool? obscurePassword,
    bool? agreedToTerms,
    bool? isLoading,
  }) {
    return SignupState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SignupController extends Notifier<SignupState> {
  late final formKey = GlobalKey<FormState>();
  late final firstNameController = TextEditingController();
  late final lastNameController = TextEditingController();
  late final usernameController = TextEditingController();
  late final emailController = TextEditingController();
  late final phoneController = TextEditingController();
  late final passwordController = TextEditingController();

  @override
  SignupState build() {
    ref.onDispose(() {
      firstNameController.dispose();
      lastNameController.dispose();
      usernameController.dispose();
      emailController.dispose();
      phoneController.dispose();
      passwordController.dispose();
    });
    return const SignupState();
  }

  void toggleObscurePassword() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);

  void toggleAgreedToTerms() =>
      state = state.copyWith(agreedToTerms: !state.agreedToTerms);

  Future<void> signUp() async {
    try {
      // show Loader
      TFullScreenLoader.openLoadingDialog('Processing your information...');

      // check Internet Connectivity
      final isConnected = await ref.read(networkManagerProvider).isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        THelperFunctions.showSnackBar(
          rootNavigatorKey.currentContext!,
          'No Internet Connection.',
        );
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check

      // Register user in the Firebase Authentication & Save user data in the Firebase

      // save Authenticated user data in the Firebase Firestore

      TFullScreenLoader.stopLoading();
      // show Success Message
    } catch (e) {
      TFullScreenLoader.stopLoading();
      THelperFunctions.showSnackBar(
        rootNavigatorKey.currentContext!,
        e.toString(),
      );
    }
  }
}

final signupControllerProvider =
    NotifierProvider<SignupController, SignupState>(SignupController.new);
