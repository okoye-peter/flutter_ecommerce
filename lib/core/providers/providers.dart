import 'package:ecommerce/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce/core/utils/local_storage/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider<LocalStorage>(
  (ref) => throw UnimplementedError(),
);

final secureStorageProvider = Provider<SecureStorage>(
  (ref) => throw UnimplementedError(),
);
