import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/home/views/challange/rap_challange_view.dart';
import '../../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../controller/challange_controller.dart';
import 'dance_challange_view.dart';
class TakeAChallenge extends StatelessWidget {
   TakeAChallenge({Key? key}) : super(key: key);
  ChallengeController rapChallengeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryScaffoldColor,
      appBar:CommonAppbarWidget(
        titleSpacing: 0,
        titleTextStyle: TextStyles.appbarSmallTitleStyleBold,
        title: AppStrings.challenge.tr,
        isLeadingPresent: true,
        leadingOnTap: (){Get.back();rapChallengeController.player.stop();rapChallengeController.isPlayedRapSong.value = false;},
        centerTitle: false,
        leadingWidgetIcon:  Icons.arrow_back_ios_new_rounded,
        leadingWidgetSize: ScreenConstant.smallIconSize,
      ),
      body: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthTwenty,vertical: ScreenConstant.defaultHeightTen),
                    height: ScreenConstant.defaultHeightForty,
                    decoration: BoxDecoration(
                      color: CustomColor.fillOffWhiteColor,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      onTap: (value){
                        print("value:$value");
                        rapChallengeController.rapStageName.value = "";
                        rapChallengeController.stageName.value = "";
                        if(value == 0){
                          rapChallengeController.player.stop();
                          rapChallengeController.isPlayedRapSong.value = false;
                        }
                      },
                      dividerColor: Colors.transparent,
                      overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.transparent; // Color when tab is selected
                        }
                        return Colors.transparent; // Color when tab is not selected
                      }),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                        color: CustomColor.primaryBlue,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: false,
                      // indicatorColor: Colors.black,
                      // labelPadding: EdgeInsets.symmetric(
                      //     horizontal: 50, vertical: 5),
                      labelStyle: TextStyles.tabSelectedStyleSemiBold,
                      labelColor: CustomColor.white,
                      unselectedLabelColor: CustomColor.homeGrey,
                      tabs: [
                        Text(AppStrings.dance.tr,),
                        Text(AppStrings.sing.tr)
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                         rapChallengeController.getDanceMusicTrackModel.data?.videoType == 0? const DanceChallengesView():RapChallengeView(isVideoSubmitted: true,musicCreatedAtTime: rapChallengeController.getDanceMusicTrackModel.data?.videoCreatedAt ?? "",beatName: rapChallengeController.getAudioMusicTrackModel.getMusicTrackData?.musicName ?? "",),
                          rapChallengeController.getAudioMusicTrackModel.getMusicTrackData?.videoType  == 0 ? RapChallengeView(isVideoSubmitted: false,musicCreatedAtTime: rapChallengeController.getAudioMusicTrackModel.getMusicTrackData?.musicCreatedAt??"",beatName: rapChallengeController.getAudioMusicTrackModel.getMusicTrackData?.musicName??"",) : RapChallengeView(isVideoSubmitted: true,musicCreatedAtTime: rapChallengeController.getAudioMusicTrackModel.getMusicTrackData?.videoCreatedAt ?? "",beatName: rapChallengeController.getAudioMusicTrackModel.getMusicTrackData?.musicName??"",)
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
