import 'package:intl/intl.dart';

class Formatters {
  static String currency(num amount, [String currency = 'YER']) {
    final formatter = NumberFormat('#,###', 'en_US');
    final formatted = formatter.format(amount);
    return '$formatted ر.ي';
  }

  static String dateTime(DateTime dt) {
    final timeStr = DateFormat('hh:mm a').format(dt)
        .replaceAll('AM', 'ص')
        .replaceAll('PM', 'م');
    final dateStr = DateFormat('yyyy/MM/dd').format(dt);
    return '$dateStr • $timeStr';
  }
}
