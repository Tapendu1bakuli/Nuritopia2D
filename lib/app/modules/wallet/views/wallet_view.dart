import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/wallet/views/wallet_balance_view.dart';
import 'package:nuritopia2d/app/modules/wallet/views/wallet_history_view.dart';
import '../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../home/widgets/common_appbar_action_connect_widget.dart';
class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryScaffoldColor,
      appBar:CommonAppbarWidget(
        actionWidgets: [
          CommonAppBarConnectWidget()
        ],
        isActionPresent: true,
        titleSpacing: 0,
        titleTextStyle: TextStyles.appbarSmallTitleStyleBold,
        title: AppStrings.wallet.tr,
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
                      labelStyle: TextStyles.tabSelectedStyleSemiBold,
                      labelColor: CustomColor.white,
                      unselectedLabelColor: CustomColor.homeGrey,
                      tabs: [
                        Text(AppStrings.balance.tr,),
                        Text(AppStrings.history.tr)
                      ],
                    ),
                  ),
                   Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          WalletBalanceView(),
                        WalletHistoryView()
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
