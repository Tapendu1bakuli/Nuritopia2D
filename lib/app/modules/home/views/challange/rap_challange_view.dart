import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/home/views/challange/video_recording_view.dart';
import '../../../../../common/common_text_form_field.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../../../utils/utils.dart';
import '../../controller/challange_controller.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
class RapChallengeView extends GetView<ChallengeController> {
   RapChallengeView({Key? key,required this.isVideoSubmitted,required this.musicCreatedAtTime,required this.beatName}) : super(key: key);
  bool isVideoSubmitted;
  String musicCreatedAtTime;
  String beatName;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: CustomColor.fillOffWhiteColor,
        bottomSheet:  Obx(()=>
          controller.rapStageName.value.isNotEmpty? Container(
            decoration: const BoxDecoration(
              color: CustomColor.white,
            ),
            height: ScreenConstant.screenHeightFourth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthThirty,vertical: ScreenConstant.defaultHeightFifteen),
                  child: Row(
                    children: [
                      Expanded(flex:0,child: Image.asset(ImageUtils.error,height: ScreenConstant.defaultHeightTwentyThree,width: ScreenConstant.defaultWidthTwentyThree,)),
                      Container(width: ScreenConstant.defaultWidthTwenty,),
                      Expanded(flex:2,child: Text(AppStrings.onboard_Six.tr,style: TextStyles.homeTabSecondCardTitleStyleBold.copyWith(fontSize: 13,fontWeight: FontWeight.w400,height: 1.5),)),
                    ],
                  ),
                ),
                Divider(color: CustomColor.dividerColor.withOpacity(0.2),),
                UniversalButtonWidget(
                  ontap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoRecording(
                              videoType: 1,
                              stageName:
                              controller.rapStageName.value,
                            audioTrack: controller.getAudioMusicTrackModel.getMusicTrackData?.musicPath ?? "",
                          musicId: controller.getAudioMusicTrackModel.getMusicTrackData?.musicId,
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
                  titleTextStyle: TextStyles.textStyleRegular
                      .apply(color: CustomColor.white),
                ),
              ],
            ),
          ):const Offstage(),
        ),
        body: ListView(
          children: [
            Container(
              height: ScreenConstant.screenHeightFourth,
              decoration: BoxDecoration(
                  color: CustomColor.fillOffWhiteColor,
                  border: Border(
                    top: BorderSide(
                      color: CustomColor.dividerColor.withOpacity(0.2),
                    ),
                  )),
              child: Center(
                child: Stack(
                  children: [
                    Obx(()=> controller.isValueChanged.isTrue?RectangleWaveform(
                        showActiveWaveform: true,
                        isCentered: true,
                        activeColor: CustomColor.primaryBlue,
                        inactiveColor: CustomColor.inActiveWaveColor,
                        maxDuration: controller.maxDuration,
                        elapsedDuration: controller.position,
                        samples: controller.samples,
                        height: ScreenConstant.screenHeightSeventh,
                        width: MediaQuery.of(context).size.width,
                      ):Offstage(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: ScreenConstant.screenHeightFourteen,
              decoration: BoxDecoration(
                  color: CustomColor.white,
                  border: Border(
                      top: BorderSide(
                        color: CustomColor.dividerColor.withOpacity(0.2),
                      ),
                      bottom: BorderSide(
                        color: CustomColor.dividerColor.withOpacity(0.2),
                      ))),
              child: Obx(()=>Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                          if(controller.isPlayedRapSong.value){
                            controller.player.pause();
                            controller.isPlayedRapSong.value = !controller.isPlayedRapSong.value;
                          }else{
                            controller.player.resume();
                            controller.isPlayedRapSong.value = !controller.isPlayedRapSong.value;
                          }
                        },
                        child: Container(
                          height: ScreenConstant.defaultHeightForty,
                          width: ScreenConstant.defaultWidthForty,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColor.fillOffWhiteColor),
                          child: Icon(
                            controller.isPlayedRapSong.value?Icons.pause: Icons.play_arrow_rounded,
                            color: CustomColor.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: CustomColor.dividerColor.withOpacity(0.2),
                    ),
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                          controller.player.stop();
                          controller.isPlayedRapSong.value = false;
                        },
                        child: Container(
                          height: ScreenConstant.defaultHeightForty,
                          width: ScreenConstant.defaultWidthForty,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColor.primaryBlue),
                          child: const Icon(
                            Icons.stop_rounded,
                            color: CustomColor.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightFifteen),
              margin:
                  EdgeInsets.only(bottom: ScreenConstant.defaultHeightFifteen),
              decoration: const BoxDecoration(color: CustomColor.white),
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      ImageUtils.profilePicture,
                      height: ScreenConstant.defaultHeightFifty,
                      width: ScreenConstant.defaultWidthFifty,
                    ),
                    title: Row(
                      children: [
                        Text(
                          AppStrings.beat.tr,
                          style: TextStyles
                              .walletBalanceTopUpCardTopTextStyleStyleBold
                              .copyWith(
                              color: CustomColor.primaryDeepblue, fontSize: 16),
                        ),
                        Text(
                          beatName,
                          style: TextStyles
                              .walletBalanceTopUpCardTopTextStyleStyleBold
                              .copyWith(
                              color: CustomColor.primaryDeepblue, fontSize: 16),
                        ),
                      ],
                    ),
                    // subtitle: Row(
                    //   children: [
                    //     Text(
                    //       AppStrings.by.tr,
                    //       style: TextStyles.appbarSmallTitleStyleBold.copyWith(
                    //           color: CustomColor.secondaryBlack, fontSize: 13),
                    //     ),
                    //     Text(
                    //       controller.getAudioMusicTrackModel.getMusicTrackData?.musicName ?? "",
                    //       style: TextStyles.appbarSmallTitleStyleBold.copyWith(
                    //           color: CustomColor.secondaryBlack, fontSize: 13),
                    //     ),
                    //   ],
                    // ),
                  )
                ],
              ),
            ),
            isVideoSubmitted? Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightTwentyThree,horizontal: ScreenConstant.defaultWidthTwenty),
              decoration: const BoxDecoration(color: CustomColor.white),
              child: Text(
                  '''${AppStrings.videoPerformance} $musicCreatedAtTime. ${AppStrings.notifiedNext}  Dance ${AppStrings.challengePosted}.\n${AppStrings.meanwhile}.'''
              )
            ):Container(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightTwentyThree,horizontal: ScreenConstant.defaultWidthTwenty),
              decoration: const BoxDecoration(color: CustomColor.white),
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
                    "${AppStrings.stageName.tr} : ${controller.rapStageName.value}",
                    style: TextStyles.appbarSmallTitleStyleBold.copyWith(
                        color: CustomColor.primaryDeepblue,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
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
                                controller.rapStageName.value = value!;
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
            Obx(()=> controller.rapStageName.value.isNotEmpty?Container(height: ScreenConstant.screenHeightFifth,):const Offstage())
          ],
        ),
      ),
    );
  }
  Future modalBottomSheetMenuForStageName(BuildContext context) async {
    await showModalBottomSheet(
      elevation: 0.0,
        backgroundColor: CustomColor.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            height: ScreenConstant.screenHeightThird,
            decoration: const BoxDecoration(

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
                      height: ScreenConstant.defaultHeightTwentyThree,
                    ),
                   Text(AppStrings.stageName.tr,style: TextStyles.homeTabStyleSemiBold.copyWith(fontSize: 16,fontWeight: FontWeight.w600),),
                    Container(
                      height: ScreenConstant.defaultHeightFifteen,
                    ),
                    DefaultEditText(
                      onSaved: (input){
                      },
                      onSubmit: controller.onSubmit.value = false,
                      type: Type.stageName,
                      prefixIcon: Container(),
                      style: TextStyles.textFieldTextStyleSemiBold,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: controller.stageNameController,
                      hintText: AppStrings.stageNameGoesHere.tr,
                    ),
                    Container(
                      height: ScreenConstant.defaultHeightFifteen,
                    ),
                    UniversalButtonWidget(
                      ontap: (){
                        //modalBottomSheetMenuForVote(context);
                      },
                      color: CustomColor.primaryBlue,
                      margin: EdgeInsets.symmetric(
                        vertical: ScreenConstant.defaultHeightFifteen,

                      ),
                      leadingIconvisible: true,
                      title: AppStrings.submit.tr,
                      titleTextStyle: TextStyles.textStyleRegular
                          .apply(color: CustomColor.white),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
