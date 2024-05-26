import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_utils/app_strings.dart';

welcomeDialog() {
  Get.dialog(
    AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Builder(
        builder: (context) {
          return Container(
            height: ScreenConstant.screenHeightFourth,
            width: MediaQuery.of(context).size.width - 80,
            padding: EdgeInsets.symmetric(
                vertical: ScreenConstant.defaultHeightTwentyThree,
                horizontal: ScreenConstant.defaultWidthTwenty),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.welcomeToNuristar.tr,
                  style: TextStyles.homeTabSecondCardSubTitleStyleBold
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: ScreenConstant.defaultHeightFour,
                ),
                Expanded(
                  child: Text(
                    AppStrings.youHaveBeenGifted,
                    style: TextStyles.homeTabSecondCardSubTitleStyleBold
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: ScreenConstant.defaultHeightTwentyThree,
                ),
                UniversalButtonWidget(
                  ontap: () {
                    Get.back();
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
                )
              ],
            ),
          );
        },
      ),
    ),
  );
}
