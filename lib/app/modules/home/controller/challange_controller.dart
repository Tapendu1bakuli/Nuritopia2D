import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:headset_connection_event/headset_event.dart';
import 'package:video_player/video_player.dart';
import '../../../../utils/Store/HiveStore.dart';
import '../../../../utils/utils.dart';
import '../../../models/get_audio_music_track_model.dart';
import '../../../models/get_dance_music_track_model.dart';
import '../../../models/header_model.dart';
import '../../../routes/routes.dart';
import '../../../services/core_service.dart';
import '../../../services/urls.dart';
import '../widgets/load_audio_data.dart';

class ChallengeController extends GetxController with GetSingleTickerProviderStateMixin{
 late TabController tabController;
 RxInt selectedIndex = 0.obs;
 RxBool isPlayedRapSong = false.obs;
 final headsetPlugin = HeadsetEvent();
 HeadsetState? headsetState;
  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
     tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
        selectedIndex.value = tabController.index;
      print("Selected Index: " + tabController.index.toString());
        //player.stop();
    });
    headsetPlugin.setListener((_val) {
        headsetState = _val;
    });
  }
 @override
  void dispose() {
    print("Dispose");
    player.stop();
    player.dispose();
    super.dispose();
  }
  @override
  void onClose() {
    print("onClose");
    player.stop();
    player.dispose();
    super.dispose();
  }

  late VideoPlayerController videController;
  Duration? maxDuration ;
  Duration? position = Duration.zero;
  late AudioPlayer player = AudioPlayer();
  List<double> samples = [];
  int totalSamples = 80;
  List<List<String>> audioDataList = [
    [
      'assets/audio/dm.json',
    ],
  ];
 late List<String> audioData = audioDataList[0];
RxBool isValueChanged = false.obs;
  Future<void> parseData() async {
    player = AudioPlayer();
    await player.setSourceUrl(getAudioMusicTrackModel.getMusicTrackData?.musicPath??"https://cdn.pixabay.com/audio/2023/09/26/audio_5419786d14.mp3" );
    maxDuration = await player.getDuration();
    print("MAXDuration:$maxDuration");
    player.onDurationChanged.listen(
            (value) {
              maxDuration = value;
          print("Duration:$maxDuration");
        }
    );
    player.onPositionChanged.listen(
            (value) {
          position = value;
          print("position:$position");
          isValueChanged.value = true;
          isValueChanged.refresh();
        }
    );
    player.setReleaseMode(ReleaseMode.stop);
    final json = await rootBundle.loadString(audioData[0]);
    Map<String, dynamic> audioDataMap = {
      "json": json,
      "totalSamples": totalSamples,
    };
    final samplesData = await compute(loadparseJson, audioDataMap);
    casual.value = true;
    samples = samplesData["samples"];
    if((maxDuration?.inMilliseconds ?? 0 ) > 0 ){
      isValueChanged.value = true;
      isValueChanged.refresh();
    }
  }
  late final AnimationController animationController;
  RxBool isExpanded = false.obs;
  RxBool casual = false.obs;
  RxBool isLoading = false.obs;
  RxString stageName = "".obs;
  RxString rapStageName = "".obs;

  TextEditingController stageNameController = TextEditingController();
  RxBool onSubmit = false.obs;
  CarouselController homeCarousalController = CarouselController();
 GetDanceMusicTrackModel getDanceMusicTrackModel = GetDanceMusicTrackModel();
 GetAudioMusicTrackModel getAudioMusicTrackModel = GetAudioMusicTrackModel();

 //Get dancing video track
 Future getDanceVideo() async {
   isLoading.value = true;
   await getDanceVideoApiCall().then((result) async {
     if (result is GetDanceMusicTrackModel) {
       if (result.status == "success") {
       getDanceMusicTrackModel = result;
       getAudioTrack();
       } else {
         isLoading.value = false;
         showFailureSnackBar(
             "Failed", result.message ?? "");
       }
     }
   });
 }

 //Get dancing video track API call
 getDanceVideoApiCall() async {
   HeaderModel headerModel = HeaderModel(
     token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
     nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
   );
   var result = await CoreService().apiService(
     header: headerModel.toHeader(),
     ssl: SSL.HTTP,
     baseURL: Urls.baseUrl,
     commonPoint: Urls.API,
     method: METHOD.GET,
     endpoint: Urls.getDanceMusicTrack,
   );
   return GetDanceMusicTrackModel.fromJson(result);
 }

 //Get singing music track
 Future getAudioTrack() async {
   await getAudioTrackApiCall().then((result) async {
     if (result is GetAudioMusicTrackModel) {
       if (result.status == "success") {
         getAudioMusicTrackModel = result;
         await parseData();
         Get.toNamed(Routes.TAKECHALLENGE);
         isLoading.value = false;
       } else {
         isLoading.value = false;
         showFailureSnackBar(
             "Failed", result.getMusicTrackData?.message ?? "");
       }
     }
   });
 }

 //Get singing music track API call
 getAudioTrackApiCall() async {
   HeaderModel headerModel = HeaderModel(
     token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
     nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
   );
   var result = await CoreService().apiService(
     header: headerModel.toHeader(),
     ssl: SSL.HTTP,
     baseURL: Urls.baseUrl,
     commonPoint: Urls.API,
     method: METHOD.GET,
     endpoint: Urls.getMusicTrack,
   );
   return GetAudioMusicTrackModel.fromJson(result);
 }

 //Upload Video
 Future uploadVideo(int? musicId,String? videoUrl,int? videoType,String? stageName) async {
   isLoading.value = true;
   await uploadVideoApiCall(musicId,videoUrl,videoType,stageName).then((result) async {
       if (result["status"] == "Success") {
         isLoading.value = false;
         Get.offAllNamed(Routes.VOTESUBMITTEDSUCCESSFULL);
       } else {
         isLoading.value = false;
         showFailureSnackBar(
             "Failed", result.getMusicTrackData?.message ?? "");
       }
   });
 }

 //Upload Video API call
 uploadVideoApiCall(int? musicId,String? videoUrl,int? videoType,String? stageName) async {
   HeaderModel headerModel = HeaderModel(
     token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
     nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
   );
   var result = await CoreService().apiService(
     header: headerModel.toHeader(),
     body: {
       "musicId":musicId,
       "videoUrl":videoUrl,
       "videoType":videoType,
       "stageName":stageName,
     },
     ssl: SSL.HTTP,
     baseURL: Urls.baseUrl,
     commonPoint: Urls.API,
     method: METHOD.POST,
     endpoint: Urls.submitVideo,
   );
   return result;
 }

  toggleAnimation() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

}