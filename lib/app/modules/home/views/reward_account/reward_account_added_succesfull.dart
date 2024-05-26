import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../../../utils/utils.dart';
import '../../widgets/common_appbar_action_connect_widget.dart';
class RewardAccountAddedSuccessfully extends StatelessWidget {
  const RewardAccountAddedSuccessfully({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.fillOffWhiteColor,
      appBar: CommonAppbarWidget(
        backgroundColor: CustomColor.fillOffWhiteColor,
        actionWidgets: [
          CommonAppBarConnectWidget()
        ],
        isActionPresent: true,
        titleSpacing: 0,
        titleTextStyle: TextStyles.editProfileTitleStyleBold,
        title: AppStrings.rewardAccounts.tr.toUpperCase(),
        isLeadingPresent: false,
        leadingOnTap: () {
          Get.back();
        },
        centerTitle: true,
        leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
        leadingWidgetSize: ScreenConstant.smallIconSize,
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageUtils.containerRoundedBack)),
                  shape: BoxShape.circle),
              height: ScreenConstant.screenHeightFourth,
              child: Image.asset(
                ImageUtils.splashNuritopiaLogo,
                scale: 2,
              ),
            )),
        Container(
          height: ScreenConstant.screenHeightMinimum,
        ),
        Text(
          AppStrings.successfullyAdded,
          style: TextStyles.homeTabStyleSemiBold
              .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Container(
          height: ScreenConstant.defaultHeightFifteen,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConstant.screenWidthSixth),
          child: Text(
            AppStrings.payment_Account_Save,
            style: TextStyles.homeTabStyleSemiBold
                .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: ScreenConstant.defaultHeightTwentyThree,
        ),
        UniversalButtonWidget(
          ontap: (){
            Get.back();
          },
          color: CustomColor.ultraLightBlue,
          margin: EdgeInsets.symmetric(
            vertical: ScreenConstant.defaultHeightTen,
            horizontal: ScreenConstant.screenWidthThird,
          ),
          leadingIconvisible: true,
          title: AppStrings.close.tr,
          titleTextStyle: TextStyles.textStyleRegular
              .apply(color: CustomColor.primaryBlack),
        ),
      ],
    )
    );
  }
}
