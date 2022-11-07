import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatDateWithoutLocale(DateTime? dateTime) {
    if (dateTime == null) return "";
    String formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
    return formattedDate;
  }

  static String formatTimeWithoutLocale(DateTime? dateTime) {
    if (dateTime == null) return "";
    String formattedDate = DateFormat.Hm().format(dateTime);
    return formattedDate;
  }

  static String formatJM(DateTime? dateTime) {
    if (dateTime == null) return "";
    String formattedDate = DateFormat.jm().format(dateTime);
    return formattedDate;
  }

  static String formatFullDate(DateTime? dateTime) {
    if (dateTime == null) return "";
    String formattedDate = DateFormat("EEEE dd MMMM yyyy").format(dateTime);
    return formattedDate;
  }

  static String formatHalfDate(DateTime? dateTime) {
    if (dateTime == null) return "Invalid Date";
    String formattedDate = DateFormat("EEE dd MMMM yyyy").format(dateTime);
    return formattedDate;
  }

  static String formatFullDateWithTime(DateTime? dateTime) {
    if (dateTime == null) return "Invalid Date";
    final dateFormat = DateFormat("EEEE dd MMMM yyyy hh:mm a");
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  static String formatHalfDateHalfMonth(DateTime? dateTime) {
    if (dateTime == null) return "Invalid Date";
    String formattedDate = DateFormat("EEE dd MMM yyyy").format(dateTime);
    return formattedDate;
  }
}
