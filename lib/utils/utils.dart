import 'package:intl/intl.dart';

class Utils {
  static String toDate(DateTime? date) {
    String formatDate = DateFormat.yMMMMEEEEd().format(date!);
    return formatDate;
  }

  static String toTime(DateTime? date) {
    String formatTime = DateFormat.Hm().format(date!);
    return formatTime;
  }
}
