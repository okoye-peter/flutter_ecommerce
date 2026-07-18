import 'package:ecommerce/core/constants/colors.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// Utility for showing success, error, warning and info toast notifications.
class TAppToasts {
  const TAppToasts._();

  static void success(String message, {String? title}) => _show(
    title: title ?? 'Success',
    message: message,
    type: ToastificationType.success,
    color: TColors.success,
    icon: Icons.check_circle,
  );

  static void error(String message, {String? title}) => _show(
    title: title ?? 'Error',
    message: message,
    type: ToastificationType.error,
    color: TColors.error,
    icon: Icons.error,
  );

  static void warning(String message, {String? title}) => _show(
    title: title ?? 'Warning',
    message: message,
    type: ToastificationType.warning,
    color: TColors.warning,
    icon: Icons.warning_rounded,
  );

  static void info(String message, {String? title}) => _show(
    title: title ?? 'Info',
    message: message,
    type: ToastificationType.info,
    color: TColors.info,
    icon: Icons.info,
  );

  static void _show({
    required String title,
    required String message,
    required ToastificationType type,
    required Color color,
    required IconData icon,
  }) {
    toastification.show(
      context: rootNavigatorKey.currentContext,
      type: type,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 4),
      title: Text(title),
      description: Text(message),
      alignment: Alignment.topCenter,
      icon: Icon(icon, color: color),
      primaryColor: color,
      borderRadius: BorderRadius.circular(12),
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.onHover,
      dragToClose: true,
    );
  }
}
