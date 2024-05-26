import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/Loader.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/Store/HiveStore.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../routes/routes.dart';
import '../../home/controller/home_controller.dart';
import '../../home/widgets/home_card_widgets.dart';
import '../controller/wallet_controller.dart';
class WalletBalanceView extends GetView<WalletController> {
  const WalletBalanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<WalletController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 200), () async {
        await controller.getWalletDetails();
      });
    }, builder: (_) {
    return Scaffold(
    backgroundColor: CustomColor.fillOffWhiteColor,
    body: Stack(
      children: [
        Column(
        children: [
        HomeCardWidget(
          hideSubTitle:true,
        height: ScreenConstant.screenHeightFourth,
        borderRadiusGeometry: BorderRadius.circular(0),
        margin: EdgeInsets.zero,
        isForWallet: true,
        padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthThirty),
        onTap: () {
        },
        title: AppStrings.accountBalance.tr,
        //subTitle: HiveStore().get(Keys.WALLETID),
        isTextAtRight: false,
        backgroundImage: ImageUtils.walletBalanceTopCard,
        titleTextStyle: TextStyles.drawerSubTitleBold,
        subTitleTextStyle:
        TextStyles.walletSubTitleWhiteRegular,
        walletText: controller.balance.value.toString(),
        walletTextStyle: TextStyles.redHeartTextStyleStyleBold,
        ),
        Container(height: ScreenConstant.defaultHeightFifteen,),
        HomeCardWidget(
        height: ScreenConstant.screenHeightFourth,
        onTap: () {
        print("OnTap");
        modalBottomSheetMenu(context);
        },
        hideSubTitle: true,
        isForWallet: true,
        title: AppStrings.topUpWallet.tr,
        isTextAtRight: false,
        walletText: AppStrings.purchaseRedHeartToken,
        walletTextStyle: TextStyles.drawerSubTitleBold,
        backgroundImage: ImageUtils.walletTopUpImage,
        boxFit: BoxFit.fill,
        titleTextStyle: TextStyles.homeTabCardTitleStyleBold,
        ),
        Container(height: ScreenConstant.defaultHeightFifteen,),
        HomeCardWidget(
        onTap: (){
        modalBottomSheetMenuForChoosingActivity(context);
        //Get.toNamed(Routes.INVITEFRIEND);
        },
        height: ScreenConstant.screenHeightFourth,
        title: AppStrings.getAReward.tr,
        subTitle: AppStrings.earnFreeToken.tr,
        isTextAtRight: false,
        backgroundImage: ImageUtils.walletBalanceBottomCard,
        titleTextStyle: TextStyles.walletBalanceTopUpCardTopTextStyleStyleBold,
        subTitleTextStyle: TextStyles.homeTabCardSubTitleStyleBold,
        ),
        ],
        ),
        Visibility(
          child: Loader(
            text: "",
          ),
          visible: controller.isLoading.value,
        )
      ],
    ),
    );
    });
  }
  Future modalBottomSheetMenu(BuildContext context) async {
    await showModalBottomSheet(
        backgroundColor: CustomColor.fillOffWhiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (builder) {
          return Obx(()=>controller.casual.value?Container(
              height: ScreenConstant.screenHeightThird,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenConstant.defaultHeightTwentyThree,
                      ),
                  Text(AppStrings.purchaseToken.tr,style: TextStyles.drawerSubTitleBold.copyWith(color: CustomColor.primaryBlack),),
                      Container(
                        height: ScreenConstant.defaultHeightTen,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: CustomColor.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      splashRadius: 1,
                                      onPressed: (){
                                        controller.negotiationPriceSetting(
                                            controller.minimumPrice.value,
                                            controller.originalPrice.value,
                                            controller.maximumPrice.value,
                                            false);
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        size: 30,
                                      )),
                                ],
                              ),
                              DropdownButton(
                                iconSize: 0.0,
                                underline: SizedBox.shrink(),
                                alignment: Alignment.center,
                                style: TextStyles.textStyleRegular.apply(
                                    color: Colors.black, fontSizeFactor: 1.7),
                                hint:Text("${controller.originalPrice}",style: TextStyles.drawerSubTitleBold.copyWith(color: CustomColor.primaryBlack),),
                                items: <double>[
                                  1000.00,
                                  2000.00,
                                  3000.00,
                                  5000.00,
                                ].map(
                                      (val) {
                                    return DropdownMenuItem<double>(
                                      value: val,
                                      child: Text(
                                        "$val",
                                        style: TextStyles.drawerSubTitleBold.copyWith(color: CustomColor.primaryBlack),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (double? val) {
                                  controller.originalPrice.value =
                                      val!;
                                 // controller.usd.value = int.parse(val);
                                      // (int.parse(val.toString().replaceAll(" TOS", "")) /
                                      //     controller.tosToken.value)
                                      //     .ceil();
                                },
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      splashRadius: 1,
                                      onPressed: (){
                                        controller.negotiationPriceSetting(
                                            controller.minimumPrice.value,
                                            controller.originalPrice.value,
                                            controller.maximumPrice.value,
                                            true);
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        size: 30,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          redHeartCurrency("1",ImageUtils.whiteHeartImage,TextStyles.drawerSubTitleBold.copyWith(color: CustomColor.primaryBlack),),
                          Container(
                            width: ScreenConstant.defaultWidthTen,
                          ),
                          Text("= 1 USD")
                        ],
                      ),
                      UniversalButtonWidget(
                        ontap: (){
Get.toNamed(Routes.WALLETBUYTOSSTRANSACTIONPASSWORDCONFIRMVIEW);

                        },
                        color: CustomColor.primaryBlue,
                        margin: EdgeInsets.symmetric(
                          vertical: ScreenConstant.defaultHeightFifteen,
                          horizontal: ScreenConstant.defaultWidthTwenty,
                        ),
                        leadingIconvisible: true,
                        title: AppStrings.buy.tr,
                        titleTextStyle: TextStyles.textStyleRegular
                            .apply(color: CustomColor.white),
                      )
                    ],
                  ),
                ),
              ),
            ):Offstage(),
          );
        });
    // return choosedImage;
  }
  Future modalBottomSheetMenuForChoosingActivity(BuildContext context) async {
    await showModalBottomSheet(
        backgroundColor: CustomColor.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (builder) {
          return Obx(()=>controller.casual.value?Container(
            height: ScreenConstant.screenHeightThird,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenConstant.defaultHeightTwentyThree,
                    ),
                    Text(AppStrings.chooseAnActivity.tr,style: TextStyles.drawerSubTitleBold.copyWith(color: CustomColor.primaryBlack),),
                    Container(
                      height: ScreenConstant.defaultHeightTwentyThree,
                    ),
                    UniversalButtonWidget(
                      ontap: (){
                        controller.isReferral.value = true;
                        controller.isChallenges.value = false;
                       HiveStore().get(Keys.NEWUSER) == "0"?Get.toNamed(Routes.INVITEFRIEND):verificationDialog();
                      },
                      color: controller.isReferral.value?CustomColor.primaryBlue:CustomColor.fillOffWhiteColor,
                      borderColor: CustomColor.primaryBlue,
                      margin: EdgeInsets.symmetric(
                        vertical: ScreenConstant.defaultHeightFifteen,
                        horizontal: ScreenConstant.defaultWidthTwenty,
                      ),
                      leadingIconvisible: true,
                      title: AppStrings.referrals.tr,
                      titleTextStyle: controller.isReferral.value?TextStyles.textStyleRegular
                          .apply(color: CustomColor.white):TextStyles.textStyleRegular
                          .apply(color: CustomColor.primaryBlack),
                    ),
                    UniversalButtonWidget(
                      ontap: (){
                        controller.isReferral.value = false;
                        controller.isChallenges.value = true;
                        launchUrls(Uri.parse(AppStrings.nuritopiaWebLink));
                      },
                      color: controller.isChallenges.value?CustomColor.primaryBlue:CustomColor.fillOffWhiteColor,
                      borderColor: CustomColor.primaryBlue,
                      margin: EdgeInsets.symmetric(
                        vertical: ScreenConstant.defaultHeightFifteen,
                        horizontal: ScreenConstant.defaultWidthTwenty,
                      ),
                      leadingIconvisible: true,
                      title: AppStrings.metaverseAppbarAction.tr,
                      titleTextStyle: controller.isChallenges.value?TextStyles.textStyleRegular
                          .apply(color: CustomColor.white):TextStyles.textStyleRegular
                          .apply(color: CustomColor.primaryBlack),
                    )
                  ],
                ),
              ),
            ),
          ):Offstage(),
          );
        });
    // return choosedImage;
  }

}
