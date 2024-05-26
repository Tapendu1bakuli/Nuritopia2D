import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../home/widgets/common_appbar_action_connect_widget.dart';

class DoNotHaveEnoughTokenView extends StatelessWidget {
  const DoNotHaveEnoughTokenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      appBar: CommonAppbarWidget(
        actionWidgets: [CommonAppBarConnectWidget()],
        isActionPresent: true,
        backgroundColor: CustomColor.white,
        titleTextStyle: TextStyles.editProfileTitleStyleBold,
        title: AppStrings.transaction.tr.toUpperCase(),
        leadingOnTap: () {
          Get.back();
        },
        centerTitle: true,
        isLeadingPresent: true,
        leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
        leadingWidgetSize: ScreenConstant.smallIconSize,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightTwentyThree),
            height: ScreenConstant.screenHeightEighth,
            decoration: BoxDecoration(color: CustomColor.fillOffWhiteColor),
            child: Image.asset(ImageUtils.deleteIcon),
          ),
          Container(height: ScreenConstant.defaultHeightFifteen,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.screenWidthTenth),
            child: Text(AppStrings.notEnoughTokens.tr,style: TextStyles.textStyleRegular,textAlign: TextAlign.center,),
          ),
          Container(height: ScreenConstant.defaultHeightSeventySix,),
          UniversalButtonWidget(
            margin: EdgeInsets.symmetric(horizontal: ScreenConstant.screenWidthTenth),
            ontap: (){
             Get.back();
            },
            title:AppStrings.buyToken.tr,
            titleTextStyle: TextStyles.universalButtonWidgetBlackText.copyWith(color: CustomColor.white),
            color: CustomColor.primaryBlue,
            leadingIconvisible: true,
          ),
        ],
      ),
    );
  }
}
