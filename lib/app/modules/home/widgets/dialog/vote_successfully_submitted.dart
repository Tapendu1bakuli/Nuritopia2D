import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';

showAlertDialogForVoteSubmittedSuccessfully(int? noOfVote,String name) {
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
            height: ScreenConstant.screenHeightTowAndHalf,
            width: MediaQuery.of(context).size.width-50,
            padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightForty),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageUtils.success,
                  height: ScreenConstant.defaultHeightFifty,
                  width: ScreenConstant.defaultWidthFifty,
                ),
                Container(height: ScreenConstant.defaultHeightFifteen,),
                Text("$noOfVote ${AppStrings.vote}",style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 18,fontWeight: FontWeight.w500),),
                Container(height: ScreenConstant.defaultHeightFifteen,),
                Text("${AppStrings.successfullyCasted.tr}$name",style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 16,fontWeight: FontWeight.w400),),
                Container(height: ScreenConstant.defaultHeightTwentyThree,),
                UniversalButtonWidget(
                  ontap: (){
                    Get.back();
                  },
                  color: CustomColor.alertDialogButton,
                  margin: EdgeInsets.symmetric(
                    vertical: ScreenConstant.defaultHeightFifteen,
                    horizontal: ScreenConstant.defaultWidthTwenty,
                  ),
                  leadingIconvisible: true,
                  borderRadius: BorderRadius.circular(20),
                  title: AppStrings.cancel.tr,
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
