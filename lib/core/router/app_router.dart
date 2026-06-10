import 'package:ecommerce/views/auth/login.dart';
import 'package:ecommerce/views/auth/onboarding.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const onboarding = '/';
  static const login = '/login';
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
  ],
);
