import 'package:dio/dio.dart';

import '../app/app_logger.dart';
import '../localizations/localizations_util.dart';
import '../models/error_response.dart';

class ErrorUtils {
  static String getErrorMessage(Object e, StackTrace? st) {
    logger.e(e);
    logger.e(st);
    if (e is ErrorResponse) {
      return e.message ?? "Error Response null";
    }
    if (e is DioError) {
      return e.message;
    }
    return tr.unknownError;
  }
}
