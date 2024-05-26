
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../controller/splash_controller.dart';
class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.casual!.value?Image.asset(ImageUtils.splashNuritopiaLogo,height: ScreenConstant.screenHeightTwelve,):Offstage(),
            Container(height: ScreenConstant.defaultHeightTen,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.nuri.tr,  style: TextStyles.splashTitleBlue
                ),
                Text(
                  AppStrings.star.tr,style: TextStyles.splashTitleBlack,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
