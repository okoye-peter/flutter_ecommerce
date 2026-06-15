import 'package:ecommerce/app.dart';
import 'package:ecommerce/core/providers/providers.dart';
import 'package:ecommerce/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce/core/utils/local_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorage = await LocalStorage().init();
  final secureStorage = await SecureStorage().init();

  runApp(
    ProviderScope(
      overrides: [
        localStorageProvider.overrideWithValue(localStorage),
        secureStorageProvider.overrideWithValue(secureStorage),
      ],
      child: const App(),
    ),
  );
}
