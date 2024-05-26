import 'dart:io' show File, Platform;
import 'dart:math';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headset_connection_event/headset_event.dart';
import 'package:nuritopia2d/app/modules/home/views/challange/dance_challange_view.dart';
import 'package:nuritopia2d/app/modules/home/views/challange/rap_challange_view.dart';
import '../../../../../common/widgets/Loader.dart';
import '../../../../../main.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/localStorage.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../../../utils/utils.dart';
import '../../../../routes/routes.dart';
import '../../widgets/OtpTimer.dart';
import 'VideoView.dart';

//List<CameraDescription> cameras=[];

class VideoRecording extends StatefulWidget {
  int? videoType;
  String stageName;
  String audioTrack;
  int? musicId;

  VideoRecording(
      {super.key,
      this.videoType,
      required this.stageName,
      required this.audioTrack,
      this.musicId});

  @override
  VideoRecordingState createState() => new VideoRecordingState();
}

// late AudioHandler _audioHandler;

class VideoRecordingState extends State<VideoRecording>
    with TickerProviderStateMixin {
  AudioPlayer player = AudioPlayer();
  late CameraController _cameraController = CameraController(
    cameras[cameras.length - 1],
    ResolutionPreset.medium,
    enableAudio: true,
    imageFormatGroup: ImageFormatGroup.jpeg,
  );

  Future<void>? cameraValue;
  bool isRecoring = false;
  bool flash = false;
  bool iscamerafront = true, musicLoaded = false;
  double transform = 0;
  int time = 120;
  late int totalTimeInSeconds;
  late AnimationController _controller;
  late Animation<double> animation;
  late AnimationController expandController;
  int videoLength = 0;
  double mirror = 0;
  var localStorage = LocalHiveStorage();
  String url = "";
  final _headsetPlugin = HeadsetEvent();
  HeadsetState? _headsetState;

  startPlayer() async {
    print("Music track:${widget.audioTrack}");
    // url = "https://titoscdn.s3.eu-west-2.amazonaws.com/music/YY7r7LUIgz3Mf3IhFmRo4Nf3ysZEkqW2ENyy85nt.mp3?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA4JKU6W6NRPEW4UGJ%2F20240418%2Feu-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240418T053614Z&X-Amz-SignedHeaders=host&X-Amz-Expires=1800&X-Amz-Signature=a12652d2c2121fcd1d11dcaceab3706ff788dcb050326cbca3b08ba94a556473";
    // await player.setSourceUrl(url);
    player.play(UrlSource(widget.audioTrack));
    player.stop();
    setState(() {
      musicLoaded = true;
    });
    try {
      /*  cameras = await availableCameras();
      _audioHandler = await AudioService.init(
        builder: () => AudioPlayerHandler(),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.titos.titosmusic.channel.audio',
          androidNotificationChannelName: 'Audio playback',
          androidNotificationOngoing: true,
        ),
      ); */
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    startPlayer();
    super.initState();

    /// if headset is plugged
    _headsetPlugin.getCurrentState.then((val) {
      setState(() {
        _headsetState = val;
      });
    });

    /// Detect the moment headset is plugged or unplugged
    _headsetPlugin.setListener((val) {
      setState(() {
        _headsetState = val;
      });
    });
    if (Platform.isIOS) {
      _cameraController = CameraController(
        cameras[cameras.length - 1],
        ResolutionPreset.medium,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.bgra8888,
      );
    } else {
      _cameraController = CameraController(
        cameras[cameras.length - 1],
        ResolutionPreset.medium,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
    }
    cameraValue = _cameraController.initialize();

    totalTimeInSeconds = time;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              player.stop();
              endRecording();
            }
          });
  }

  Future<void> _startCountdown() async {
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    setState(() {
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  endRecording() async {
    Duration duration = _controller.duration! * _controller.value;
    XFile videopath = await _cameraController.stopVideoRecording();

    _cameraController.setFlashMode(FlashMode.off);
    setState(() {
      flash = !flash;
      isRecoring = false;
    });
    final file = File(videopath.path);
    Uint8List bytes = file.readAsBytesSync();

    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    String size = sizeInMb.toStringAsFixed(2);

    int videLength = 60 - duration.inSeconds;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => VideoViewPage(
                musicId: widget.musicId,
                stageName: widget.stageName,
                path: videopath.path,
                category: widget.videoType,
                file: file,
                size: size,
                videoType: widget.videoType,
                videLength: videLength)));
  }

  @override
  void dispose() {
    _controller.dispose();
    _cameraController.dispose();
    //if(expandController.isAnimating)
    //expandController.dispose();
    player.dispose();
    super.dispose();
  }

  // Future<bool> onWillPop() async {
  //   _controller.dispose();
  //   _cameraController.dispose();
  //   // expandController.dispose();
  //   //player.dispose();
  //   widget.category == 1?
  //   Get.back():   Get.toNamed(Routes.TAKECHALLENGE);
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    //  print("ratio:"+ _cameraController.value.aspectRatio.toString());
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: CustomColor.primaryBlue,
            automaticallyImplyLeading: false,
          ),
          body: Stack(
            children: [
              FutureBuilder(
                  future: cameraValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: AspectRatio(
                            aspectRatio: _cameraController.value.aspectRatio,
                            child: CameraPreview(_cameraController),
                          ));
                    } else {
                      return Center(
                        child: Loader(
                          text: "",
                        ),
                      );
                    }
                  }),
              Positioned(
                bottom: 0.0,
                child: Container(
                  color:
                      isRecoring ? Colors.transparent : CustomColor.primaryBlue,
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      musicLoaded
                          ? Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Visibility(
                                  visible: !isRecoring,
                                  child: IconButton(
                                      icon: Icon(
                                        flash
                                            ? Icons.flash_on
                                            : Icons.flash_off,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          flash = !flash;
                                        });
                                        flash
                                            ? _cameraController
                                                .setFlashMode(FlashMode.torch)
                                            : _cameraController
                                                .setFlashMode(FlashMode.off);
                                      }),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (!isRecoring) {
                                      if (widget.videoType == 1) {
                                        print("Status: $_headsetState");
                                        if (_headsetState != null) {
                                          _headsetPlugin.getCurrentState
                                              .then((_val) {
                                            setState(() {
                                              _headsetState = _val;
                                            });
                                          });
                                          if (_headsetState ==
                                              HeadsetState.CONNECT) {
                                            if (_cameraController
                                                .value.isInitialized) {
                                              await _cameraController
                                                  .startVideoRecording()
                                                  .then((value) => {
                                                        setState(() {
                                                          // Wakelock.enable();
                                                        }),
                                                        _startCountdown(),
                                                        prepareAnimations(),
                                                        player.play(UrlSource(
                                                            widget.audioTrack)),
                                                        setState(() {
                                                          isRecoring = true;
                                                        }),
                                                      });
                                            }
                                          } else {
                                            showFailureSnackBar("Failed",
                                                AppStrings.connect_headphone);
                                          }
                                        } else {
                                          showFailureSnackBar("Failed",
                                              AppStrings.connect_headphone);
                                          // Fluttertoast.showToast(
                                          //     msg: AppString.connect_headphone.tr,
                                          //     toastLength: Toast.LENGTH_SHORT,
                                          //     gravity: ToastGravity.CENTER,
                                          //     timeInSecForIosWeb: 1,
                                          //     backgroundColor: Colors.white,
                                          //     textColor: Colors.black,
                                          //     fontSize: 16.0);
                                          // snackBar("Please Connect Your Headphones!",context);
                                        }
                                      } else {
                                        if (_cameraController
                                            .value.isInitialized) {
                                          await _cameraController
                                              .startVideoRecording()
                                              .then((value) => {
                                                    setState(() {
                                                      //Wakelock.enable();
                                                    }),
                                                    _startCountdown(),
                                                    prepareAnimations(),
                                                    player.play(UrlSource(
                                                        widget.audioTrack)),
                                                    setState(() {
                                                      isRecoring = true;
                                                    }),
                                                  });
                                        }
                                      }
                                    } else {
                                      //_audioHandler.stop();
                                      player.stop();

                                      endRecording();
                                    }
                                  },
                                  child: isRecoring
                                      ? const Icon(
                                          Icons.radio_button_on,
                                          color: CustomColor.primaryBlue,
                                          size: 80,
                                        )
                                      : const Icon(
                                          Icons.radio_button_on,
                                          color: Colors.white,
                                          size: 80,
                                        ),
                                ),
                                Visibility(
                                  visible: !isRecoring,
                                  child: IconButton(
                                      icon: Transform.rotate(
                                        angle: transform,
                                        child: const Icon(
                                          Icons.flip_camera_ios,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          iscamerafront = !iscamerafront;
                                          transform = transform + pi;
                                        });
                                        int cameraPos = iscamerafront ? 1 : 0;
                                        _cameraController = CameraController(
                                            cameras[cameraPos],
                                            ResolutionPreset.high);
                                        cameraValue =
                                            _cameraController.initialize();
                                      }),
                                ),
                              ],
                            )
                          : const CircularProgressIndicator(
                              color: CustomColor.primaryBlue,
                            ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: IconButton(
                              icon: widget.videoType == 1
                                  ? Image.asset(
                                      ImageUtils.headphones,
                                      height: 34,
                                      width: 34,
                                    )
                                  : Image.asset(
                                      ImageUtils.computerIcon,
                                      height: 34,
                                      width: 34,
                                    ),
                              onPressed: () async {
                                player.stop();
                                widget.videoType == 1
                                    ? Get.back()
                                    : Get.offAndToNamed(Routes.TAKECHALLENGE);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 15, 10),
                            child: isRecoring
                                ? OtpTimer(_controller, 15.0, Colors.white)
                                : const Text(
                                    "2:00",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
  //
  // _snackBar(String? message, BuildContext _context) {
  //   return Fluttertoast.showToast(
  //       msg: "This is Center Short Toast",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0
  //   );
  //   return Fluttertoast.showToast(
  //       msg: message.toString(),
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.white,
  //       textColor: Colors.black,
  //       fontSize: 16.0);
  // }
}

// class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
//   static final _item = MediaItem(
//     id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
//     album: "Science Friday",
//     title: "A Salute To Head-Scratching Science",
//     artist: "Science Friday and WNYC Studios",
//     duration: const Duration(milliseconds: 5739820),
//     artUri: Uri.parse(
//         'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
//   );
//
//   final _player = AudioPlayer();
//
//   /// Initialise our audio handler.
//   AudioPlayerHandler() {
//     // So that our clients (the Flutter UI and the system notification) know
//     // what state to display, here we set up our audio handler to broadcast all
//     // playback state changes as they happen via playbackState...
//     _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
//     // ... and also the current media item via mediaItem.
//     mediaItem.add(_item);
//
//     // Load the player.
//     _player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
//   }
//
//   // In this simple example, we handle only 4 actions: play, pause, seek and
//   // stop. Any button press from the Flutter UI, notification, lock screen or
//   // headset will be routed through to these 4 methods so that you can handle
//   // your audio playback logic in one place.
//
//   @override
//   Future<void> play() => _player.play();
//
//   @override
//   Future<void> pause() => _player.pause();
//
//   @override
//   Future<void> seek(Duration position) => _player.seek(position);
//
//   @override
//   Future<void> stop() => _player.stop();
//
//   /// Transform a just_audio event into an audio_service state.
//   ///
//   /// This method is used from the constructor. Every event received from the
//   /// just_audio player will be transformed into an audio_service state so that
//   /// it can be broadcast to audio_service clients.
//   PlaybackState _transformEvent(PlaybackEvent event) {
//     return PlaybackState(
//       controls: [
//         MediaControl.rewind,
//         if (_player.playing) MediaControl.pause else MediaControl.play,
//         MediaControl.stop,
//         MediaControl.fastForward,
//       ],
//       systemActions: const {
//         MediaAction.seek,
//         MediaAction.seekForward,
//         MediaAction.seekBackward,
//       },
//       androidCompactActionIndices: const [0, 1, 3],
//       processingState: const {
//         ProcessingState.idle: AudioProcessingState.idle,
//         ProcessingState.loading: AudioProcessingState.loading,
//         ProcessingState.buffering: AudioProcessingState.buffering,
//         ProcessingState.ready: AudioProcessingState.ready,
//         ProcessingState.completed: AudioProcessingState.completed,
//       }[_player.processingState]!,
//       playing: _player.playing,
//       updatePosition: _player.position,
//       bufferedPosition: _player.bufferedPosition,
//       speed: _player.speed,
//       queueIndex: event.currentIndex,
//     );
//   }
// }
