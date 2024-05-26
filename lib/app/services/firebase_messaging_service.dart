import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/utils/Store/HiveStore.dart';

import '../../utils/LocalNotification.dart';
import '../models/receivedNotificationModel.dart';
// import '../models/receivedNotificationModel.dart';

class FireBaseMessagingService extends GetxService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<FireBaseMessagingService> init() async {
      await Firebase.initializeApp();
    FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);
      enableIOSNotifications();

    await fcmOnLaunchListeners();
    await fcmOnResumeListeners();
    await fcmOnMessageListeners();
    setDeviceToken();
    return this;
  }


  Future fcmOnMessageListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("fcmOnMessageListeners");
      print("Message.data>>>>>>>>:$message");
      final notification = LocalNotification("new");
      NotificationsBloc.instance.newNotification(notification);
      /*Creating channel for notifications*/
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'your_channel_id',
        'your_channel_name',
        description: 'your_channel_description',
        importance: Importance.high,
        showBadge: true,
        enableVibration: true,
        playSound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings iOSSettings =
      DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      );
      const InitializationSettings initSettings =
      InitializationSettings(android: androidSettings, iOS: iOSSettings);
      flutterLocalNotificationsPlugin.initialize(
        initSettings,
          onDidReceiveNotificationResponse: (NotificationResponse details) {
          Get.log("sdsdsdsdfhdf$details");
          }
            );
      // Future.delayed(Duration(seconds: 10), () {
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          priority: Priority.high,
          importance: Importance.max,
          playSound: true,
          icon: '@mipmap/ic_launcher'
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true
        )
      );

      flutterLocalNotificationsPlugin.show(
        message.data.hashCode ?? 0, // Notification ID, use a unique value for each notification
         message.notification?.title ?? "",
         message.notification?.body ?? "",
        notificationDetails,
      );
    });
  }

  Future fcmOnLaunchListeners() async {
    RemoteMessage? message =
    await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      _notificationsBackground(message);
    }
  }

  Future fcmOnResumeListeners() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notificationsBackground(message);
    });
  }

  void _notificationsBackground(RemoteMessage message) {
    print("Message Data:${message.notification}");
    print("Message Data:${message.data}");
    if (message.data.isEmpty) {} else
    if (message.data['id'] == "App\\Notifications\\NewMessage") {
      _newMessageNotificationBackground(message);
    } else {
      _newBookingNotificationBackground(message);
    }
  }

  void _newBookingNotificationBackground(message) {
    print("_newBookingNotificationBackground");
  }

  void _newMessageNotificationBackground(RemoteMessage message) {
    print("_newMessageNotificationBackground");
  }

  Future<void> setDeviceToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM token : $fcmToken");
    if (fcmToken != null) {
      HiveStore().setString(Keys.FCMTOKEN, fcmToken);
    }
  }

  void _bookingNotification() async {
    AndroidNotificationChannel androidNotificationChannel() =>
        const AndroidNotificationChannel(
          'your_channel_id', // id
          'your_channel_name', // title// description
          description:
          'your_channel_description', // description
          importance: Importance.max,
        );
  }

  void _newMessageNotification(RemoteMessage message) {
  }


  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
}
