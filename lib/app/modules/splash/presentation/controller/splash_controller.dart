import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../utils/Store/HiveStore.dart';
import '../../../../routes/routes.dart';

class SplashController extends GetxController{
  RxBool? casual = true.obs;
  PermissionStatus? _cameraPermission;
  PermissionStatus? _micPermission;
  bool permissionsCompleted = false;
  PermissionStatus? _notificationsPermission;
  PermissionStatus? _mediaPermission;
  void displayPermissionRequests() async {
    await requestCameraPermission();
    await requestMicPermission();
    await requestNotificationsPermission();
    await requestFileAccessPermission();
    permissionsCompleted = true;
    // await HiveStore().initBox();
    //HiveStore().clear();
  }
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.request();
    _cameraPermission = status;
  }
  Future<void> requestMicPermission() async {
    var status = await Permission.microphone.request();
    _micPermission = status;
  }
  Future<void> requestNotificationsPermission() async {
    var status = await Permission.notification.request();
    _notificationsPermission = status;
  }
  Future<void> requestFileAccessPermission() async {
    var status = await Permission.storage.request();
    _mediaPermission = status;
  }
@override
  void onReady() {
    print("OnReady");
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  Timer(const Duration(seconds: 3), () async {
    if(await HiveStore().get(Keys.FIRSTTIMELOGIN) != "yes"){
      Get.offAllNamed(Routes.LANGUAGESELECTIONSCREEN);
    }else{
      HiveStore().get(Keys.NEWUSER) == "1" && HiveStore().get(Keys.OPENEDITPROFILEPAGE) != "false"?
          Get.offAllNamed(Routes.EDITPROFILE):
      Get.offAndToNamed(Routes.HOME)   ;
    }
  });
  displayPermissionRequests();
    super.onReady();
  }
}