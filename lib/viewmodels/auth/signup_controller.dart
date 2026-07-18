import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/widgets/loaders/full_screen_loader.dart';
import 'package:ecommerce/core/widgets/loaders/snacks_loader.dart';
import 'package:ecommerce/core/widgets/toasts/app_toasts.dart';
import 'package:ecommerce/models/user_model.dart';
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
      TFullScreenLoader.openLoadingDialog(
        'Processing your information...',
        animation: 'assets/lottie/loading.json',
      );

      // check Internet Connectivity
      final isConnected = await ref.read(networkManagerProvider).isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TSnacksLoader.errorSnackBar(title: 'No Internet Connection');
        // TAppToasts.error('No Internet Connection.');
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!state.agreedToTerms) {
        TFullScreenLoader.stopLoading();
        TSnacksLoader.warningSnackBar(
          title: 'please agree to terms and condition',
        );
        // TAppToasts.warning('Please agree to the Privacy Policy and Terms.');
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await ref
          .read(authRepositoryProvider)
          .registerWithEmailAndPassword(
            emailController.text,
            passwordController.text,
          );

      // save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        profilePicture: '',
      );

      await ref.read(userRepositoryProvider).saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();
      TAppToasts.success('Your account has been created successfully.');
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TAppToasts.error(e.toString());
    }
  }
}

final signupControllerProvider =
    NotifierProvider<SignupController, SignupState>(SignupController.new);
