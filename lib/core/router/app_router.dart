import 'package:ecommerce/views/auth/forgot_password.dart';
import 'package:ecommerce/views/auth/login.dart';
import 'package:ecommerce/views/auth/onboarding.dart';
import 'package:ecommerce/views/auth/reset_password.dart';
import 'package:ecommerce/views/auth/signup.dart';
import 'package:ecommerce/views/auth/verify_email.dart';
import 'package:ecommerce/views/navigation/navigation_menu.dart';
import 'package:ecommerce/views/products/product_details.dart';
import 'package:ecommerce/views/products/product_review.dart';
import 'package:ecommerce/views/profile/profile.dart';
import 'package:ecommerce/views/settings/address/add_new_address.dart';
import 'package:ecommerce/views/settings/address/address.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const onboarding = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const emailVerification = '/email_verification';
  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset_password';
  static const navigation = '/navigation';
  static const profile = '/profile';
  static const addNewAddress = '/profile/address/create';
  static const address = '/profile/address';
  static const productDetailsPath = '/products/:productId';
  static String productDetails(String id) => '/products/$id';
  static const productReviewsPath = '/products/:productId/reviews';
  static String productReviews(String id) => '/products/$id/reviews';
  static const home = '/home';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.emailVerification,
      builder: (context, state) => const VerifyEmailScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.navigation,
      builder: (context, state) => const NavigationMenuScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.productDetailsPath,
      builder: (context, state) => const ProductDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.productReviewsPath,
      builder: (context, state) => const ProductReviewsScreen(),
    ),
    GoRoute(
      path: AppRoutes.address,
      builder: (context, state) => const UserAddressScreen(),
    ),
    GoRoute(
      path: AppRoutes.addNewAddress,
      builder: (context, state) => const AddNewAddressScreen(),
    ),

  ],
);