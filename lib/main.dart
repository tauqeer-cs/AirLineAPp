import 'dart:async';
import 'dart:io';

import 'package:app/app/app_flavor.dart';
import 'package:app/data/repositories/local_repositories.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/booking_local.dart';
import 'package:app/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'app/app_bloc_observer.dart';
import 'app/app_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/auth_repository.dart';

main() async {
  AppFlavor.appFlavor = Flavor.staging;
  run();
}

void run() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: AppFlavor.firebaseOptions,
  );
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await Hive.initFlutter();
  Hive.registerAdapter<FlightSummaryPnrRequest>(
      FlightSummaryPnrRequestAdapter());
  Hive.registerAdapter<CompanyTaxInvoice>(CompanyTaxInvoiceAdapter());
  Hive.registerAdapter<EmergencyContact>(EmergencyContactAdapter());
  Hive.registerAdapter<Passenger>(PassengerAdapter());
  Hive.registerAdapter(BookingLocalAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<FlightSummaryPnrRequest>(passengerInfoBox);
  await Hive.openBox<String>(timerBox);
  await Hive.openBox<String>(sessionBox);
  await Hive.openBox<List>(bookingBox);
  await Hive.openBox<User>(userBoxName);
  await Hive.openBox<String>(tokenBoxName);
  AuthenticationRepository().init();
  //await box.clear();
  Bloc.observer = AppBlocObserver();
  runZonedGuarded(
    () async {
      // The following lines are the same as previously explained in "Handling uncaught errors"
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      runApp(EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('th'), Locale('id')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const App()));
    },
    (error, stackTrace) {
      // The following lines are the same as previously explained in "Handling uncaught errors"
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
      logger.e(error.toString());
      logger.e(stackTrace);
    },
  );
}
