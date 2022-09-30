import 'package:app/localizations/localizations_util.dart';
import 'package:intl/intl.dart';

class AppDateUtils{
  static String formatDateWithoutLocale(DateTime? dateTime) {
    if(dateTime==null) return tr.invalidDate;
    String formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
    return formattedDate;
  }

  static String formatTimeWithoutLocale(DateTime? dateTime) {
    if(dateTime==null) return tr.invalidDate;
    String formattedDate = DateFormat.Hm().format(dateTime);
    return formattedDate;
  }

  static String formatTransactionDate(DateTime? dateTime) {
    if(dateTime==null) return tr.invalidDate;
    final dateFormat = DateFormat("dd MM yyyy hh:mm:ss");
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }
}