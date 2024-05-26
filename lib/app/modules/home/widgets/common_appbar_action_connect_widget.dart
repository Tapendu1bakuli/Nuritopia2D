import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';

class CommonAppBarConnectWidget extends StatelessWidget {
  CommonAppBarConnectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthTwenty),
    //   child: InkWell(onTap:(){launchUrls(Uri.parse(AppStrings.nuritopiaWebLink));},child: Image.asset(ImageUtils.connect,color: CustomColor.primaryBlue,scale: 4,)),
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenConstant.defaultWidthTwenty,
      ),
      child: InkWell(
        onTap: () {
          launchUrls(Uri.parse(AppStrings.nuritopiaWebLink));
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: ScreenConstant.defaultHeightFifteen),
          padding:
              EdgeInsets.symmetric(horizontal: ScreenConstant.defaultHeightTen),
          decoration: BoxDecoration(
              color: CustomColor.primaryBlue,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Text(
            AppStrings.metaverseAppbarAction.tr,
            style: TextStyles.drawerTitleBold.copyWith(fontSize: 12),
          )),
        ),
      ),
    );
  }
}
