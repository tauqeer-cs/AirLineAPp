import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';


class AppDateUtils {
  static String formatDateWithoutLocale(DateTime? dateTime,{required String? locale}) {
    if (dateTime == null) return "";

    if(locale != null) {
      String formattedDate = DateFormat("dd MMM yyyy",locale).format(dateTime);
      return formattedDate;
    }
    String formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
    return formattedDate;
  }

  static String formatTimeWithoutLocale(DateTime? dateTime,{required String? locale}) {
    if (dateTime == null) return "";
    if(locale != null) {
      String formattedDate = DateFormat.Hm(locale).format(dateTime);
      return formattedDate;
    }

    String formattedDate = DateFormat.Hm().format(dateTime);
    return formattedDate;
  }

  static String formatJM(DateTime? dateTime,{required String? locale}) {
    if (dateTime == null) return "";
    if(locale != null) {
      String formattedDate = DateFormat.jm(locale).format(dateTime);
      return formattedDate;
    }
    String formattedDate = DateFormat.jm().format(dateTime);
    return formattedDate;
  }

  static String formatFullDate(DateTime? dateTime,{required String? locale}) {
    if (dateTime == null) return "";
    if(locale != null) {
      String formattedDate = DateFormat("EEEE dd MMMM yyyy",locale).format(dateTime);
      return formattedDate;
    }
    String formattedDate = DateFormat("EEEE dd MMMM yyyy").format(dateTime);
    return formattedDate;
  }

  static String formatHalfDate(DateTime? dateTime,{required String? locale}) {
    if (dateTime == null) return "Invalid Date";
    if(locale != null) {
      String formattedDate = DateFormat("EEE dd MMMM yyyy",locale).format(dateTime);
      return formattedDate;
    }
    String formattedDate = DateFormat("EEE dd MMMM yyyy").format(dateTime);
    return formattedDate;
  }

  static String formatFullDateWithTime(DateTime? dateTime,{required String? locale}) {
    if (dateTime == null) return "Invalid Date";
    if(locale != null) {
      final dateFormat = DateFormat("EEE dd MMM yyyy, hh:mm a",locale);
      String formattedDate = dateFormat.format(dateTime);
      return formattedDate;
    }

    final dateFormat = DateFormat("EEE dd MMM yyyy, hh:mm a");
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  static String formatFullDateTwoLines(DateTime? dateTime,{required String? locale}) {
    /*
    Mon 01 Jan 2023,
    12:30 pm
    * */
    if (dateTime == null) return "Invalid Date";
    if(locale != null) {
      final dateFormat = DateFormat("EEE dd MMM yyyy,\nhh:mm a",locale);
      String formattedDate = dateFormat.format(dateTime);
      return formattedDate;
    }
    final dateFormat = DateFormat("EEE dd MMM yyyy,\nhh:mm a");
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }


  static String formatHalfDateHalfMonth(DateTime? dateTime,{required String? locale}) {
    if (dateTime == null) return "Invalid Date";
    if(locale != null) {
      String formattedDate = DateFormat("EEE dd MMM yyyy",locale).format(dateTime);
      return formattedDate;
    }
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

  static String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;

    String result = '';

    if (hours > 0) {
      result += '${hours.toString()} ${'hour'.tr()}';
      if (hours > 1) {
        result += 's';
      }
      result += ' ';
    }

    if (minutes > 0) {
      result += '${minutes.toString()} ${'min'.tr()}';
      if (minutes > 1) {
        result += 's'.tr();
      }
    }
    else {
      result += '${00.toString()} ${'min'.tr()}';
      result += 's'.tr();

    }

    return result.trim();
  }

}
