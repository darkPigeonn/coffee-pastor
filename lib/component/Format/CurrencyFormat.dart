// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class FormatCurrency {
  static String convertToIdr(dynamic number, int decimalDigit) {
    if (number is String) {
      number = double.tryParse(number) ?? 0.0;
    }

    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
