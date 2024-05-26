import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import '../../../../utils/Store/HiveStore.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/utils.dart';
import '../../../models/carousal_image_model.dart';
import '../../../models/get_dance_voting_video_model.dart';
import '../../../models/get_rap_voting_video_model.dart'
    as getRapVotingVideoModel;
import '../../../models/get_rap_voting_video_model.dart';
import '../../../models/header_model.dart';
import '../../../models/performer_details_model.dart';
import '../../../models/vote_bottom_avater_model.dart';
import '../../../models/winner_dance_list_model.dart' as winnerDanceListModel;
import '../../../models/winner_dance_list_model.dart';
import '../../../routes/routes.dart';
import '../../../services/core_service.dart';
import '../../../services/urls.dart';
import '../../network_checker/controller/network_checker_controller.dart';

class VotingController extends GetxController {
  final CommonNetWorkStatusCheckerController netWorkStatusChecker =
      Get.put(CommonNetWorkStatusCheckerController());
  RxBool isPlaying = false.obs;
  RxBool isChallenges = false.obs;
  RxInt originalPrice = 1.obs;
  RxInt minimumPrice = 1.obs;
  RxInt maximumPrice = 5200.obs;
  RxBool isLimitReachedMaximum = false.obs;
  RxBool isLimitReachedMinimum = false.obs;

  negotiationPriceSetting(
      int minimum, int original, int maximum, bool isIncrease) {
    if (isIncrease == true) {
      if (originalPrice.value <= maximumPrice.value) {
        originalPrice.value = original + 1;
        original = originalPrice.value;
        //print("Increased Fare:$originalPrice");
      }
      if (originalPrice.value >= maximumPrice.value) {
        isLimitReachedMaximum.value = true;
        isLimitReachedMinimum.value = false;
      } else {
        isLimitReachedMinimum.value = false;
        isLimitReachedMaximum.value = false;
      }
    } else {
      if (originalPrice.value >= minimumPrice.value &&
          originalPrice.value > 1) {
        originalPrice.value = original - 1;
        original = originalPrice.value;
        //print("Decreased Fare:$originalPrice");
      }
      if (originalPrice.value <= minimumPrice.value) {
        isLimitReachedMinimum.value = true;
        isLimitReachedMaximum.value = false;
      } else {
        isLimitReachedMinimum.value = false;
        isLimitReachedMaximum.value = false;
      }
    }
    isLimitReachedMaximum.refresh();
    isLimitReachedMinimum.refresh();
  }

  RxList<VoteBottomAvatarModel> voteBottomAvatarModel = [
    VoteBottomAvatarModel(
        image: ImageUtils.male1, ontap: () {}, isSelected: true),
    VoteBottomAvatarModel(
        image: ImageUtils.male2, ontap: () {}, isSelected: false),
    VoteBottomAvatarModel(
        image: ImageUtils.female1, ontap: () {}, isSelected: false),
    VoteBottomAvatarModel(
        image: ImageUtils.female2, ontap: () {}, isSelected: false),
  ].obs;
  RxInt currentIndex = 0.obs;
  late VideoPlayerController videoPlayerController;
  num maxVote = 0;
  RxList<String> videoList = <String>[
    "https://dbd716yj1y561.cloudfront.net/music/yqJcAXOgvILb9UIQWsWCcvfiy39zscD1L6IhTPTt.mp4",
    "https://dbd716yj1y561.cloudfront.net/music/zI0UeApXByaGetceVI80c35rmrR9EVfHvPhYt7RD.mp4",
    "https://dbd716yj1y561.cloudfront.net/music/yqJcAXOgvILb9UIQWsWCcvfiy39zscD1L6IhTPTt.mp4",
    "https://dbd716yj1y561.cloudfront.net/music/yqJcAXOgvILb9UIQWsWCcvfiy39zscD1L6IhTPTt.mp4"
  ].obs;
  Map<dynamic, dynamic> storeRaps = <dynamic, dynamic>{};
  Map<dynamic, dynamic> storeDance = <dynamic, dynamic>{};
  DanceVotingVideoModel danceVotingVideoModel = DanceVotingVideoModel();
  PerformerDetailsModel performerDetailsModel = PerformerDetailsModel();
  RxList<GetDanceVotingVideoData> danceVotingVideoLists =
      <GetDanceVotingVideoData>[].obs;
  RxList<getRapVotingVideoModel.VotingVideoList> rapVotingVideoLists =
      <getRapVotingVideoModel.VotingVideoList>[].obs;
  RxList<winnerDanceListModel.VotingVideoList> winnerListDance =
      <winnerDanceListModel.VotingVideoList>[].obs;
  RxBool onSubmit = false.obs;
  TextEditingController currentPasswordController = TextEditingController();
  RxString beatName = "".obs;
  CarouselController homeCarousalController = CarouselController();
  List<CarousalImageModel> playVideo = [
    CarousalImageModel(
        title: "",
        subtitleLarge: "",
        subtitleMid: "",
        image:
            "http://122.248.251.140/storage/AppSlider/eUgH2hbiZaM63pJrgXw1vWDOPx0MqEmrjWaQvOv5.png",
        ontap: () {}),
    CarousalImageModel(
        title: "",
        subtitleLarge: "",
        subtitleMid: "",
        image:
            "http://122.248.251.140/storage/AppSlider/eUgH2hbiZaM63pJrgXw1vWDOPx0MqEmrjWaQvOv5.png",
        ontap: () {}),
    CarousalImageModel(
        title: "",
        subtitleLarge: "",
        subtitleMid: "",
        image:
            "http://122.248.251.140/storage/AppSlider/eUgH2hbiZaM63pJrgXw1vWDOPx0MqEmrjWaQvOv5.png",
        ontap: () {}),
  ];
  List<CarousalImageModel> carousalModel = [
    CarousalImageModel(
        title: "Dance",
        subtitleLarge: "Party Night",
        subtitleMid: "Know More Details Here",
        image: ImageUtils.carousalImages,
        ontap: () {}),
    CarousalImageModel(
        title: "Dance",
        subtitleLarge: "Party Night",
        subtitleMid: "Know More Details Here",
        image: ImageUtils.carousalImages,
        ontap: () {}),
    CarousalImageModel(
        title: "Dance",
        subtitleLarge: "Party Night",
        subtitleMid: "Know More Details Here",
        image: ImageUtils.carousalImages,
        ontap: () {}),
  ];
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    netWorkStatusChecker.updateConnectionStatus();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoList[0]))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          });
  }

  RxBool isLoading = false.obs;

  @override
  void dispose() {
    super.dispose();
  }

  String formatDate(String inputString) {
    // Parse the input string into a DateTime object
    DateTime dateTime = DateTime.parse(inputString);

    // Format the DateTime object
    String formattedDate = DateFormat('dd MMM,yyyy').format(dateTime);

    return formattedDate;
  }

  //Get Dance Voting Video
  Future getDanceVideo() async {
    isLoading.value = true;
    await getDanceVideoApiCall().then((result) async {
      if (result is DanceVotingVideoModel) {
        if (result.status == "success") {
          currentIndex.value = 0;
          danceVotingVideoLists.value = result.getDanceVotingVideoData ?? [];
          danceVotingVideoLists[currentIndex.value].isSelected = true;
          beatName.value =
              danceVotingVideoLists[currentIndex.value].beatName ?? "";
          print("Length:${danceVotingVideoLists.length}");
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showFailureSnackBar("Failed", result.message ?? "Login Failed");
        }
      }
    });
  }

  //Get Dance Voting Video API call
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
      endpoint: Urls.getDanceVotingVideo,
    );
    return DanceVotingVideoModel.fromJson(result);
  }

  //Get Rap Voting Video
  Future getRapVideo() async {
    isLoading.value = true;
    await getRapVideoApiCall().then((result) async {
      if (result is GetRapVotingVideoModel) {
        if (result.status == "Success") {
          currentIndex.value = 0;
          rapVotingVideoLists.value = result.votingVideoList ?? [];
          rapVotingVideoLists[currentIndex.value].isSelected = true;
          beatName.value =
              rapVotingVideoLists[currentIndex.value].beatName ?? "";
          print("LengthRap:${rapVotingVideoLists.length}");
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showFailureSnackBar(
              "Failed", result.message ?? "There is no singing list");
        }
      }
    });
  }

  //Get Rap Voting Video API call
  getRapVideoApiCall() async {
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
      endpoint: Urls.getRapVotingVideo,
    );
    return GetRapVotingVideoModel.fromJson(result);
  }

  //Search winner Dance
  Future getWinner(String? type, String? searchValue) async {
    isLoading.value = true;
    await getWinnerApiCall(type, searchValue).then((result) async {
      if (result is WinnerDanceListModel) {
        if (result.status == "Success") {
          winnerListDance.clear();
          winnerListDance.value = result.votingVideoList ?? [];
          isLoading.value = false;
        } else {
          winnerListDance.clear();
          isLoading.value = false;
          showFailureSnackBar("Failed", result.message ?? "Login Failed");
        }
      }
    });
  }

  //Search winner Dance API call
  getWinnerApiCall(String? type, String? searchValue) async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      body: {"video_type": type, "search_val": searchValue},
      method: METHOD.POST,
      endpoint: Urls.searchWinnerDance,
    );
    return WinnerDanceListModel.fromJson(result);
  }

  //Get Performer Details
  Future getPerformerDetails(
      String? performerNickName, String? performerEmail) async {
    isLoading.value = true;
    await performerDetailsApiCall(performerNickName, performerEmail)
        .then((result) async {

      if (result is PerformerDetailsModel) {

        if (result.status == "Success") {

          performerDetailsModel = result;
          // Get.log("responsee>>>>>>>getperfremr>>>>>${performerDetailsModel}");
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showFailureSnackBar("Failed", "Fetching details failed.");
        }
      }
    });
  }

  //Get Performer Details API call
  performerDetailsApiCall(
      String? performerNickName, String? performerEmail) async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: {
        'performar_nuritopia_nickname': performerNickName,
        'performar_email': performerEmail
      },
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      commonPoint: Urls.API,
      method: METHOD.POST,
      endpoint: Urls.getPerformerDetails,
    );
    return PerformerDetailsModel.fromJson(result);
  }

  //Submit voting Details
  Future submitVotingDetails(
      String? type,
      String? singingVideoId,
      String? dancingVideoId,
      String? vote,
      String? artistName,
      String? beatName,
      String? videoName) async {
    isLoading.value = true;
    await submitVotingDetailsApiCall(type, singingVideoId, dancingVideoId, vote,
            artistName, beatName, videoName)
        .then((result) async {
      if (result is PerformerDetailsModel) {
        if (result.status == "Success") {
          // Get.back();
          Get.toNamed(Routes.VOTESUBMITTEDSUCCESSFULL);
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showFailureSnackBar("Failed", "Fetching details failed.");
        }
      }
    });
  }

  //Get Performer Details API call
  submitVotingDetailsApiCall(
      String? type,
      String? singingVideoId,
      String? dancingVideoId,
      String? vote,
      String? artistName,
      String? beatName,
      String? videoName) async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: type == "S"
          ? {
              'type': type,
              'singing_video_id': singingVideoId,
              'vote': vote,
              'artist_name': artistName,
              'beat_name': beatName,
              'video_name': videoName,
            }
          : {
              'type': type,
              'dance_video_id': dancingVideoId,
              'vote': vote,
              'artist_name': artistName,
              'beat_name': beatName,
              'video_name': videoName,
            },
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      commonPoint: Urls.APIV2,
      method: METHOD.POST,
      endpoint: Urls.submitVotingDetails,
    );
    return PerformerDetailsModel.fromJson(result);
  }
}
