import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'app.dart';
import 'app/app_bloc_observer.dart';
import 'app/app_logger.dart';

main() {
  run();
}

void run() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  FlutterError.onError = (details) {
    logger.e(details.exceptionAsString());
    logger.e(details.stack);
  };
  Bloc.observer = AppBlocObserver();
  runZonedGuarded(
    () async {
      // The following lines are the same as previously explained in "Handling uncaught errors"
      //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      runApp(App());
    },
    (error, stackTrace) {
      // The following lines are the same as previously explained in "Handling uncaught errors"
      //FirebaseCrashlytics.instance.recordError(error, stackTrace);
      logger.e(error.toString());
      logger.e(stackTrace);
    },
  );
}
