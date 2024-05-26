import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:nuritopia2d/app/models/login_model.dart';
import 'package:nuritopia2d/utils/Store/HiveStore.dart';
import '../../../../common/common_text_form_field.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../models/WinnersModel.dart';
import '../../../models/buy_ticket_details_availability_card_model.dart';
import '../../../models/carousal_image_model.dart';
import '../../../models/drawer_list_widget_model.dart';
import '../../../models/get_slider_model.dart';
import '../../../models/header_model.dart';
import '../../../models/image_link_model.dart';
import '../../../models/reward_account_list_model.dart';
import '../../../models/reward_account_model.dart';
import '../../../models/vote_bottom_avater_model.dart';
import '../../../models/winner_dance_list_model.dart';
import '../../../models/winner_list_model.dart';
import '../../../routes/routes.dart';
import '../../../services/core_service.dart';
import '../../../services/urls.dart';
import '../../network_checker/controller/network_checker_controller.dart';
import '../widgets/dialog/delete_account_dialog.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // final Rx<Users> currentUser = Get.find<LoginController>().currentUser;
  final CommonNetWorkStatusCheckerController netWorkStatusChecker =
      Get.put(CommonNetWorkStatusCheckerController());
  WinnersModelList model = WinnersModelList(
      id: 1,
      beatName: '',
      artistName: '',
      uniqueName: '',
      path: '',
      createdAt: '',
      imageUniqueName: '',
      imagePath: '',
      tos: 2);
  RxBool profileShow = false.obs;
  RxBool isReferral = true.obs;
  RxBool isChallenges = false.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    netWorkStatusChecker.updateConnectionStatus();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    await getUserDetails();
    await getSlider();
    var xx =HiveStore().get(Keys.PROFILEIMAGE)[0];
    Get.log("sdafjdfjsdfnjksdfsdkfndsjkfnkjsdfn${xx.toString()}");
    if (await HiveStore().get(Keys.OPENREFERRALCODE) == "yes") {
      enterReferralCodeDialog();
    }
  }

  Duration maxDuration = Duration(milliseconds: 1000);
  Duration elapsedDuration = Duration();
  List<double> samples = [];
  int totalSamples = 80;

  late List<String> audioData = audioDataList[0];
  List<List<String>> audioDataList = [
    [
      'assets/audio/dm.json',
      'audio/dance_monkey.mp3',
    ],
  ];

  //drawer animation
  late final AnimationController animationController;
  RxBool isExpanded = false.obs;
  RxBool casual = true.obs;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool onSubmit = false.obs;
  CarouselController homeCarousalController = CarouselController();
  RxInt currentIndex = 0.obs;
  RxBool isFalse = false.obs;
  List<ImageLinkModel> imageList = [
    ImageLinkModel(imageUrl: ImageUtils.carousalImage),
    ImageLinkModel(imageUrl: ImageUtils.carousalImage),
    ImageLinkModel(imageUrl: ImageUtils.carousalImage),
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
  RxList<DrawerListWidgetModel> drawerListModel = [
    DrawerListWidgetModel(
        title: AppStrings.inviteFriend.tr,
        icon: ImageUtils.payment,
        ontap: () {
          HiveStore().get(Keys.NEWUSER) == "0"
              ? Get.toNamed(Routes.INVITEFRIEND)
              : verificationDialog();
        },
        isColoured: false),
    // DrawerListWidgetModel(title: AppStrings.rewardAccounts.tr,icon: ImageUtils.payment,ontap: (){Get.toNamed(Routes.REWARDEDACCOUNT);},isColoured: false),
//   DrawerListWidgetModel(title: AppStrings.myTicket.tr,icon: ImageUtils.myTicket,ontap: (){},isColoured: false),
    // DrawerListWidgetModel(title:AppStrings.change_Password.tr ,icon:  ImageUtils.lock,ontap: (){Get.toNamed(Routes.CHANGEPASSWORD);},isColoured: false),
    DrawerListWidgetModel(
        title: AppStrings.wallet.tr,
        icon: ImageUtils.wallet,
        ontap: () {
          Get.toNamed(Routes.WALLET);
        },
        isColoured: false),
    DrawerListWidgetModel(
        title: AppStrings.editProfile.tr,
        icon: ImageUtils.resume,
        ontap: () {
          Get.toNamed(Routes.EDITPROFILE);
        },
        isColoured: false),
    DrawerListWidgetModel(
        title: AppStrings.deleteAccount.tr,
        icon: ImageUtils.deleteAccount,
        ontap: () {
          showAlertDialogForDeleteAccount();
        },
        isColoured: false),
  ].obs;
  List<BuyTicketDetailsAvailabilityCardModel> availableTicketsModel = [
    BuyTicketDetailsAvailabilityCardModel(
        firstTitle: "CAT-1",
        secondTitle: "1",
        secondSubTitle: "15000 TOS / seat",
        ontap: () {}),
    BuyTicketDetailsAvailabilityCardModel(
        firstTitle: "CAT-1",
        secondTitle: "1",
        secondSubTitle: "15000 TOS / seat",
        ontap: () {}),
    BuyTicketDetailsAvailabilityCardModel(
        firstTitle: "CAT-1",
        secondTitle: "1",
        secondSubTitle: "15000 TOS / seat",
        ontap: () {}),
    BuyTicketDetailsAvailabilityCardModel(
        firstTitle: "CAT-1",
        secondTitle: "1",
        secondSubTitle: "15000 TOS / seat",
        ontap: () {}),
    BuyTicketDetailsAvailabilityCardModel(
        firstTitle: "CAT-1",
        secondTitle: "1",
        secondSubTitle: "15000 TOS / seat",
        ontap: () {}),
  ];
  List<WinnerListModel> winnersList = [
    WinnerListModel(
        image: ImageUtils.danceIcon,
        songName: "Goes like fly",
        beat: "Voice",
        date: "02 Feb, 2024",
        ontap: () {}),
    WinnerListModel(
        image: ImageUtils.danceIcon1,
        songName: "Goes like fly",
        beat: "Voice",
        date: "02 Feb, 2024",
        ontap: () {}),
    WinnerListModel(
        image: ImageUtils.danceIcon2,
        songName: "Goes like fly",
        beat: "Voice",
        date: "02 Feb, 2024",
        ontap: () {}),
    WinnerListModel(
        image: ImageUtils.danceIcon3,
        songName: "Goes like fly",
        beat: "Voice",
        date: "02 Feb, 2024",
        ontap: () {}),
  ];
  int selected = -1;
  RxList<RewardAccountListModel> rewardAccountList = [
    RewardAccountListModel(
        image: ImageUtils.paypal,
        title: "PayPal",
        isSubtitle: false,
        isExpanded: false,
        ontap: () {},
        hintText: AppStrings.enter_payPal_Address),
    RewardAccountListModel(
        image: ImageUtils.cripto,
        title: 'Wallet Address',
        isSubtitle: true,
        subtitle: "(USDT, USDC, BUSD)",
        isExpanded: false,
        ontap: () {},
        hintText: AppStrings.enter_Wallet_Address),
    RewardAccountListModel(
        image: ImageUtils.mail,
        title: 'Other',
        isSubtitle: true,
        subtitle: "(USDT, USDC, BUSD)",
        isExpanded: false,
        ontap: () {},
        hintText: AppStrings.enter_email_Address),
  ].obs;
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
  RxInt usd = 0.obs;
  late TextEditingController textController = TextEditingController();
  RxInt tosToken = 0.obs;
  RxDouble originalPrice = 0.0.obs;
  RxDouble minimumPrice = 100.0.obs;
  RxDouble maximumPrice = 5200.0.obs;
  RxString currencySymbol = "".obs;
  RxBool isLimitReachedMaximum = false.obs;
  RxBool isLimitReachedMinimum = false.obs;
  RxBool isLoading = false.obs;
  LoginModel userDetailsModel = LoginModel();
  RxList<Sliders> sliders = <Sliders>[].obs;
  RxList<VotingVideoList> winnerListDance = <VotingVideoList>[].obs;
  RxList<dynamic> winnerListRap = <dynamic>[].obs;
  RewardAccountModel rewardAccountModel = RewardAccountModel();
  RxString rewardAccountId = "".obs;
  RxList<PaymentAccountTypesData> rewardAccountLists =
      <PaymentAccountTypesData>[].obs;
  TextEditingController rewardAccountText = TextEditingController();
  RxBool isPlaying = false.obs;
  RxBool isLoading1 = false.obs;
  TextEditingController referralText = TextEditingController();
  GetSliderModel getSliderModel = GetSliderModel();
  String formatDate(String inputString) {
    // Parse the input string into a DateTime object
    DateTime dateTime = DateTime.parse(inputString);

    // Format the DateTime object
    String formattedDate = DateFormat('dd MMM,yyyy').format(dateTime);

    return formattedDate;
  }

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

  toggleAnimation() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  //getUserDetails
  Future getUserDetails() async {
    isLoading.value = true;
    await getUserDetailsApiCall().then((result) async {
      Get.log(">>>>>>>>>>>>>>>>>>>>>>daogin${result["data"]}");
      if (result["status"] == "Success") {
        userDetailsModel = LoginModel.fromJson(result["data"]);
        await storeToLocalStore(userDetailsModel);
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  //getUserDetails API call
  getUserDetailsApiCall() async {
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
      endpoint: Urls.userDetails,
    );
    return result;
  }

  //getSlider
  Future getSlider() async {
    print("tokensds:${HiveStore().get(Keys.AUTHORIZATIONTOKEN)}");
    isLoading.value = true;
    await getSliderApiCall().then((result) async {
      if (result is GetSliderModel) {
        if (result.status == "success") {
          sliders.value = result.data?.sliders ?? [];
          print("Length:${sliders.length}");
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showFailureSnackBar("Failed", result.message ?? "Login Failed");
        }
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
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      commonPoint: Urls.API,
      method: METHOD.GET,
      endpoint: Urls.getSlider,
    );
    return GetSliderModel.fromJson(result);
  }

  //Authenticate referral code
  Future authenticateReferralCode(String? referralCode) async {
    if (referralCode!.isNotEmpty && referralCode!.length > 5) {
      isLoading1.value = true;
      await authenticateReferralCodeApiCall(referralCode).then((result) async {
        if (result["status"] == "Success") {
          Get.back();
          referralText.text = "";
          HiveStore().put(Keys.OPENREFERRALCODE, "no");
          showSuccessSnackBar("Success",
              result["message"] ?? "Successfully submitted referral code.");
          isLoading1.value = false;
        } else {
          showFailureSnackBar(
              "Failed", result["message"] ?? "Referral code not submitted.");
          isLoading1.value = false;
        }
      });
    } else {
      showFailureSnackBar("Failed", "Please enter a valid referral code.");
    }
  }

  //Login API call
  authenticateReferralCodeApiCall(String? referralCode) async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      commonPoint: Urls.API,
      body: {
        'email': HiveStore().get(Keys.EMAIL),
        'referralCode': referralCode
      },
      method: METHOD.POST,
      endpoint: Urls.authenticateReferral,
    );
    return result;
  }

  //Logout
  Future logout() async {
    isLoading.value = true;
    await logoutApiCall().then((result) async {
      if (result["status"] == "success") {
        Get.offAllNamed(Routes.LOGIN);
        await clearHive();
        showSuccessSnackBar("Success", result["msg"] ?? "Logout Success");
        isLoading.value = false;
      } else {
        showFailureSnackBar("Failed", result["msg"] ?? "Logout Failed");
        isLoading.value = false;
      }
    });
  }

  //Logout API call
  logoutApiCall() async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      body: {
        "fcm_token": HiveStore().get(Keys.FCMTOKEN),
      },
      baseURL: Urls.baseUrl,
      method: METHOD.POST,
      endpoint: Urls.logout,
    );
    return result;
  }

  clearHive() {
    HiveStore().remove(Keys.AGE);
    HiveStore().remove(Keys.DANCE);
    HiveStore().remove(Keys.RAPS);
    HiveStore().remove(Keys.WINNERS);
    HiveStore().remove(Keys.language);
    HiveStore().remove(Keys.NEWUSER);
    HiveStore().remove(Keys.OPENEDITPROFILEPAGE);
    HiveStore().remove(Keys.USERID);
    HiveStore().remove(Keys.NICKNAME);
    HiveStore().remove(Keys.FIRSTNAME);
    HiveStore().remove(Keys.LASTNAME);
    HiveStore().remove(Keys.EMAIL);
    HiveStore().remove(Keys.APPLEFIRSTNAME);
    HiveStore().remove(Keys.STYLE);
    HiveStore().remove(Keys.AGE);
    HiveStore().remove(Keys.COUNTRY);
    HiveStore().remove(Keys.PROFILEIMAGE);
    HiveStore().remove(Keys.MBTI);
    HiveStore().remove(Keys.AUTHORIZATIONTOKEN);
    HiveStore().remove(Keys.WALLETID);
    HiveStore().remove(Keys.FIRSTTIMELOGIN);
  }

  // //Check winner Dance
  // Future checkWinner(String? type) async {
  //   isLoading.value = true;
  //   await checkWinnerApiCall(type).then((result) async {
  //     if (result is WinnerDanceListModel) {
  //       if (result.status == "Success") {
  //         winnerListDance.clear();
  //         winnerListDance.value = result.votingVideoList ?? [];
  //         print("Length:${sliders.length}");
  //         isLoading.value = false;
  //       } else {
  //         isLoading.value = false;
  //         showFailureSnackBar(
  //             "Failed", result.message ?? "Login Failed");
  //       }
  //     }
  //   });
  // }
  //
  // //Check winner API call
  // checkWinnerApiCall(String? type) async {
  //   HeaderModel headerModel = HeaderModel(
  //     token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
  //   );
  //   var result = await CoreService().apiService(
  //     header: headerModel.toHeader(),
  //     ssl: SSL.HTTP,
  //     baseURL: Urls.baseUrl,
  //     body: {"video_type" : type},
  //     method: METHOD.POST,
  //     endpoint: Urls.checkWinnerDance,
  //   );
  //   return WinnerDanceListModel.fromJson(result);
  // }

  //Reward account
  Future rewardAccount() async {
    isLoading.value = true;
    await rewardAccountApiCall().then((result) async {
      if (result["status"] == "success") {
        rewardAccountModel = RewardAccountModel.fromJson(result);
        rewardAccountLists.clear();
        rewardAccountLists.addAll(rewardAccountModel.paymentAccountTypesData
            as Iterable<PaymentAccountTypesData>);
        print("Length:${rewardAccountLists.length}");
        isLoading.value = false;
      } else {
        showFailureSnackBar("Failed", result["message"] ?? "Login Failed");
        isLoading.value = false;
      }
    });
  }

  //Reward account API call
  rewardAccountApiCall() async {
    var result = await CoreService().apiService(
      baseURL: Urls.baseUrl,
      method: METHOD.GET,
      endpoint: Urls.rewardAccount,
    );
    return result;
  }

  //Delete account
  Future deleteAccount() async {
    isLoading.value = true;
    await deleteAccountApiCall().then((result) async {
      Get.log("deletesucesss>>>>>>>${result["status"]}");
      if (result["status"] == "Success") {
        showSuccessSnackBar(
            "Success", result["message"] ?? "Account deleted successfully.");
        isLoading.value = false;
        HiveStore().clear();
        Get.offAllNamed(Routes.LOGIN);
      } else {
        showFailureSnackBar(
            "Failed", result["message"] ?? "Account deletion failed");
        isLoading.value = false;
      }
    });
  }

  //Reward account API call
  deleteAccountApiCall() async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      method: METHOD.GET,
      commonPoint: Urls.APIV2,
      endpoint: Urls.deleteAccount,
    );
    return result;
  }

  //Save Reward account
  Future saveRewardAccount(
      String? paymentAccountId, String? paymentAccountAddress) async {
    isLoading.value = true;
    await saveRewardAccountApiCall(paymentAccountId, paymentAccountAddress)
        .then((result) async {
      if (result["status"] == "Success") {
        Get.toNamed(Routes.REWARDACCOUNTADDEDSUCCESSFULLY);
        showSuccessSnackBar(
            "Success", result["message"] ?? "Account deleted successfully.");
        isLoading.value = false;
      } else {
        showFailureSnackBar(
            "Failed", result["message"] ?? "Account deletion failed");
        isLoading.value = false;
      }
    });
  }

  //Save Reward account API call
  saveRewardAccountApiCall(
      String? paymentAccountId, String? paymentAccountAddress) async {
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      body: {
        "payment_account_address": paymentAccountAddress,
        "payment_type": paymentAccountId,
      },
      method: METHOD.POST,
      endpoint: Urls.userPaymentAccountSave,
    );
    return result;
  }

  enterReferralCodeDialog() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Builder(
          builder: (context) {
            return Container(
              height: ScreenConstant.screenHeightHalfPointFive,
              width: MediaQuery.of(context).size.width - 80,
              padding: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightTwentyThree,
                  horizontal: ScreenConstant.defaultWidthTwenty),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                          onTap: () {
                            Get.back();
                            isLoading1.value = false;
                            referralText.text = "";
                            HiveStore().put(Keys.OPENREFERRALCODE, "no");
                          },
                          child: Icon(
                            Icons.cancel_outlined,
                            color: CustomColor.primaryBlue,
                          ))
                    ],
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightFifteen,
                  ),
                  Text(
                    AppStrings.haveYouBeen,
                    style: TextStyles.homeTabSecondCardSubTitleStyleBold
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightFour,
                  ),
                  Text(
                    AppStrings.enterYourFriends,
                    style: TextStyles.homeTabSecondCardSubTitleStyleBold
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightTwentyThree,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenConstant.defaultWidthTwenty,
                    ),
                    child: DefaultEditText(
                      type: Type.stageName,
                      prefixIcon: Container(),
                      style: TextStyles.textFieldTextStyleSemiBold,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: referralText,
                      hintText: AppStrings.enter_referral.tr,
                    ),
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightFifteen,
                  ),
                  Obx(
                    () => isLoading1.value
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: CustomColor.primaryBlue,
                          ))
                        : UniversalButtonWidget(
                            ontap: () {
                              authenticateReferralCode(referralText.text);
                            },
                            color: CustomColor.primaryBlue,
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenConstant.defaultWidthTwenty,
                            ),
                            leadingIconvisible: true,
                            borderRadius: BorderRadius.circular(20),
                            title: AppStrings.ok.tr,
                            titleTextStyle: TextStyles.textStyleRegular
                                .apply(color: CustomColor.white),
                          ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
