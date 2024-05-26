import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nuritopia2d/app/models/transaction_model.dart';
import '../../../../utils/Store/HiveStore.dart';
import '../../../../utils/utils.dart';
import '../../../models/get_wallet_details_model.dart';
import '../../../models/header_model.dart';
import '../../../services/core_service.dart';
import '../../../services/urls.dart';
import '../../network_checker/controller/network_checker_controller.dart';

class WalletController extends GetxController {
  final CommonNetWorkStatusCheckerController netWorkStatusChecker =
      Get.put(CommonNetWorkStatusCheckerController());
  RxBool casual = true.obs;
  late TextEditingController textController = TextEditingController();
  RxInt tosToken = 0.obs;
  RxDouble originalPrice = 0.0.obs;
  RxDouble minimumPrice = 100.0.obs;
  RxDouble maximumPrice = 5200.0.obs;
  RxInt usd = 0.obs;
  RxBool isLimitReachedMaximum = false.obs;
  RxBool isLimitReachedMinimum = false.obs;
  RxBool isReferral = true.obs;
  RxBool isChallenges = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
  RxBool isHasMore = true.obs;

  GetWalletDetailsModel getWalletDetailsModel = GetWalletDetailsModel();
  final ScrollController scrollControllerForWalletHistory = ScrollController();
  negotiationPriceSetting(
      double minimum, double original, double maximum, bool isIncrease) {
    if (isIncrease == true) {
      if (originalPrice.value <= maximumPrice.value) {
        originalPrice.value = original + 5;
        original = originalPrice.value;
      }
      if (originalPrice.value >= maximumPrice.value) {
        isLimitReachedMaximum.value = true;
        isLimitReachedMinimum.value = false;
      } else {
        isLimitReachedMinimum.value = false;
        isLimitReachedMaximum.value = false;
      }
    } else {
      if (originalPrice.value >= minimumPrice.value) {
        originalPrice.value = original - 5;
        original = originalPrice.value;
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

  void incrementMethod() {
    print("Value:${textController.text}");
    textController.text =
        (int.parse(textController.text) + tosToken.value).toString();
    usd.value += 1;
  }

  void decrementMethod() {
    print("Value:${textController.text}");
    if (int.parse(textController.text) <= tosToken.value) {
      return;
    } else {
      textController.text =
          (int.parse(textController.text) - tosToken.value).toString();
      usd.value -= 1;
    }
  }

  int currentPage = 1;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    netWorkStatusChecker.updateConnectionStatus();
    scrollControllerForWalletHistory.addListener(() {
// // nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger =
          0.55 * scrollControllerForWalletHistory.position.maxScrollExtent;
// // _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
      // if (scrollControllerForWalletHistory.position.pixels > nextPageTrigger) {
      //   isLoading.value = true;
      //   currentPage = currentPage + 1;

      // }
      scrollControl();
      Get.log("PAggege>>${currentPage}");
    });
  }

  void scrollControl() {
    if (scrollControllerForWalletHistory.position.pixels ==
        scrollControllerForWalletHistory.position.maxScrollExtent) {
      if (isHasMore.value) {
        if (!isLoadMore.value) {
          print('loaddingngn');

          isLoadMore.value = true;
          currentPage = currentPage + 1;
          getTransactionHistory(currentPage);
          isLoadMore.value = false;
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  RxInt balance = 0.obs;
  //Get Wallet Details
  Future getWalletDetails() async {
    isLoading.value = true;
    await getWalletDetailsApiCall().then((result) async {
      if (result["status"] == "Success") {
        // getWalletDetailsModel = GetWalletDetailsModel.fromJson(result);
        balance.value = result["balance"];
        isLoading.value = false;
      } else {
        showFailureSnackBar(
            "Failed", result["error"] ?? "Account deletion failed");
        isLoading.value = false;
      }
    });
  }

  //Get Wallet Details API call
  getWalletDetailsApiCall() async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      commonPoint: Urls.APIV2,
      baseURL: Urls.baseUrl,
      method: METHOD.GET,
      endpoint: Urls.getWalletDetails,
    );
    return result;
  }

  RxList<TransactionList> transactionList = <TransactionList>[].obs;
  //Get Transaction History
  Future getTransactionHistory(int currentPage) async {
    isLoading.value = true;
    await getTransactionHistoryApiCall(currentPage).then((result) async {
      if (result is TransactionModel) {
        if (result.status == "Success") {
          if (result.data != []) {
            // isLoadMore.value = true;
            isHasMore.value = true;
            transactionList.value += result.data!;
          } else {
            transactionList.value = transactionList.value;
            isHasMore.value = false;
            // isLoadMore.value = false;
          }

          // transactionList.value = result.data ?? [];
          print("Length:${transactionList.length}");
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showFailureSnackBar("Failed", "Transaction list getting failed.");
        }
      }
    });
  }

  //Get Get Transaction History API call
  getTransactionHistoryApiCall(int currentPage) async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      method: METHOD.GET,
      params: {"page": currentPage.toString()},
      commonPoint: Urls.APIV2,
      endpoint: Urls.userTransctionList,
    );
    return TransactionModel.fromJson(result);
  }
}
