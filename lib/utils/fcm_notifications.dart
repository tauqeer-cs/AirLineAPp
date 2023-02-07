import 'dart:convert';
import 'dart:io';

import 'package:app/app/app_flavor.dart';
import 'package:app/app/app_logger.dart';
import 'package:app/firebase/dev/firebase_options.dart';
import 'package:app/models/insider_notification_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: AppFlavor.firebaseOptions);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

void showFlutterNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  if (notification != null) {
    // ? display local notifications
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  } else if (message.data['source'] == "Insider") {
    InsiderNotificationModel? insiderNotificationModel =
        InsiderNotificationModel.fromJson(message.data);
    BigPictureStyleInformation? bigPictureStyleInformation;
    if (insiderNotificationModel.imageUrl != null) {
      print("image not null");
      final String bigPicturePath = await _downloadAndSaveFile(
          insiderNotificationModel.imageUrl!, 'bigPicture');
      bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        contentTitle: insiderNotificationModel.title,
        htmlFormatContentTitle: true,
        summaryText: insiderNotificationModel.message,
        htmlFormatSummaryText: true,

      );
    }

    flutterLocalNotificationsPlugin.show(
      insiderNotificationModel.hashCode,
      insiderNotificationModel.title,
      insiderNotificationModel.message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: bigPictureStyleInformation,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }
}

class FCMNotification {
  final FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();
  static String? token;
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'general', // title
    importance: Importance.max,
  );
  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('ic_stat_logo');
  final IOSInitializationSettings initializationSettingsIos =
      const IOSInitializationSettings();

  late BuildContext context;
  static final FCMNotification _fcmNotification = FCMNotification._internal();

  factory FCMNotification() {
    return _fcmNotification;
  }

  FCMNotification._internal();

  static FCMNotification of(BuildContext context) {
    FCMNotification notification = FCMNotification();
    notification.context = context;
    return notification;
  }

  Future<void> initialize() async {
    await setupFlutterNotifications();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIos,
    );

    await localNotification.initialize(
      initializationSettings,
      onSelectNotification: (String? val) {
        notificationAction(val ?? '');
      },
    );

    await localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.requestPermission();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false, // Required to display a heads up notification
      badge: false,
      sound: true,
    );

    FirebaseMessaging.instance.getToken().then((value) {
      // sync firebase token to the server
      if (value != null) {
        token = value;
        logger.d("fcm token is $value");
        //final fcmRequest = FCMRequest(fcmToken: value);
        //_userRepository.setFCM(fcmRequest);
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.onTokenRefresh.listen(
      (value) {
        token = value;
        logger.d("fcm token is $token");

        //final fcmRequest = FCMRequest(fcmToken: token);
        //_userRepository.setFCM(fcmRequest);
      },
    );

    // handling open notification from terminated background
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      notificationAction(jsonEncode(message.data));
    }

    // handling foreground notification
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('Handling a foreground message ${event.data}');
      showFlutterNotification(event);
    });

    // handling open notification from background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      notificationAction(jsonEncode(event.data));
    });
  }

  void notificationAction(String value) {
    print("notification selected $value");
    final convertJson = jsonDecode(value);
    final jsonValue = convertJson['path'] as String?;
    if (jsonValue?.isNotEmpty ?? false) {
    } else {
      //context.router.push(NotificationRoute());
    }
  }

  static subscribeTopic(String topic) {
    return FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static unsubscribeTopic(String topic) {
    return FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }
}
