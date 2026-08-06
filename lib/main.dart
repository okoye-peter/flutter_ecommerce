import 'dart:async';

import 'package:ecommerce/app.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce/core/utils/local_storage/secure_storage.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/repositories/authentication_repository.dart';
import 'package:ecommerce/repositories/cloudinary_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/viewmodels/carts/cart_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(_bootstrap, (error, stack) {
    debugPrint('Uncaught error during startup: $error\n$stack');
  });
}

Future<void> _bootstrap() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // route framework-level errors (build/layout/paint) into the same zone
  // handler above instead of only printing to console.
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    Zone.current.handleUncaughtError(
      details.exception,
      details.stack ?? StackTrace.empty,
    );
  };

  // don't close splash screen until I say so
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    // initialize firebase
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e, s) {
    debugPrint('Firebase.initializeApp failed: $e\n$s');
    FlutterNativeSplash.remove();
    runApp(const _StartupErrorApp());
    return;
  }

  final authRepository = AuthenticationRepository();
  final userRepository = UserRepository(
    authenticationRepository: authRepository,
  );
  final cloudinaryRepository = CloudinaryRepository();

  // init local storage (Shared preference)
  final localStorage = await LocalStorage().init();

  // init secure storage
  final secureStorage = await SecureStorage().init();

  final container = ProviderContainer(
    overrides: [
      localStorageProvider.overrideWithValue(localStorage),
      secureStorageProvider.overrideWithValue(secureStorage),
      authRepositoryProvider.overrideWithValue(authRepository),
      userRepositoryProvider.overrideWithValue(userRepository),
      cloudinaryRepositoryProvider.overrideWithValue(cloudinaryRepository),
    ],
  );

  // wait for Firebase to resolve any persisted session before showing a screen,
  // so the router's redirect doesn't flash the login screen first. Read the
  // repository's stream directly rather than `authStateChangesProvider.future`:
  // the Riverpod StreamProvider's future never resolves here even though the
  // underlying Firebase stream emits immediately, so going through the
  // container hangs the splash screen forever.
  await authRepository.authStateChanges.first;

  /**   
   * warm the cart before first frame so item counts/totals are ready
   * immediately instead of popping in after a loading gap. Bounded by a
   * timeout and never fatal — a slow/offline network or Firestore error
   * must not hang or crash app startup; the cart widgets that watch
   * cartControllerProvider will hydrate on their own once it resolves. 
  */
  try {
    await container.read(cartControllerProvider.future).timeout(const Duration(seconds: 5));
  } catch (_) {
    // ignore — cart hydrates lazily via the widgets that watch it
  }

  FlutterNativeSplash.remove();

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}

class _StartupErrorApp extends StatelessWidget {
  const _StartupErrorApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Something went wrong starting the app. Please try again.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
