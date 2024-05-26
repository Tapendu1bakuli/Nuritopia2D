import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nuritopia2d/utils/Store/HiveStore.dart';
import 'app/routes/app_pages.dart';
import 'app/services/firebase_messaging_service.dart';
import 'firebase_options.dart';
import 'languages/LocalizationService.dart';
import 'package:permission_handler/permission_handler.dart';

//init Time
List<CameraDescription> cameras = [];
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'your_channel_id', // id
    'your_channel_name', // title// description
    importance: Importance.high,
    showBadge: true);
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'] ?? "",
      message.data['body'] ?? "",
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              styleInformation: const BigTextStyleInformation("")),
          iOS: const DarwinNotificationDetails(
              presentAlert: true, presentBadge: true, presentSound: true)));
}

Future<void> initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  // await Get.putAsync(() => GlobalService().init());
  //  await Get.putAsync(() => LaravelApiClient().init());
  // await Get.putAsync(() => SettingsService().init());
  // await Get.putAsync(() => TranslationService().init());
  Get.log('All services started...');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStore().initBox();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Permission.notification;
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    print("Cameras:$cameras");
  } on CameraException catch (e) {
    if (e.description != null) {
      print('Error: ${e.code}\nError Message: ${e.description}');
    } else {
      print('Error: ${e.code}');
    }
  }
  await initServices();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(GetMaterialApp(
    onReady: () async {
      // 1=android
      // 2=ios
      if (Platform.isAndroid) {
        HiveStore().setString(Keys.DEVICETYPE, "1");
      } else if (Platform.isIOS) {
        HiveStore().setString(Keys.DEVICETYPE, "2");
      }
      await Get.putAsync(() => FireBaseMessagingService().init());
    },
    localizationsDelegates: const [
      // GlobalMaterialLocalizations.delegate,
      // GlobalWidgetsLocalizations.delegate,
      // GlobalCupertinoLocalizations.delegate,
    ],
    translations: LocalizationService(),
    supportedLocales: LocalizationService.locales,
    // translationsKeys: Get.find<TranslationService>().translations,
    locale: LocalizationService.locale,
    fallbackLocale: LocalizationService.fallbackLocale,
    defaultTransition: Transition.cupertino,
    debugShowCheckedModeBanner: false,
    initialRoute: Theme1AppPages.INITIAL,
    getPages: Theme1AppPages.routes,
    // themeMode: Get.find<SettingsService>().getThemeMode(),
    // theme: Get.find<SettingsService>().getLightTheme(),
    // darkTheme: Get.find<SettingsService>().getDarkTheme(),
  ));
}
