import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../../routes/routes.dart';
import '../../controller/challange_controller.dart';
import '../../widgets/common_appbar_action_connect_widget.dart';
class InstructionViewScreen extends StatelessWidget {
   InstructionViewScreen({Key? key}) : super(key: key);
  ChallengeController rapChallengeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.fillOffWhiteColor,
      appBar: CommonAppbarWidget(
        actionWidgets: [
          CommonAppBarConnectWidget()
        ],
        isActionPresent: true,
        backgroundColor: CustomColor.fillOffWhiteColor,
        titleTextStyle: TextStyles.appbarTitleStyleBold,
        isLeadingPresent: true,
        leadingOnTap: () {
          Get.back();
        },
        leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
        leadingWidgetSize: ScreenConstant.smallIconSize,
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
            color: CustomColor.fillOffWhiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: ScreenConstant.screenHeightTenth,
        child: Obx(()=>rapChallengeController.isLoading.value?const Center(child: CircularProgressIndicator(),):UniversalButtonWidget(
            ontap: (){
              rapChallengeController.getDanceVideo();
            },
            borderRadius: BorderRadius.circular(15),
            trailingIcon: Icon(Icons.arrow_forward,color: CustomColor.white,size: ScreenConstant.smallIconSize,),
            trailingIconVisible: true,
            color: CustomColor.primaryBlue,
            margin: EdgeInsets.symmetric(
              vertical: ScreenConstant.defaultHeightTen,
              horizontal: ScreenConstant.defaultWidthForty,
            ),
            leadingIconvisible: true,
            title: AppStrings.next.tr.toUpperCase(),
            titleTextStyle: TextStyles.textStyleRegular
                .apply(color: CustomColor.white),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.screenWidthThirteen),
            child: Text(AppStrings.nominatedAndWinning,style: TextStyles.homeTabStyleSemiBold.copyWith(fontSize: 18,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
          ),
          Container(height: ScreenConstant.defaultHeightTwentyThree,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenConstant.screenWidthThirteen),
            child: Container(
              height: ScreenConstant.defaultHeightSixFifty,
              child: Stack(
                children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                  
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: ScreenConstant.defaultHeightOneForty,
                          width: ScreenConstant.defaultWidthOneSixty,
                          decoration: BoxDecoration(color: CustomColor.white),
                          child: Column(
                            children: [
                              Image.asset(ImageUtils.instruction1),
                              Container(height: ScreenConstant.defaultHeightTen,),
                              Center(child: Text(AppStrings.choose_Challenge,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 12,fontWeight: FontWeight.w600),))
                            ],
                          ),
                        ),
                      ),
                      Container(width: ScreenConstant.defaultWidthTwentyThree,),
                      Image.asset(ImageUtils.toRight,width: ScreenConstant.screenWidthFourth,)
                    ],
                  ),
                ),
                  Positioned(
                    top: ScreenConstant.screenHeightSeventh,
                    right: 0,
                    child:  Row(
                   
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImageUtils.toLeft,width: ScreenConstant.screenWidthFourth,),
                      Container(width: ScreenConstant.defaultWidthTwentyThree,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: ScreenConstant.defaultHeightOneForty,
                          width: ScreenConstant.defaultWidthOneSixty,
                          decoration: BoxDecoration(color: CustomColor.white),
                          child: Column(
                            children: [
                              Image.asset(ImageUtils.instruction2,),
                              Container(height: ScreenConstant.defaultHeightTen,),
                              Center(child: Text(AppStrings.listenToBeat,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 12,fontWeight: FontWeight.w600),))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),),
                  Positioned(
                    top: ScreenConstant.screenHeightThirdAndHalf,
                    left: 0,
                    right: 0,
                    child: Row(
                     
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: ScreenConstant.defaultHeightOneForty,
                            width: ScreenConstant.defaultWidthOneSixty,
                            decoration: BoxDecoration(color: CustomColor.white),
                            child: Column(
                              children: [
                                Image.asset(ImageUtils.instruction3),
                                Container(height: ScreenConstant.defaultHeightTen,),
                                Center(child: Text(AppStrings.recordYourVideo,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 12,fontWeight: FontWeight.w600),))
                              ],
                            ),
                          ),
                        ),
                        Container(width: ScreenConstant.defaultWidthTwentyThree,),
                        Image.asset(ImageUtils.toRight,width: ScreenConstant.screenWidthFourth,)
                      ],
                    ),
                  ),
                  Positioned(
                    top: ScreenConstant.screenHeightHalfPointFive,
                    right: 0,
                    child:  Row(
                     
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(ImageUtils.toLeft,width: ScreenConstant.screenWidthFourth,),
                        Container(width: ScreenConstant.defaultWidthTwentyThree,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: ScreenConstant.defaultHeightOneForty,
                            width: ScreenConstant.defaultWidthOneSixty,
                            decoration: BoxDecoration(color: CustomColor.white),
                            child: Column(
                              children: [
                                Image.asset(ImageUtils.instruction4,),
                                Container(height: ScreenConstant.defaultHeightTen,),
                                Center(child: Text(AppStrings.previewYourVideo,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 12,fontWeight: FontWeight.w600),))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),),
                  Positioned(
                    top: ScreenConstant.screenHeightOnePointSeven,
                    left: 0,
                    right: 0,
                    child: Row(
                     
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: ScreenConstant.defaultHeightOneForty,
                            width: ScreenConstant.defaultWidthOneSixty,
                            decoration: BoxDecoration(color: CustomColor.white),
                            child: Column(
                              children: [
                                Image.asset(ImageUtils.instruction5),
                                Container(height: ScreenConstant.defaultHeightTen,),
                                Center(child: Text(AppStrings.submitYourVideo,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 12,fontWeight: FontWeight.w600),))
                              ],
                            ),
                          ),
                        ),
                       // Container(width: ScreenConstant.defaultWidthTwentyThree,),
                      //  Image.asset(ImageUtils.toRight,width: ScreenConstant.screenWidthFourth,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: ScreenConstant.defaultHeightForty,),
        ],
      ),
    );
  }
}
