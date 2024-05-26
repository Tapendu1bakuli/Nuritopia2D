import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../../models/winner_list_model.dart';
import '../../../../routes/routes.dart';
import '../../../voting/controller/voting_controller.dart';
class WinnersVideoPlayBack extends StatefulWidget {
  WinnersVideoPlayBack(
      {Key? key,
        this.videoPath,
        this.beatname,
        this.artistName,
        this.performerEmail,
        this.performerNickName,
        this.tos,
        //required this.model,
        this.index})
      : super(key: key);
 // final WinnerListModel model;
  final String? videoPath;
  final String? performerEmail;
  final String? performerNickName;
  final String? beatname;
  final String? tos;
  final String? artistName;
  final int? index;
  @override
  _WinnersVideoPlayBackState createState() => _WinnersVideoPlayBackState();
}

class _WinnersVideoPlayBackState extends State<WinnersVideoPlayBack>
    with WidgetsBindingObserver {

  bool isLoading = false;
  bool _isPlaying = false;
  VideoPlayerController? _controller = VideoPlayerController.network("");
  Directory? dir;
  var progressString = "";
  bool isloaded = false;
  bool onInit = false;
  bool _isDisposed = false;

  @override
  void initState() {
    onInit = true;
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _initializeVideo(0);
    // downloadFile();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isDisposed = true;
    super.dispose();
    if (!mounted) _controller!.pause();
    _controller!.removeListener(() {
      setState(() {});
    });
    _controller!.dispose();
  }

  @override
  void deactivate() {
    print("deactivate");
    if (!mounted) _controller!.pause();
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!mounted) _controller!.pause();
    _isPlaying = false;
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState suspending');
        break;
      case AppLifecycleState.hidden:
        print('appLifeCycleState hidden');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColor.primaryBlue,
          centerTitle: true,
          title: Text(
            "${AppStrings.beat.tr}${widget.beatname}",
            style:
            const TextStyle(color: CustomColor.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: CustomColor.primaryBlue),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: CustomColor.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Center(child: getVideoPart()),
            color: CustomColor.homeGrey,
          ),
        ));
  }

  getVideoPart() {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        _playView(context),
        Visibility(
          visible: _controller!.value.isInitialized,
          child: Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                if (_controller!.value.isPlaying) {
                  setState(() {
                    _controller!.pause();
                    _isPlaying = false;
                    //Wakelock.disable();
                  });
                } else {
                  setState(() {
                    _controller!.play();
                    _isPlaying = true;
                   // Wakelock.enable();
                  });
                }
              },
              child: CircleAvatar(
                radius: 33,
                backgroundColor: _controller!.value.isPlaying
                    ? Colors.transparent
                    : Colors.black38,
                child: _controller!.value.isPlaying
                    ? _controller!.value.isBuffering
                    ? CircularProgressIndicator(
                  color: CustomColor.secondaryBlue,
                )
                    : Offstage()
                    : Icon(
                  Icons.play_arrow,
                  color: CustomColor.primaryBlue,
                  size: 50,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _playView(BuildContext context) {
    if (_controller!.value.isInitialized) {
      return GestureDetector(
        onTap: () {
          if (_controller!.value.isPlaying) {
            setState(() {
              _controller!.pause();
              _isPlaying = false;
             // Wakelock.disable();
            });
          }
        },
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(_controller!),
              VideoProgressIndicator(_controller!, allowScrubbing: true),
              Positioned(
                  bottom: ScreenConstant.screenHeightMinimum,
                  left: ScreenConstant.screenWidthFifteen,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultHeightTwentyThree,vertical: ScreenConstant.defaultWidthTen),
                    decoration: BoxDecoration(color: CustomColor.white.withOpacity(0.2),borderRadius: BorderRadius.circular(15),border: Border.all(width: 2,color: CustomColor.white.withOpacity(0.15))),
                    child: Row(
                      children: [
                        Image.asset(ImageUtils.vote,scale: 3,),
                        Container(width: ScreenConstant.defaultWidthTen,),
                        Text("${AppStrings.vote.tr.toUpperCase()} : ${widget.tos}",style: TextStyles.redHeartTextStyleStyleBold.copyWith(fontSize: 12,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  )),
              Positioned(
                  bottom: ScreenConstant.screenHeightMinimum,
                  right: ScreenConstant.screenWidthFifteen,
                  child: InkWell(
                    onTap: (){
                      print(widget.performerNickName);
                      print(widget.performerEmail);
                      print(widget.beatname);
                      Get.toNamed(Routes.CONNECTWITHPERSON,
                          arguments: [
                            widget.performerNickName,
                            widget.performerEmail,
                            widget.beatname,
                          ]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultHeightTwentyThree,vertical: ScreenConstant.defaultWidthTen),
                      decoration: BoxDecoration(color: CustomColor.white.withOpacity(0.2),borderRadius: BorderRadius.circular(15),border: Border.all(width: 2,color: CustomColor.white.withOpacity(0.15))),
                      child: Row(
                        children: [
                          Image.asset(ImageUtils.connect,color: CustomColor.primaryBlue,scale: 3,),
                          Container(width: ScreenConstant.defaultWidthTen,),
                          Text("${AppStrings.connect.tr.toUpperCase()}",style: TextStyles.redHeartTextStyleStyleBold.copyWith(fontSize: 12,fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
              color: CustomColor.homeGrey,
              child: Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.primaryBlue,
                  ))));
    }
  }

  void saveWinnersVideo(element) async {
    String dirLoc = (await getApplicationDocumentsDirectory()).path;
    await downloadFile(element.path, element.uniqueName, dirLoc, element);
  }

  Future<String> downloadFile(
      String url, String fileName, String dir, element) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
    } catch (ex) {
      filePath = 'Can not fetch url';
    }
    print("FilePath : $filePath");
    element.savedVideoLocation = filePath;
    return filePath;
  }

  _initializeVideo(int index) async {
    if (_controller!.value.isInitialized) {
      _controller!.pause();
      _controller!.dispose();
    }
    _controller = VideoPlayerController.network("");

    _initWinnersController();
  }

  void _initWinnersController() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/abcd');
    print("File Exist: ${await file.exists()}");
    if (await file.exists()) {
      setState(() {
        _controller = VideoPlayerController.file(
          file,
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
      });
    } else {
      //saveWinnersVideo(widget.model);
      setState(() {
        _controller = VideoPlayerController.network(
          widget.videoPath!,
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
      });
    }
    _controller!.addListener(() {
      setState(() {});
    });
    _controller!.setLooping(false);
    _controller!.initialize().then((_) => setState(() {
      if (onInit) {
        _controller!.pause();
        onInit = false;
      } else {
        _controller!.play();
      }
     // Wakelock.enable();
    }));
  }
}
