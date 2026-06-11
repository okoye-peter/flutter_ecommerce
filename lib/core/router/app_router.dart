import 'package:ecommerce/core/widgets/success/success_screen.dart';
import 'package:ecommerce/views/auth/login.dart';
import 'package:ecommerce/views/auth/onboarding.dart';
import 'package:ecommerce/views/auth/signup.dart';
import 'package:ecommerce/views/auth/verify_email.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const onboarding = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const emailVerification = '/email_verification';
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
  ],
);
