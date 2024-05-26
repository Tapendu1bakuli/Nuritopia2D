import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../controller/home_controller.dart';

showAlertDialogForDeleteAccount() {
  HomeController homeController = Get.find();
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
            height: ScreenConstant.screenHeightHalfPointFive,
            width: MediaQuery.of(context).size.width-50,
            padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightTwentyThree,horizontal: ScreenConstant.defaultWidthThirty),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageUtils.deleteIcon,color: Colors.red,
                  height: ScreenConstant.defaultHeightFifty,
                  width: ScreenConstant.defaultWidthFifty,
                ),
                Container(height: ScreenConstant.defaultHeightFifteen,),
                Text(AppStrings.deleteAccount,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 20,fontWeight: FontWeight.w500),),
                Container(height: ScreenConstant.defaultHeightFifteen,),
                Text(AppStrings.deleteAccountMessage,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 18,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                Container(height: ScreenConstant.defaultHeightFifteen,),
                Obx(()=> homeController.isLoading.value?const Center(child: CircularProgressIndicator(color: CustomColor.primaryBlue,),):Row(
                    children: [
                      Expanded(flex:5,
                          child:  UniversalButtonWidget(
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
                      )),
                      Expanded(flex:5,
                          child:  UniversalButtonWidget(
                            ontap: (){
                              homeController.deleteAccount();
                            },
                            color: CustomColor.primaryBlue,
                            margin: EdgeInsets.symmetric(
                              vertical: ScreenConstant.defaultHeightFifteen,
                              horizontal: ScreenConstant.defaultWidthTwenty,
                            ),
                            leadingIconvisible: true,
                            borderRadius: BorderRadius.circular(20),
                            title: AppStrings.confirm.tr,
                            titleTextStyle: TextStyles.textStyleRegular
                                .apply(color: CustomColor.primaryBlack),
                          ))
                    ],
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