import 'package:intl/intl.dart';

class Utils {
  static String formatWithCommas(num value) {
    final formatter = NumberFormat('#,##0');
    return formatter.format(value);
  }
}
