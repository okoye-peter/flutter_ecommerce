import 'package:ecommerce/app.dart';
// import 'package:ecommerce/core/constants/colors.dart';
// import 'package:ecommerce/core/theme/theme.dart';
import 'package:ecommerce/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce/core/utils/local_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Get.putAsync(() => LocalStorage().init()),
    Get.putAsync(() => SecureStorage().init()),
  ]);

  runApp(const App());
}
