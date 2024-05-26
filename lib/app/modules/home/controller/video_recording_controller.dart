import 'dart:typed_data';
import 'dart:io' show File, Platform;
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headset_connection_event/headset_event.dart';

import '../../../../utils/localStorage.dart';


class VideoRecordingController extends GetxController with GetSingleTickerProviderStateMixin{
  Future<void>? cameraValue;
  AudioPlayer player = AudioPlayer();
  late final CameraController cameraController;
  bool isRecoring = false;
  bool flash = false;
  bool iscamerafront = true, musicLoaded = false;
  double transform = 0;
  int time = 120;
  late int totalTimeInSeconds;
  late AnimationController controllerAnimation;
  late Animation<double> animation;
  late AnimationController expandController;
  int videoLength = 0;
  double mirror = 0;
  var localStorage = new LocalHiveStorage();
  String url = "";
  int? category;
  String? stageName;
  final headsetPlugin = HeadsetEvent();
  HeadsetState? headsetState;
  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<Null> startCountdown() async {
    controllerAnimation.reverse(
        from: controllerAnimation.value == 0.0 ? 1.0 : controllerAnimation.value);

    totalTimeInSeconds = time;

    controllerAnimation.reverse(
        from: controllerAnimation.value == 0.0 ? 1.0 : controllerAnimation.value);
  }
  endRecording() async {
    Duration duration = controllerAnimation.duration! * controllerAnimation.value;
    XFile videopath = await cameraController.stopVideoRecording();

    cameraController.setFlashMode(FlashMode.off);
      flash = !flash;
      isRecoring = false;
    final file = File(videopath.path);
    Uint8List bytes = file.readAsBytesSync();

    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    String size = sizeInMb.toStringAsFixed(2);

    int videLength = 60 - duration.inSeconds;

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (builder) => VideoViewPage(
    //             stageName: widget.stageName,
    //             path: videopath.path,
    //             category: widget.category,
    //             file: file,
    //             size: size,
    //             videLength: videLength)));
  }
  // startPlayer() async {
  //   url = await localStorage.getValue("musicUrl");
  //   await player.setUrl(url);
  //   player.play();
  //   player.stop();
  //   setState(() {
  //     musicLoaded = true;
  //   });
  //   try {
  //     /*  cameras = await availableCameras();
  //     _audioHandler = await AudioService.init(
  //       builder: () => AudioPlayerHandler(),
  //       config: const AudioServiceConfig(
  //         androidNotificationChannelId: 'com.titos.titosmusic.channel.audio',
  //         androidNotificationChannelName: 'Audio playback',
  //         androidNotificationOngoing: true,
  //       ),
  //     ); */
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
cameraController = CameraController(const CameraDescription(name: 'Camera', lensDirection: CameraLensDirection.front, sensorOrientation: 90), ResolutionPreset.medium);
  }
  @override
  void onClose() {
    print("Dispose");
    super.dispose();
  }
}