import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../../common/widgets/Loader.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../controller/home_controller.dart';
import '../../widgets/common_appbar_action_connect_widget.dart';
import '../../widgets/expandable_widget.dart';

class RewardedAccountView extends GetView<HomeController> {
  RewardedAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Obx(()=>Stack(
          children: [
            Scaffold(
              backgroundColor: CustomColor.fillOffWhiteColor,
              appBar: CommonAppbarWidget(
                actionWidgets: [CommonAppBarConnectWidget()],
                isActionPresent: true,
                titleSpacing: 0,
                titleTextStyle: TextStyles.appbarSmallTitleStyleBold,
                title: AppStrings.rewardAccounts.tr,
                isLeadingPresent: true,
                leadingOnTap: () {
                  Get.back();
                },
                centerTitle: false,
                leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
                leadingWidgetSize: ScreenConstant.smallIconSize,
              ),
              bottomSheet: UniversalButtonWidget(
                ontap: () {
                   controller.saveRewardAccount(controller.rewardAccountId.value,controller.rewardAccountText.text);
                },
                height: ScreenConstant.screenHeightFifteen,
                width: Get.width,
                color: CustomColor.primaryBlue,
                margin: EdgeInsets.symmetric(
                  vertical: ScreenConstant.defaultHeightForty,
                  horizontal: ScreenConstant.defaultWidthForty,
                ),
                leadingIconvisible: true,
                title: AppStrings.save.tr,
                titleTextStyle:
                    TextStyles.textStyleRegular.apply(color: CustomColor.white),
              ),
              body: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenConstant.defaultWidthThirty,
                        vertical: ScreenConstant.defaultHeightTen),
                    child: Text(
                      AppStrings.subhead_Account_Type.tr,
                      style: TextStyles.textStyleSemiBold.copyWith(
                          color: CustomColor.primaryDeepblue,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Obx(
                    () => controller.rewardAccountList.isNotEmpty
                        ? ListView.separated(
                            key: Key('builder ${controller.selected.toString()}'),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.rewardAccountList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ExpandableCard(
                                key: Key(index.toString()),
                                textEditingController: controller.rewardAccountText,
                                hintText:
                                    controller.rewardAccountList[index].hintText,
                                image: controller.rewardAccountList[index].image,
                                title: controller.rewardAccountList[index].title,
                                subtitle:
                                    controller.rewardAccountList[index].subtitle,
                                ontap: () {
                                  controller.rewardAccountId.value = controller.rewardAccountList[index].title.toString();
                                  controller.rewardAccountText.text = "";
                                  controller.rewardAccountList.forEach(
                                      (element) => element.isExpanded = false);
                                  controller.rewardAccountList[index].isExpanded =
                                      !controller
                                          .rewardAccountList[index].isExpanded!;
                                  controller.rewardAccountList.refresh();
                                },
                                initiallyExpanded: index == controller.selected,
                                //att
                                isExpanded: controller
                                    .rewardAccountList[index].isExpanded,
                                isSubtitleVisible: controller
                                    .rewardAccountList[index].isSubtitle,
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Container(
                                height: ScreenConstant.defaultHeightFifteen,
                              );
                            },
                          )
                        : Offstage(),
                  ),
                ],
              ),
            ),
            Visibility(
              child: Loader(
                text: "",
              ),
              visible: controller.isLoading.value,
            )
          ],
        ),
      );

  }
}
