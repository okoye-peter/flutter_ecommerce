import 'dart:async';

import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/views/auth/forgot_password.dart';
import 'package:ecommerce/views/auth/login.dart';
import 'package:ecommerce/views/auth/onboarding.dart';
import 'package:ecommerce/views/auth/reset_password.dart';
import 'package:ecommerce/views/auth/signup.dart';
import 'package:ecommerce/views/auth/verify_email.dart';
import 'package:ecommerce/views/brands/all_brands_screen.dart';
import 'package:ecommerce/views/brands/brand_products.dart';
import 'package:ecommerce/views/cart/cart_screen.dart';
import 'package:ecommerce/views/checkout/checkout_screen.dart';
import 'package:ecommerce/views/navigation/navigation_menu.dart';
import 'package:ecommerce/views/orders/orders_screen.dart';
import 'package:ecommerce/views/products/all_product_screen.dart';
import 'package:ecommerce/views/products/product_details.dart';
import 'package:ecommerce/views/products/product_review.dart';
import 'package:ecommerce/views/profile/profile.dart';
import 'package:ecommerce/views/settings/address/add_new_address.dart';
import 'package:ecommerce/views/settings/address/address.dart';
import 'package:ecommerce/views/sub_categories/sub_categories_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Root navigator key, used to obtain a [BuildContext] for overlays
/// (e.g. the full-screen loading dialog) from outside the widget tree.
final rootNavigatorKey = GlobalKey<NavigatorState>();

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
  static const products = '/products';
  static const productDetailsPath = '/products/:productId';
  static String productDetails(String id) => '/products/$id';
  static const productReviewsPath = '/products/:productId/reviews';
  static String productReviews(String id) => '/products/$id/reviews';
  static const home = '/home';
  static const brands = '/brands';
  static const brandProductsPath = '/brands/:brandId/products';
  static String brandProducts(String id) => '/brands/$id/products';
  static const carts = '/carts';
  static const checkout = '/checkout';
  static const orders = '/orders';
  static const subCategories = '/sub_categories';
}

/// Bridges a [Stream] to a [Listenable] so [GoRouter] can re-evaluate its
/// `redirect` whenever the auth state changes. (go_router used to ship this
/// as `GoRouterRefreshStream`; it's now a documented copy-paste helper.)
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Routes reachable while the user is signed out (or mid-verification).
/// Onboarding is handled separately below, since it only applies pre-first-launch.
const _unauthenticatedRoutes = {
  AppRoutes.login,
  AppRoutes.signup,
  AppRoutes.forgotPassword,
  AppRoutes.resetPassword,
};

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final localStorage = ref.watch(localStorageProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.onboarding,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges),
    redirect: (context, state) {
      final onOnboardingRoute = state.matchedLocation == AppRoutes.onboarding;

      // First launch: let onboarding play out untouched.
      if (!localStorage.hasSeenOnboarding) {
        return null;
      }

      final user = authRepository.currentUser;
      final loggedIn = user != null;

      // Onboarding already seen (or being revisited via a stale link) —
      // never show it again, go straight to the right screen instead.
      if (onOnboardingRoute) {
        return loggedIn ? AppRoutes.navigation : AppRoutes.login;
      }

      final onUnauthenticatedRoute = _unauthenticatedRoutes.contains(
        state.matchedLocation,
      );

      if (!loggedIn) {
        return onUnauthenticatedRoute ? null : AppRoutes.login;
      }

      if (!user.emailVerified) {
        return state.matchedLocation == AppRoutes.emailVerification
            ? null
            : AppRoutes.emailVerification;
      }

      final onEntryRoute =
          onUnauthenticatedRoute ||
          state.matchedLocation == AppRoutes.emailVerification;
      return onEntryRoute ? AppRoutes.navigation : null;
    },
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
        path: AppRoutes.products,
        builder: (context, state) => const AllProductsScreen(),
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
      GoRoute(
        path: AppRoutes.carts,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: AppRoutes.orders,
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: AppRoutes.subCategories,
        builder: (context, state) => const SubCategoriesScreen(),
      ),
      GoRoute(
        path: AppRoutes.brands,
        builder: (context, state) => const AllBrandsScreen(),
      ),
      GoRoute(
        path: AppRoutes.brandProductsPath,
        builder: (context, state) => const BrandProductsScreen(),
      ),
    ],
  );
});
