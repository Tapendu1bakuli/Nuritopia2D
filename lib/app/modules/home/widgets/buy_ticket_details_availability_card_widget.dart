import 'package:flutter/material.dart';

import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
class BuyTicketDetailsAvailabilityCardWidget extends StatelessWidget {
   BuyTicketDetailsAvailabilityCardWidget({Key? key,this.onTap,this.firstTitle,this.secondTitle,this.secondSubTitle}) : super(key: key);
String? firstTitle;
String? secondTitle;
String? secondSubTitle;
Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenConstant.defaultWidthThirty,),
        child: Container(
          height: ScreenConstant.screenHeightTenth,
          padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthThirty,),
          decoration: BoxDecoration(
              color: CustomColor.secondaryOffWhiteColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              Text(firstTitle??"",style: TextStyles.homeBottomSubtitleTitleStyleSemiBold,),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(secondTitle??"",style: TextStyles.homeBottomSubtitleTitleStyleSemiBold,),
                  Container(height: ScreenConstant.defaultHeightFour,),
                  Text(secondSubTitle??"",style: TextStyles.homeBottomSubtitleTitleStyleSemiBold,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
