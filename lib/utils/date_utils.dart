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

  static bool isUnderage(DateTime date, DateTime flightDate) =>
      (DateTime(DateTime.now().year, date.month, date.day)
              .isAfter(DateTime.now())
          ? DateTime.now().year - date.year - 1
          : DateTime.now().year - date.year) <
      18;

  static bool isUnder16(DateTime date, DateTime flightDate) =>
      (DateTime(flightDate.year, date.month, date.day).isAfter(flightDate)
          ? flightDate.year - date.year - 1
          : flightDate.year - date.year) <
      16;

  static bool sameMonth(DateTime? date1, DateTime? date2) =>
      date1?.year == date2?.year && date1?.month == date2?.month;

  static String? toDateWithoutTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }
}
