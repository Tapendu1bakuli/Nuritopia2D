import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/common_text_form_field.dart';
import '../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/Store/HiveStore.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../routes/routes.dart';
import '../../home/widgets/carousal_image_widget.dart';
import '../../home/widgets/common_appbar_action_connect_widget.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
   EditProfileView({Key? key}) : super(key: key);
  EditProfileController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: CustomColor.primaryScaffoldColor,
          appBar: CommonAppbarWidget(
            actionWidgets: [CommonAppBarConnectWidget()],
            isActionPresent: true,
            titleTextStyle:
                TextStyles.editProfileTitleStyleBold.copyWith(fontSize: 27),
            title: HiveStore().get(Keys.NEWUSER) == "0"
                ? AppStrings.profile.tr
                : AppStrings.edit_Profile.tr,
            leadingOnTap: () {
              HiveStore().get(Keys.NEWUSER) == "0"? Get.back(): Get.offAndToNamed(Routes.HOME);
              HiveStore().setString(Keys.OPENEDITPROFILEPAGE, "false");
            },
            isLeadingPresent: true,
            leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
            leadingWidgetSize: ScreenConstant.smallIconSize,
            centerTitle: true,
          ),
          body: HiveStore().get(Keys.NEWUSER) == "0"?
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
                          // Center(
                          //   child: Container(
                          //     height: ScreenConstant.screenHeightTwelve,
                          //     width: ScreenConstant.screenWidthFifth,
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(15),
                          //         border: Border.all(color: CustomColor.fillOffWhiteColor,width: 3),
                          //         color: CustomColor.white),
                          //     child: CachedNetworkImage(
                          //       height: ScreenConstant.screenHeightTwelve,
                          //       width: ScreenConstant.screenWidthSixth,
                          //       fit: BoxFit.fill,
                          //       imageUrl:
                          //       HiveStore().get(Keys.PROFILEIMAGE)??AppStrings.loginBackgroundImageUrl,
                          //       placeholder: (context, url) => Image.asset(
                          //         ImageUtils.loadingImage,
                          //         fit: BoxFit.cover,
                          //         width: double.infinity,
                          //       ),
                          //       errorWidget: (context, url, error) =>
                          //           Icon(Icons.error_outline),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 0,),
                          Container(
                            height: 0,
                          ),
                          Container(
                            height: ScreenConstant.screenHeightHalf,
                            // width: ScreenConstant.screenWidthHalf *4,
                            decoration: BoxDecoration(),
                            child: Stack(children: [
                              CarouselSlider(
                                items: controller.imagelist
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
                                        controller.imagelist.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            width: ScreenConstant.defaultWidthTen,
                                            height:
                                                ScreenConstant.defaultHeightFour,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: controller
                                                            .currentIndex.value ==
                                                        index
                                                    ? CustomColor.primaryBlue
                                                    : CustomColor.chatPaymentBackground),
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
                                    await Clipboard.setData(
                                        ClipboardData(text: HiveStore().get(Keys.NICKNAME)));
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
                                  HiveStore().get(Keys.NICKNAME),
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
                                  HiveStore().get(Keys.MBTI),
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
                                  HiveStore().get(Keys.COUNTRY),
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
                                  HiveStore().get(Keys.STYLE),
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
                                  HiveStore().get(Keys.AGE),
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
                                color: CustomColor.lightPink.withOpacity(0.3)),
                            child: Center(
                              child: Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppStrings.youCanUpdateYourAccount,
                                      style: TextStyles.homeTabStyleSemiBold
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                        text: AppStrings.clickHere,
                                        style: TextStyles.homeTabStyleSemiBold
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: CustomColor.primaryBlue,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    CustomColor.primaryBlue)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Center(
                          child: Text(
                            HiveStore().get(Keys.EMAIL),
                        style: TextStyles.homeBottomSubtitleTitleStyleSemiBold,
                      )),
                      Container(
                        height: ScreenConstant.screenHeightMinimum,
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: CachedNetworkImage(
                            height: ScreenConstant.defaultHeightSeventySix,
                            width: ScreenConstant.defaultWidthEighty,
                            fit: BoxFit.fill,
                            imageUrl:
                            HiveStore().get(Keys.PROFILEIMAGE)??AppStrings.loginBackgroundImageUrl,
                            placeholder: (context, url) => Image.asset(
                              ImageUtils.loadingImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error_outline),
                          ),
                        ),
                      ),
                      Container(
                        height: ScreenConstant.screenHeightMinimum,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenConstant.defaultWidthFifty),
                        child: Center(
                            child: Text(
                          AppStrings.updateProfile,
                          style: TextStyles.editProfileSubtitleTitleStyleSemiBold
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Container(
                        height: ScreenConstant.screenHeightMinimum,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                verificationDialog();
                              },
                              child: Text(
                                AppStrings.clickHere.tr,
                                style: TextStyles
                                    .editProfileUnderlinedTitleStyleSemiBold,
                              )),
                          Text(
                            AppStrings.toInstall.tr,
                            style:
                                TextStyles.editProfileSubtitleTitleStyleSemiBold,
                          )
                        ],
                      ),
                      Container(
                        height: ScreenConstant.screenHeightMinimum,
                      ),
                      Image.asset(ImageUtils.profile_icon,
                          height: ScreenConstant.screenHeightThird,
                          fit: BoxFit.contain),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenConstant.screenWidthFourth),
                        child: Center(
                            child: Text(
                          AppStrings.installNuritopia,
                          style: TextStyles.editProfileSubtitleTitleStyleSemiBold
                              .copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Container(
                        height: ScreenConstant.defaultHeightTen,
                      ),
                      //Container(height: ScreenConstant.screenHeightTenth,),
                    ],
                  ),
                ),
        ),
    );
  }
}
