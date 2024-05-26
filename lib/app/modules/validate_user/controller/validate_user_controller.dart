import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nuritopia2d/app/models/header_model.dart';
import 'package:nuritopia2d/app/models/userVerificationNuritopiaModel.dart';
import 'package:nuritopia2d/app/routes/routes.dart';
import 'package:nuritopia2d/app/services/core_service.dart';
import 'package:nuritopia2d/app/services/urls.dart';
import 'package:nuritopia2d/utils/Store/HiveStore.dart';
import 'package:nuritopia2d/utils/utils.dart';

class ValidateUserController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController verifyUserID = TextEditingController();
  userVerificationNuritopiaModel userverificationModel =
      userVerificationNuritopiaModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future userVerificationWithNuritopia() async {
    isLoading.value = true;
    await userVerificationWithNuritopiaApiCall().then((result) async {
      if (result is userVerificationNuritopiaModel) {
        if (result.status == "Success") {
          HiveStore().put(Keys.NEWUSER, "0");

          Get.offAndToNamed(Routes.HOME);
          showSuccessSnackBar(
              "Success", result.message ?? "Successfully verified.");
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showFailureSnackBar("Failed", "Fetching details failed.");
        }
      }
    });
  }

  //Get Performer Details API call
  userVerificationWithNuritopiaApiCall() async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      body: {
        "email": HiveStore().get(Keys.EMAIL),
        "nuritopiaUserId": verifyUserID.text
      },
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      commonPoint: Urls.APIV2,
      method: METHOD.POST,
      endpoint: Urls.userVerification,
    );
    return userVerificationNuritopiaModel.fromJson(result);
  }
}
