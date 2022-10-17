import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMNotification {
  final FlutterLocalNotificationsPlugin localNotification =
  FlutterLocalNotificationsPlugin();

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
      print("token is $value");
      if (value != null) {
        //final fcmRequest = FCMRequest(fcmToken: value);
        //_userRepository.setFCM(fcmRequest);
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen(
          (token) {
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
      RemoteNotification? notification = event.notification;

      if (notification != null) {
        // ? display local notifications
        // localNotification.show(
        //   notification.hashCode,
        //   notification.title,
        //   notification.body,
        //   NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       channel.id,
        //       channel.name,
        //       importance: Importance.max,
        //       priority: Priority.high,
        //     ),
        //   ),
        //   payload: jsonEncode(event.data),
        // );
      }
    });

    // handling open notification from background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      notificationAction(jsonEncode(event.data));
    });
  }

  void notificationAction(String value) {
    final convertJson = jsonDecode(value);
    final jsonValue = convertJson['path'] as String?;
    if (jsonValue?.isNotEmpty ?? false) {
    }else{
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
