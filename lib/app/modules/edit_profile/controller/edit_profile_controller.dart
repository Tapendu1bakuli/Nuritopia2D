import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nuritopia2d/app/models/header_model.dart';
import 'package:nuritopia2d/utils/Store/HiveStore.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../models/carousal_image_model.dart';
import '../../../services/core_service.dart';
import '../../../services/urls.dart';
import '../../network_checker/controller/network_checker_controller.dart';

class EditProfileController extends GetxController {
  RxBool isLoading1 = false.obs;
  TextEditingController verifyUserID = TextEditingController();
  // final Rx<Users> currentUser = Get.find<LoginController>().currentUser;
  final CommonNetWorkStatusCheckerController netWorkStatusChecker =
      Get.put(CommonNetWorkStatusCheckerController());
  List<dynamic> imagelist = [];
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
  CarouselController homeCarousalController = CarouselController();
  RxInt currentIndex = 0.obs;
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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    netWorkStatusChecker.updateConnectionStatus();
    Get.log("nuritooppiistartasssstrrr>>${HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN)}");
    imagelist = jsonDecode(HiveStore().get(Keys.PROFILEIMAGEARRAY));
    // getSlider();
  }

  RxBool isLoading = false.obs;
  @override
  void dispose() {
    super.dispose();
  }

  //getSlider
  Future getSlider() async {
    isLoading.value = true;
    await getSliderApiCall().then((result) async {
      if (result["status"] == "success") {
        Get.log("CarousalImagge>>>>>>>>>>>${result["data"]}");
        // carousalModel = result["data"];
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  //getSlider API call
  getSliderApiCall() async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      baseURL: Urls.baseUrl,
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      method: METHOD.GET,
      commonPoint: Urls.APIV2,
      endpoint: Urls.getSlider,
    );
    Get.log("CarousalImagge>>>>>>>>>>>${result["data"]}");
    return result;
  }
}
