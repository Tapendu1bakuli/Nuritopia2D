import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../routes/routes.dart';

class SuccessfullySubmittedVotedScreen extends StatelessWidget {
  const SuccessfullySubmittedVotedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: CustomColor.fillOffWhiteColor,
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
                AppStrings.successfullySubmitted,
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
                  AppStrings.doNotForget,
                  style: TextStyles.homeTabStyleSemiBold
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: ScreenConstant.defaultHeightTwentyThree,
              ),
              InkWell(
                onTap: () {
                  launchUrls(Uri.parse(AppStrings.nuritopiaWebLink));
                  print("URL launcher");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenConstant.screenWidthFourteen,
                      vertical: ScreenConstant.defaultHeightTwentyThree),
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenConstant.screenWidthTenth),
                  height: ScreenConstant.screenHeightEighth,
                  decoration: BoxDecoration(
                      color: CustomColor.primaryBlue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenConstant.defaultWidthTen,
                              vertical: ScreenConstant.defaultHeightFifteen),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CustomColor.white),
                          child: Image.asset(
                            ImageUtils.splashNuritopiaLogo,
                          ),
                        ),
                      ),
                      Container(
                        width: ScreenConstant.defaultWidthTen,
                      ),
                      Expanded(
                        flex: 8,
                        child: Text(
                          AppStrings.nuritopiaWebLink,
                          style: TextStyles.textStyleSemiBold
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: ScreenConstant.defaultHeightFifteen,
              ),
              UniversalButtonWidget(
                ontap: (){
                  Get.back();
                  Get.offAllNamed(Routes.HOME);
                },
                color: CustomColor.ultraLightBlue,
                margin: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightTen,
                  horizontal: ScreenConstant.screenWidthThird,
                ),
                leadingIconvisible: true,
                title: AppStrings.ok.tr,
                titleTextStyle: TextStyles.textStyleRegular
                    .apply(color: CustomColor.primaryBlack),
              ),
            ],
          )),
    );
  }
}
