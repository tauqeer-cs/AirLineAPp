import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app/app_logger.dart';
import '../models/error_response.dart';

class ErrorUtils {
  static String getErrorMessage(Object e, StackTrace? st) {
    logger.e(e);
    logger.e(st);
    FirebaseCrashlytics.instance.recordError(e, st);
    String message;
    if (e is ErrorResponse) {
      message = e.message ?? "Error Response null";
    } else if (e is DioError) {
      message = e.message;
    } else {
      message = "Unknown Error";
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return message;
  }

  static String generateErrorText(String errorText){
    switch (errorText.toLowerCase()){
      case "no flight available":
        return "No flight is found!";
      default:
        return "";
    }
  }

  static String generateSubError(String errorText){
    switch (errorText.toLowerCase()){
      case "no flight available":
        return "Please change your criteria and search once more.";
      default:
        return "";
    }
  }
}
