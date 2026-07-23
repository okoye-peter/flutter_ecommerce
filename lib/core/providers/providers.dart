import 'package:ecommerce/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce/core/utils/local_storage/secure_storage.dart';
import 'package:ecommerce/core/utils/network/network_manager.dart';
import 'package:ecommerce/repositories/authentication_repository.dart';
import 'package:ecommerce/repositories/cloudinary_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider<LocalStorage>(
  (ref) => throw UnimplementedError(),
);

final secureStorageProvider = Provider<SecureStorage>(
  (ref) => throw UnimplementedError(),
);

final authRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => throw UnimplementedError(),
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => throw UnimplementedError(),
);

final cloudinaryRepositoryProvider = Provider<CloudinaryRepository>(
  (ref) => throw UnimplementedError(),
);

/// Emits the current Firebase user, starting once the persisted session
/// (if any) has been restored.
final authStateChangesProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges,
);

final networkManagerProvider = Provider<NetworkManager>(
  (ref) => NetworkManager(),
);

/// Emits `true`/`false` as network connectivity changes.
final connectivityStreamProvider = StreamProvider<bool>(
  (ref) => ref.watch(networkManagerProvider).onConnectivityChanged,
);
