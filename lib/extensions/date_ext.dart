import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String formatWithHour() {
    return DateFormat('kk:mm dd/MM/yyyy').format(this);
  }

  String format() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
// ···
}