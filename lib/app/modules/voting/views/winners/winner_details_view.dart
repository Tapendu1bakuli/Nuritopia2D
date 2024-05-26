import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../../routes/routes.dart';
import '../../../home/controller/home_controller.dart';
import '../../../home/widgets/common_appbar_action_connect_widget.dart';

class WinnerDetailsView extends GetView<HomeController> {
   WinnerDetailsView({Key? key}) : super(key: key);
  var one = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CommonAppbarWidget(
        actionWidgets: [
          CommonAppBarConnectWidget()
        ],
        isActionPresent: true,
        backgroundColor: CustomColor.primaryBlack,
        titleSpacing: 0,
        titleTextStyle: TextStyles.appbarSmallTitleStyleBold.copyWith(color: CustomColor.white),
        title: one[0],
        isLeadingPresent: true,
        leadingOnTap: (){Get.back();},
        centerTitle: false,
        leadingWidgetIcon:  Icons.arrow_back_ios_new_rounded,
        leadingWidgetSize: ScreenConstant.smallIconSize,
        leadingIconColor: CustomColor.white,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: Get.width,
            child: Image.asset(ImageUtils.video,fit: BoxFit.fitWidth,),
          ),
          Positioned(
              bottom: ScreenConstant.screenHeightFourteen,
              left: ScreenConstant.screenWidthFifteen,
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultHeightTwentyThree,vertical: ScreenConstant.defaultWidthTen),
            decoration: BoxDecoration(color: CustomColor.white.withOpacity(0.2),borderRadius: BorderRadius.circular(15),border: Border.all(width: 2,color: CustomColor.white.withOpacity(0.15))),
            child: Row(
              children: [
                Image.asset(ImageUtils.vote,scale: 3,),
                Container(width: ScreenConstant.defaultWidthTen,),
                Text("${AppStrings.vote.tr.toUpperCase()} : 600",style: TextStyles.redHeartTextStyleStyleBold.copyWith(fontSize: 12,fontWeight: FontWeight.w500),),
              ],
            ),
          )),
          Positioned(
              bottom: ScreenConstant.screenHeightFourteen,
              right: ScreenConstant.screenWidthFifteen,
              child: InkWell(
                onTap: (){
                  Get.toNamed(Routes.CONNECTWITHPERSON);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultHeightTwentyThree,vertical: ScreenConstant.defaultWidthTen),
                  decoration: BoxDecoration(color: CustomColor.white.withOpacity(0.2),borderRadius: BorderRadius.circular(15),border: Border.all(width: 2,color: CustomColor.white.withOpacity(0.15))),
                  child: Row(
                    children: [
                       Image.asset(ImageUtils.connect,color: CustomColor.primaryBlue,scale: 3,),
                      Container(width: ScreenConstant.defaultWidthTen,),
                      Text("${AppStrings.connect.tr.toUpperCase()}",style: TextStyles.redHeartTextStyleStyleBold.copyWith(fontSize: 12,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
