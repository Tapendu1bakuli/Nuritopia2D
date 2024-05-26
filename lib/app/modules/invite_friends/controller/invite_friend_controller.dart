import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:nuritopia2d/app/models/header_model.dart';
import 'package:nuritopia2d/utils/Store/HiveStore.dart';
import '../../../models/invite_friend_model.dart';
import '../../../services/core_service.dart';
import '../../../services/urls.dart';
import '../../network_checker/controller/network_checker_controller.dart';


class InviteFriendController extends GetxController {
  // final Rx<Users> currentUser = Get.find<LoginController>().currentUser;
  final CommonNetWorkStatusCheckerController netWorkStatusChecker =
  Get.put(CommonNetWorkStatusCheckerController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    netWorkStatusChecker.updateConnectionStatus();
    getRewardsStrings();
  }
  RxBool isLoading = false.obs;
  @override
  void dispose() {
    super.dispose();
  }
  InviteFriendModel inviteFriendModel = InviteFriendModel();
  RxList<dynamic> rewardList = <dynamic>[].obs;
  RxString imaggeg ="".obs;
  late Uint8List imagg;
  //getSlider
  Future getRewardsStrings() async {
    isLoading.value = true;
    await getRewardsStringsApiCall().then((result) async {
      if (result["status"] == "Success") {
        Get.log("inviteredponse>>>>$result");
        inviteFriendModel = InviteFriendModel.fromJson(result);
        // imagg = Base64Decoder().convert(inviteFriendModel.qrCode ?? "");
        rewardList.assignAll(inviteFriendModel.RewardPoints as Iterable);
        print("Length:${rewardList}");
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  //getSlider API call
  getRewardsStringsApiCall() async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      commonPoint: Urls.APIV2,
      method: METHOD.GET,
      endpoint: Urls.inviteFriend,
    );
    return result;
  }

}