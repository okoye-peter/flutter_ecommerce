import 'package:ecommerce/app.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce/core/utils/local_storage/secure_storage.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/repositories/authentication_repository.dart';
import 'package:ecommerce/repositories/cloudinary_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/scripts/category_seeder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // don't close splash screen until I say so
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepository = AuthenticationRepository();
  final userRepository = UserRepository(authenticationRepository: authRepository);
  // final cloudinaryRepository = CloudinaryRepository();

  // TODO: remove after seeding once — populates the Categories collection.
  // await seedCategories(cloudinaryRepository);

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
      // cloudinaryRepositoryProvider.overrideWithValue(cloudinaryRepository),
    ],
  );

  // wait for Firebase to resolve any persisted session before showing a screen,
  // so the router's redirect doesn't flash the login screen first.
  await container.read(authStateChangesProvider.future);
  FlutterNativeSplash.remove();

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
