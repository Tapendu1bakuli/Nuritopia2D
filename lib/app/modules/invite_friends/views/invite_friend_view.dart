import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../common/widgets/Loader.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../home/widgets/common_appbar_action_connect_widget.dart';
import '../controller/invite_friend_controller.dart';

class InviteFriendView extends GetView<InviteFriendController> {
  const InviteFriendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Stack(
      children: [
        Scaffold(
          backgroundColor: CustomColor.fillOffWhiteColor,
          appBar: CommonAppbarWidget(
            actionWidgets: [
              CommonAppBarConnectWidget()
            ],
            isActionPresent: true,
            titleTextStyle: TextStyles.editProfileTitleStyleBold,
            leadingOnTap: () {
              Get.back();
            },
            isLeadingPresent: true,
            leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
            leadingWidgetSize: ScreenConstant.smallIconSize,
            centerTitle: true,
          ),
          bottomSheet:  Container(
            decoration: BoxDecoration(
                color: CustomColor.fillOffWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            height: ScreenConstant.screenHeightEighth,
            child: UniversalButtonWidget(
              ontap: (){
                Share.share(controller.inviteFriendModel.referralCode??"", subject: 'Look what I made!');
              },
              color: CustomColor.primaryBlue,
              margin: EdgeInsets.symmetric(
                vertical: ScreenConstant.defaultHeightTwentyThree,
                horizontal: ScreenConstant.defaultWidthThirty,
              ),
              leadingIconvisible: true,
              title: AppStrings.share.tr,
              titleTextStyle: TextStyles.textStyleRegular
                  .apply(color: CustomColor.white),
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenConstant.defaultWidthTwenty),
                decoration: BoxDecoration(
                    color: CustomColor.white,
                    border: Border(
                        top: BorderSide(width: 4,
                            color: CustomColor.fillOffWhiteColor),
                        bottom: BorderSide(width: 4,
                            color: CustomColor.fillOffWhiteColor))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenConstant.defaultHeightTwentyThree,
                    ),
                    Text(
                      AppStrings.reward.tr.toUpperCase(),
                      style: TextStyles.splashTitleBlack.copyWith(fontSize: 18),
                    ),
                    Container(
                      height: ScreenConstant.defaultHeightTen,
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.rewardList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomColor.primaryBlack),
                            ),
                            Container(
                              width: ScreenConstant.sizeExtraSmall ,
                            ),
                            Text(
                              controller.rewardList[index],
                              style: TextStyles.homeTabStyleSemiBold
                                  .copyWith(fontSize: 14),
                            )
                          ],
                        );
                      }, separatorBuilder: (BuildContext context, int index) { return Container(
                      height: ScreenConstant.defaultHeightFour,
                    );},),
                    Container(
                      height: ScreenConstant.defaultHeightFour,
                    ),
                    Container(
                      height: ScreenConstant.defaultHeightTwentyThree,
                    ),
                  ],
                ),
              ),
              Container(
                height: ScreenConstant.defaultHeightForty,
              ),
              controller.inviteFriendModel.qrCode != null ?
              Image.memory(Uri.parse(controller.inviteFriendModel.qrCode ?? "").data?.contentAsBytes()
                  ?? Uint8List(0)
                ,gaplessPlayback: true,fit: BoxFit.contain,height: ScreenConstant.screenHeightThird,
                width: ScreenConstant.screenWidthThird, ) :
              Image.asset(ImageUtils.qr,fit: BoxFit.contain,height: ScreenConstant.screenHeightThird,
                width: ScreenConstant.screenWidthThird,),
              Container(
                padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightTwentyThree),
                margin: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthThirty,vertical: ScreenConstant.defaultHeightFifteen),
                decoration: BoxDecoration(
                    color: CustomColor.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: CustomColor.dividerColor.withOpacity(0.1),width: 1.5)
                ),
                child: Center(child: Text(
                  controller.inviteFriendModel.referralCode??"",style: TextStyles.splashTitleBlue.copyWith(fontSize: 16,fontWeight: FontWeight.w600),
                ),),
              )
            ],
          ),
        ),
        Visibility(
          visible: controller.isLoading.value,
          child: Loader(
            text: "",
          ),
        )
      ],
    ),
    );
  }
}
