import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_text_form_field.dart';
import '../../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../controller/home_controller.dart';

class ChangePasswordView extends GetView<HomeController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryScaffoldColor,
      appBar:CommonAppbarWidget(
        titleTextStyle: TextStyles.appbarTitleStyleBold,
        title: AppStrings.change_Password.tr,
        isLeadingPresent: true,
        leadingOnTap: (){Get.back();},
        centerTitle: true,
        leadingWidgetIcon:  Icons.arrow_back_ios_new_rounded,
        leadingWidgetSize: ScreenConstant.smallIconSize,
      ),
      body: ListView(
        children: [
          Container(
            height: ScreenConstant.screenHeightMinimum,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightFifteen, horizontal: ScreenConstant.defaultWidthThirty,),
            child: DefaultEditText(
              onSaved: (input){
              },
              onSubmit: controller.onSubmit.value = false,
              type: Type.textFieldWithOutSuffix,
              prefixIcon: Container(),
              style: TextStyles.textFieldTextStyleSemiBold,
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: controller.currentPasswordController,
              hintText: AppStrings.currentPassword.tr,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightFifteen, horizontal: ScreenConstant.defaultWidthThirty,),
            child: DefaultEditText(
              onSaved: (input){
              },
              onSubmit: controller.onSubmit.value = false,
              type: Type.textFieldWithOutSuffix,
              prefixIcon: Container(),
              style: TextStyles.textFieldTextStyleSemiBold,
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: controller.newPasswordController,
              hintText: AppStrings.enter_new_Password.tr,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightFifteen, horizontal: ScreenConstant.defaultWidthThirty,),
            child: DefaultEditText(
              onSaved: (input){
              },
              controller: controller.confirmPasswordController,
             onSubmit: controller.onSubmit.value = false,
              type: Type.textFieldWithOutSuffix,
              prefixIcon: Container(),
              style: TextStyles.textFieldTextStyleSemiBold,
              keyboardType: TextInputType.text,
              obscureText: true,
              hintText: AppStrings.confirm_Password.tr,
            ),
          ),
          UniversalButtonWidget(
            color: CustomColor.primaryBlue,
            margin: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightFifteen, horizontal: ScreenConstant.defaultWidthThirty,),
            leadingIconvisible: true,
            title: AppStrings.update.tr.toUpperCase(),
            titleTextStyle: TextStyles.textStyleRegular
                .apply(color: CustomColor.white),
          )
        ],
      ),
    );
  }
}
