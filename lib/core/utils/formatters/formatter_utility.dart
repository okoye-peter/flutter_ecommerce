import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    return phoneNumber;
  }

  static String internaltionalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    var digitOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code from thr digitsOnly
    String countrycode = '+${digitOnly.substring(0, 2)}';

    final formattedNumber = StringBuffer();
    formattedNumber.write('($countrycode) ');

    int i = 0;
    while (i < digitOnly.length) {
      int groupLenght = 2;
      if (i == 0 && countrycode == '+1') {
        groupLenght = 3;
      }

      int end = i + groupLenght;
      formattedNumber.write(digitOnly.substring(i, end));

      if (end < digitOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString();
  }
}
