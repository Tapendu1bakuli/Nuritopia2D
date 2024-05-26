import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/edit_profile/controller/edit_profile_controller.dart';
import 'package:nuritopia2d/utils/Store/HiveStore.dart';
import 'package:nuritopia2d/utils/utils.dart';
import '../../../../common/common_text_form_field.dart';
import '../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../home/widgets/common_appbar_action_connect_widget.dart';
import '../controller/validate_user_controller.dart';

class ValidateUserView extends GetView<ValidateUserController> {
  const ValidateUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      appBar: CommonAppbarWidget(
        backgroundColor: CustomColor.primaryScaffoldColor,
        leadingWidth: 0,
        isActionPresent: true,
        titleTextStyle:
        TextStyles.editProfileTitleStyleBold.copyWith(fontSize: 17),
        title: AppStrings.nuritopiaAccountVerification.tr,
        isLeadingPresent: false,
        leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
        leadingWidgetSize: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthTwenty),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: ScreenConstant.defaultWidthThirty,
            ),
            Text(
              AppStrings.enterYourNuritopiaUserId,
              style: TextStyles.editProfileSubtitleTitleStyleSemiBold
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
              textAlign: TextAlign.start,
            ),
            Container(
              height: ScreenConstant.defaultWidthThirty,
            ),
            Row(
              children: [
                Expanded(
                  flex: 12,
                  child: DefaultEditText(
                    isReadOnly: true,
                    type: Type.stageName,
                    prefixIcon: Container(),
                    style: TextStyles.textFieldTextStyleSemiBold,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: controller.verifyUserID,
                    hintText: AppStrings.enterUserId.tr,
                  ),
                ),
                Container(
                  width: ScreenConstant.defaultWidthTen,
                ),
                Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () async {
                        ClipboardData? clipboardContent =
                        await Clipboard.getData(Clipboard.kTextPlain);
                        if (clipboardContent != null) {
                          controller.verifyUserID.text =
                              clipboardContent.text ?? "";
                        }
                      },
                      child: Container(
                        height: ScreenConstant.defaultWidthSixty,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: CustomColor.fillOffWhiteColor),
                        child: Icon(
                          Icons.paste_rounded,
                          color: CustomColor.primaryBlue,
                        ),
                      ),
                    ))
              ],
            ),
            Container(
              height: ScreenConstant.defaultWidthSixty,
            ),
            Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                  color: CustomColor.primaryScaffoldColor,
                  border: Border(
                      top: BorderSide(
                          width: 3,
                          color: CustomColor.primaryBlue.withOpacity(0.1)))),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    height: ScreenConstant.defaultHeightFifteen,
                  ),
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : UniversalButtonWidget(
                    ontap: () {
                      if (controller.verifyUserID.text.trim() == "") {
                        Fluttertoast.showToast(
                            msg: "Please enter user id");
                        return;
                      }
                      controller.userVerificationWithNuritopia();
                    },
                    color: CustomColor.primaryBlue,
                    margin: EdgeInsets.symmetric(
                      vertical: ScreenConstant.defaultHeightFifteen,
                      // horizontal: ScreenConstant.defaultWidthTwenty,
                    ),
                    leadingIconvisible: true,
                    borderRadius: BorderRadius.circular(20),
                    title: AppStrings.send.tr,
                    titleTextStyle: TextStyles.textStyleRegular
                        .apply(color: CustomColor.white),
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightSixty,
                  ),
                  Center(
                      child: Text(
                        AppStrings.notRegisteredYet,
                        style: TextStyles.drawerSubTitleBold
                            .copyWith(color: CustomColor.alertDialogButton),
                      )),
                  Container(
                    height: ScreenConstant.defaultHeightFifteen,
                  ),
                  Center(
                      child: InkWell(
                        onTap: () {
                          launchUrls(
                              HiveStore().getString(Keys.DEVICETYPE) == "1"
                                  ? Uri.parse(
                                  "https://play.google.com/store/apps/details?id=com.nuriworks.nuritopia&pli=1")
                                  : Uri.parse(
                                  "https://apps.apple.com/us/app/nuritopia/id6450440828"));
                        },
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: CustomColor.primaryBlue),
                            children: [
                              TextSpan(
                                  text: AppStrings.clickHereTo,
                                  style: TextStyles.drawerSubTitleBold
                                      .copyWith(
                                      color: CustomColor.primaryBlue)),
                              TextSpan(
                                text: AppStrings.register,
                                style: TextStyles.drawerSubTitleBold.copyWith(
                                    color: CustomColor.primaryBlue,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: AppStrings.toNuritopia,
                                  style: TextStyles.drawerSubTitleBold
                                      .copyWith(
                                      color: CustomColor.primaryBlue)),
                            ],
                          ),
                        ),
                      )),
                  Container(
                    height: ScreenConstant.screenHeightFourth,
                  ),
                  Center(
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            AppStrings.cancel,
                            style: TextStyles.drawerSubTitleBold
                                .copyWith(color: CustomColor.alertDialogButton),
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
