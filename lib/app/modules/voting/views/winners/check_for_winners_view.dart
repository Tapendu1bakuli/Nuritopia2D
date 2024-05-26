import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/voting/controller/voting_controller.dart';
import '../../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../home/widgets/common_appbar_action_connect_widget.dart';
import 'check_for_winners_dance.dart';
import 'check_for_winners_rap.dart';
class CheckForWinnersView extends StatelessWidget {
   CheckForWinnersView({Key? key}) : super(key: key);
VotingController controller = Get.put(VotingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CommonAppbarWidget(
        actionWidgets: [
          CommonAppBarConnectWidget()
        ],
        isActionPresent: true,
        titleSpacing: 0,
        titleTextStyle: TextStyles.appbarSmallTitleStyleBold,
        title: AppStrings.pastWinners.tr,
        isLeadingPresent: true,
        leadingOnTap: (){Get.back();},
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
                    onTap: (input){
                      controller.winnerListDance.clear();
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
                      children: [
                        CheckForWinnersDance(),
                        CheckForWinnersRap()
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
