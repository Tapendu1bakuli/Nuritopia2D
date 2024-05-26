import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../languages/LocalizationService.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../routes/routes.dart';
import '../../home/widgets/common_appbar_action_connect_widget.dart';
class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop){
        onWillPop();
      },
      child: Scaffold(
        backgroundColor: CustomColor.fillOffWhiteColor,
        appBar:CommonAppbarWidget(
          backgroundColor: CustomColor.fillOffWhiteColor,
          titleSpacing: 0,
          titleTextStyle: TextStyles.appbarSmallTitleStyleBold.copyWith(fontSize: 18,fontWeight: FontWeight.w500),
          title: AppStrings.selectLanguage.toUpperCase().tr,
          centerTitle: true,
          leadingWidgetIcon:  Icons.arrow_back_ios_new_rounded,
          leadingWidgetSize: ScreenConstant.smallIconSize,
        ),
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(height: ScreenConstant.screenHeightMinimum,),
            Center(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageUtils.containerRoundedBack)),
                      shape: BoxShape.circle),
                  height: ScreenConstant.screenHeightFourth,
                  child: Image.asset(
                    ImageUtils.splashNuritopiaLogo,
                    scale: 2,
                  ),
                )),
          Container(height: ScreenConstant.screenHeightNineteen,),
          ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: LocalizationService.languages.length,
          itemBuilder: (BuildContext context, int index) {
            var model = LocalizationService.languages[index];
            return UniversalButtonWidget(
              ontap: (){
                LocalizationService().changeLocale(model);
                Get.offAllNamed(Routes.LOGIN);
              },
              borderColor: CustomColor.primaryBlue,
              color: CustomColor.white,
              borderRadius: BorderRadius.circular(15),
              margin: EdgeInsets.symmetric(
                vertical: ScreenConstant.defaultHeightFifteen,
                horizontal: ScreenConstant.screenWidthTenth,
              ),
              leadingIconvisible: true,
              title: "$model".toUpperCase(),
              titleTextStyle: TextStyles.textStyleRegular
                  .apply(color: CustomColor.primaryBlue),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 28),
        ),
            Container(height: ScreenConstant.screenHeightFifth,),
            Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Column(children: <Widget>[
                 Text(
                  AppStrings.talentShould,
                  style: TextStyles.languageSelectionTextStyle.copyWith(color: CustomColor.primaryBlue,fontStyle: FontStyle.italic,)
                ),
                Container(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                      text: AppStrings.my,
                      style: TextStyles.languageSelectionTextStyle.copyWith(color: CustomColor.dividerColor.withOpacity(0.4)),
                      children: <TextSpan>[
                        TextSpan(
                          text: AppStrings.ti,
                          style: TextStyles.languageSelectionTextStyle.copyWith(color: CustomColor.primaryBlue),
                        ),
                        TextSpan(
                          text: AppStrings.me,
                          style: TextStyles.languageSelectionTextStyle.copyWith(color: CustomColor.dividerColor.withOpacity(0.4)),
                        ),
                        TextSpan(
                          text: AppStrings.toS,
                          style: TextStyles.languageSelectionTextStyle.copyWith(color: CustomColor.primaryBlue),
                        ),
                        TextSpan(
                          text: AppStrings.hine,
                          style: TextStyles.languageSelectionTextStyle.copyWith(color: CustomColor.dividerColor.withOpacity(0.4)),
                        ),
                      ]),
                ),
              ]),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
