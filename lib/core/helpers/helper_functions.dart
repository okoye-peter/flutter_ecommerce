import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    switch (value.toLowerCase()) {
      case 'green':   return Colors.green;
      case 'red':     return Colors.red;
      case 'blue':    return Colors.blue;
      case 'pink':    return Colors.pink;
      case 'grey':    return Colors.grey;
      case 'purple':  return Colors.purple;
      case 'black':   return Colors.black;
      case 'white':   return Colors.white;
      case 'brown':   return Colors.brown;
      case 'teal':    return Colors.teal;
      case 'indigo':  return Colors.indigo;
      case 'yellow':  return Colors.yellow;
      case 'navy':    return const Color(0xFF000080);
      default:        return null;
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MMM, yyyy',
  }) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) => list.toSet().toList();
}
