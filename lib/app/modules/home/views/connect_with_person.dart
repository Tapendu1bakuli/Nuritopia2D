import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/voting/controller/voting_controller.dart';
import '../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../common/widgets/Loader.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../controller/home_controller.dart';
import '../widgets/carousal_image_widget.dart';
import '../widgets/common_appbar_action_connect_widget.dart';

class ConnectWithPersonScreen extends GetView<VotingController> {
  ConnectWithPersonScreen({Key? key}) : super(key: key);
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print("Data:$data");
    return GetX<VotingController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 200), () async {
        await controller.getPerformerDetails(data[0], data[1]);
      });
    }, builder: (_) {
      return Scaffold(
        backgroundColor: CustomColor.fillOffWhiteColor,
        appBar: CommonAppbarWidget(
          actionWidgets: [CommonAppBarConnectWidget()],
          isActionPresent: true,
          backgroundColor: CustomColor.white,
          titleTextStyle: TextStyles.appbarSmallTitleStyleBold,
          title: "BEAT : ${data[2]}",
          leadingOnTap: () {
            Get.back();
          },
          isLeadingPresent: true,
          leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
          leadingWidgetSize: ScreenConstant.smallIconSize,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: ScreenConstant.defaultHeightTen,
                ),
                Container(
                  decoration: BoxDecoration(color: CustomColor.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenConstant.defaultHeightTen,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenConstant.defaultWidthTwenty),
                          child: Text(
                            controller.performerDetailsModel.data?.firstName ??
                                "",
                            style: TextStyles.homeTabStyleSemiBold.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenConstant.defaultHeightTen),
                          child: Text(
                            AppStrings.connectWithMe.tr,
                            style: TextStyles.homeTabStyleSemiBold.copyWith(
                                color: CustomColor.primaryBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Container(
                        height: ScreenConstant.screenHeightHalf,
                        decoration: BoxDecoration(),
                        child: Stack(children: [
                          CarouselSlider(
                            items: controller.performerDetailsModel?.data
                                        ?.profileImage !=
                                    null || controller.performerDetailsModel?.data
                                ?.profileImage != []
                                ? controller
                                    .performerDetailsModel?.data?.profileImage
                                    ?.map((item) => CarousalImageWidget(
                                          // onTap: item.ontap,
                                          // title: item.title,
                                          image: item,
                                          // subTitleLarge: item.subtitleLarge,
                                          // subTitleMid: item.subtitleMid,
                                        ))
                                    .toList()
                                : []
                                    .map((item) => CarousalImageWidget(
                                          // onTap: item.ontap,
                                          // title: item.title,
                                          image: item,
                                          // subTitleLarge: item.subtitleLarge,
                                          // subTitleMid: item.subtitleMid,
                                        ))
                                    .toList(),
                            carouselController:
                                controller.homeCarousalController,
                            options: CarouselOptions(
                              height: Get.height,
                              onPageChanged: (int index,
                                  CarouselPageChangedReason reason) {
                                controller.currentIndex.value = index;
                              },
                              autoPlay: false,
                              enlargeCenterPage: false,
                              viewportFraction: 1.5,
                            ),
                          ),
                          Obx(() => Positioned(
                                bottom: ScreenConstant.screenHeightMinimum,
                                right: ScreenConstant.screenWidthFifth,
                                left: ScreenConstant.screenWidthFifth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    controller.performerDetailsModel?.data
                                            ?.profileImage?.length ??
                                        1,
                                    (index) => Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        width: ScreenConstant.defaultWidthTen,
                                        height:
                                            ScreenConstant.defaultHeightFour,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                controller.currentIndex.value ==
                                                        index
                                                    ? CustomColor.white
                                                    : CustomColor.primaryBlue),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ]),
                      ),
                      Container(
                        height: ScreenConstant.defaultHeightTen,
                      ),
                      // Divider(color: CustomColor.secondaryBlue,thickness: 2,),
                      // Container(height: ScreenConstant.defaultHeightThirty,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenConstant.defaultWidthTwenty,
                            vertical: ScreenConstant.defaultHeightTen),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.nickname.tr,
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                print("Copy");
                                await Clipboard.setData(ClipboardData(
                                    text: controller.performerDetailsModel.data
                                            ?.nickName ??
                                        ""));
                              },
                              child: Icon(
                                Icons.copy,
                                size: ScreenConstant.smallIconSize,
                              ),
                            ),
                            Container(
                              width: ScreenConstant.defaultWidthTen,
                            ),
                            Text(
                              controller.performerDetailsModel.data?.nickName ??
                                  "",
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.defaultWidthTwenty,
                        ),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.mbti.tr,
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              controller.performerDetailsModel.data?.mBTI ?? "",
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenConstant.defaultWidthTwenty,
                            vertical: ScreenConstant.defaultHeightTen),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.country.tr,
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              controller.performerDetailsModel.data?.country ??
                                  "",
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenConstant.defaultWidthTwenty),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.style.tr,
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              controller.performerDetailsModel.data?.style ??
                                  "",
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenConstant.defaultWidthTwenty,
                            vertical: ScreenConstant.defaultHeightTen),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.age.tr,
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              controller.performerDetailsModel.data?.age
                                      ?.split(".")
                                      .first ??
                                  "",
                              style: TextStyles.homeTabStyleSemiBold.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: ScreenConstant.spacingAllXL,
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenConstant.screenWidthEleven),
                        width: Get.width,
                        height: ScreenConstant.screenHeightThirteen,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColor.lightPink),
                        child: Center(
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.copytheNickname,
                                  style: TextStyles.homeTabStyleSemiBold
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: AppStrings.friendRequest,
                                  style: TextStyles.homeTabStyleSemiBold
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: CustomColor.primaryBlue),
                                ),
                                TextSpan(
                                  text: AppStrings.inTheMetaVerse,
                                  style: TextStyles.homeTabStyleSemiBold
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Visibility(
              visible: controller.isLoading.value,
              child: Loader(
                text: "",
              ),
            )
          ],
        ),
      );
    });
  }
}
