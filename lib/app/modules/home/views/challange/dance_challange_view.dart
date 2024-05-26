import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/home/views/challange/video_recording_view.dart';
import '../../../../../common/common_text_form_field.dart';
import '../../../../../common/widgets/Loader.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../../../utils/utils.dart';
import '../../controller/challange_controller.dart';
import '../../widgets/CustomYoutubePlayer.dart';

class DanceChallengesView extends GetView<ChallengeController> {
  const DanceChallengesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: CustomColor.fillOffWhiteColor,
        bottomSheet: Obx(()=>controller.stageName.value.isNotEmpty?Container(
            decoration: BoxDecoration(
              color: CustomColor.white,
            ),
            height: ScreenConstant.screenHeightFourth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenConstant.defaultWidthSixty,
                      vertical: ScreenConstant.defaultHeightFifteen),
                  child: Text(
                    AppStrings.onboard_Seven.tr,
                    style: TextStyles.homeTabSecondCardTitleStyleBold.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w400, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(
                  color: CustomColor.dividerColor.withOpacity(0.2),
                ),
                UniversalButtonWidget(
                  ontap: (){
                    //videoType 1 rap
                    // videoType 2 dance
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoRecording(
                            musicId: controller.getDanceMusicTrackModel.data?.musicId,
                            stageName: controller.stageName.value,
                            videoType: 2,
                            audioTrack: controller.getDanceMusicTrackModel.data?.musicPath??"",
                          ),
                        ));
                  },
                  color: CustomColor.primaryBlue,
                  margin: EdgeInsets.symmetric(
                    vertical: ScreenConstant.defaultHeightTen,
                    horizontal: ScreenConstant.defaultWidthForty,
                  ),
                  leadingIconvisible: true,
                  title: AppStrings.startLowerCase.tr,
                  titleTextStyle:
                      TextStyles.textStyleRegular.apply(color: CustomColor.white),
                ),
              ],
            ),
          ):Offstage(),
        ),
        body: controller.isLoading.value?const Center(child: CircularProgressIndicator(),):ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenConstant.defaultWidthTen,
                  vertical: ScreenConstant.defaultHeightFifteen),
              height: ScreenConstant.screenHeightFourth,
              decoration: BoxDecoration(
                  border: Border(

              )),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CustomYoutubePlayer(
                    youTubeUrl: controller.getDanceMusicTrackModel.data!.danceYoutubeLink
                        .toString()),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightTwentyThree,horizontal: ScreenConstant.defaultWidthTwenty),
              decoration: BoxDecoration(color: CustomColor.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.stageNameGoesHere.tr,
                    style: TextStyles
                        .walletBalanceTopUpCardTopTextStyleStyleBold
                        .copyWith(
                        color: CustomColor.primaryDeepblue,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(height: ScreenConstant.defaultHeightTen,),
                  Obx(()=> Text(
                      "${AppStrings.stageName.tr} : ${controller.stageName.value}",
                      style: TextStyles.appbarSmallTitleStyleBold.copyWith(
                          color: CustomColor.primaryDeepblue,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
              Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: ScreenConstant.defaultHeightFifteen,
                            ),
                            DefaultEditText(
                              onChanged: (String? value){
                                print("$value");
                                controller.stageName.value = value!;
                              },
                              onSaved: (input) {},
                              onSubmit: controller.onSubmit.value = false,
                              type: Type.stageName,
                              prefixIcon: Container(),
                              style: TextStyles.textFieldTextStyleSemiBold,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              controller: controller.stageNameController,
                              hintText: AppStrings.stageNameGoesHere.tr,
                            ),

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
