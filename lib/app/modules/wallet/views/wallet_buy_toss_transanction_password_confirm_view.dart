import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/common_text_form_field.dart';
import '../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../home/controller/home_controller.dart';
import '../../home/widgets/dialog/vote_successfully_submitted.dart';

class WalletBuyTossTransactionPasswordConfirmView extends GetView<HomeController> {
  const WalletBuyTossTransactionPasswordConfirmView({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
        isActionPresent: true,
        actionWidgets: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.close,
                color: Colors.black, size: ScreenConstant.smallIconSize),
          ),
          Container(
            width: ScreenConstant.defaultWidthTwenty,
          )
        ],
        titleTextStyle: TextStyles.appbarTitleStyleBold,
        title: AppStrings.transaction.tr.toUpperCase(),
        isLeadingPresent: false,
        leadingOnTap: () {
          Get.back();
        },
        centerTitle: true,
        leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
        leadingWidgetSize: ScreenConstant.smallIconSize,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: ScreenConstant.screenHeightSixth,
            decoration: BoxDecoration(color: CustomColor.fillOffWhiteColor),
            child: Center(
              child: Image.asset(ImageUtils.validateTransaction,
                  width: ScreenConstant.screenWidthFifth),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenConstant.defaultWidthThirty,
                  vertical: ScreenConstant.defaultHeightTwentyThree),
          child: Text(
            AppStrings.validateTransaction.tr,
            style: TextStyles.mediumLargeRegular,
          ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenConstant.defaultWidthThirty,
                ),
            child:   Text(AppStrings.enterPass.tr, style: TextStyles.textFieldTitleRegular),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightFifteen, horizontal: ScreenConstant.defaultWidthThirty,),
            child: DefaultEditText(
              onSaved: (input){
              },
              controller: controller.confirmPasswordController,
              onSubmit: controller.onSubmit.value = false,
              type: Type.textFieldWithSuffix,
              prefixIcon: Container(),
              style: TextStyles.textFieldTextStyleSemiBold,
              keyboardType: TextInputType.text,
              obscureText: true,
              hintText: AppStrings.enter_Password.tr,
            ),
          ),
          UniversalButtonWidget(
            ontap: (){
              showAlertDialogForVoteSubmittedSuccessfully(1,"Lily");
            },
            color: CustomColor.primaryBlue,
            margin: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightFifteen, horizontal: ScreenConstant.defaultWidthThirty,),
            leadingIconvisible: true,
            title: AppStrings.send.tr,
            titleTextStyle: TextStyles.textStyleRegular
                .apply(color: CustomColor.white),
          )
        ],
      ),
    );
  }
}
