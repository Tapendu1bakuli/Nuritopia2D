import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../controller/home_controller.dart';
import '../../widgets/buy_ticket_details_availability_card_widget.dart';

class BuyTicketsDetailsView extends GetView<HomeController> {
   BuyTicketsDetailsView({Key? key}) : super(key: key);
  dynamic argumentData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryScaffoldColor,
      appBar: CommonAppbarWidget(
        titleTextStyle: TextStyles.appbarTitleStyleBold,
        title: argumentData[4],
        isLeadingPresent: true,
        leadingOnTap: () {
          Get.back();
        },
        centerTitle: true,
        leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
        leadingWidgetSize: ScreenConstant.smallIconSize,
      ),
      body: Column(
        children: [
          Center(
              child: Text(
            "94FJZr3ZIh",
            style: TextStyles.appbarTitleStyleBold,
          )),
          Container(
            height: ScreenConstant.defaultHeightTen,
          ),
          Center(
              child: Text(
                "${argumentData[6]}",
            style: TextStyles.appbarTitleStyleBold,
          )),
          Container(
            height: ScreenConstant.defaultHeightTen,
          ),
          SizedBox(
            height: ScreenConstant.screenHeightFourth,
            width: Get.width,
            child: Image.asset(
              argumentData[0],
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
            horizontal: ScreenConstant.defaultWidthThirty,vertical: ScreenConstant.defaultHeightFifteen,
          ),
          child: Row(
            children: [
              Text("${argumentData[1]} ${argumentData[3]} ${argumentData[8]}, ${argumentData[5]}",style: TextStyles.homeBottomSubtitleTitleStyleSemiBold,),
              Spacer(),
              Text("${argumentData[9]}",style: TextStyles.homeBottomSubtitleTitleStyleSemiBold,),
            ],
          ),
          ),
          Padding(
          padding: EdgeInsets.symmetric(
          horizontal: ScreenConstant.defaultWidthThirty,),
            child: Divider(
              color: CustomColor.homeGrey.withOpacity(0.5),
            ),
          ),
          Container(
            height: ScreenConstant.screenHeightTowAndHalf,
            child: ListView.separated(
              itemCount: controller.availableTicketsModel.length,
              itemBuilder: (context, index) {
                  return BuyTicketDetailsAvailabilityCardWidget(
                    firstTitle: controller.availableTicketsModel[index].firstTitle,
                    secondTitle: controller.availableTicketsModel[index].secondTitle,
                    secondSubTitle: controller.availableTicketsModel[index].secondSubTitle,
                    onTap: (){
                      print("Index:$index");
                    },
                  );
              }, separatorBuilder: (BuildContext context, int index) {
                return Container(height: ScreenConstant.defaultHeightFifteen,);
            },
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            color: CustomColor.primaryBlue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: ScreenConstant.screenHeightSixth,
        child: UniversalButtonWidget(
          color: CustomColor.fillOffWhiteColor,
          margin: EdgeInsets.symmetric(
            vertical: ScreenConstant.defaultHeightForty,
            horizontal: ScreenConstant.defaultWidthThirty,
          ),
          leadingIconvisible: true,
          title: AppStrings.buyNow.tr,
          titleTextStyle: TextStyles.textStyleRegular
              .apply(color: CustomColor.primaryDeepblue),
        ),
      ),
    );
  }
}
