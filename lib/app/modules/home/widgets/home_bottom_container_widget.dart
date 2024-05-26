import 'package:flutter/material.dart';

import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
class HomeBottomContainerWidget extends StatelessWidget {
   HomeBottomContainerWidget({Key? key,this.date,this.onTap,this.buttonText,this.firstTitle,this.secondTitle}) : super(key: key);
String? firstTitle;
String? secondTitle;
String? date;
String? buttonText;
Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeMidLarge),
      height: ScreenConstant.screenHeightThird,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageUtils.carousalImages),
              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(firstTitle??"",style: TextStyles.homeTabSecondCardTitleStyleBold.copyWith(color: CustomColor.white,fontSize: 28),),
          Text(secondTitle??"",style: TextStyles.homeTabSecondCardTitleStyleBold.copyWith(color: CustomColor.primaryBlue,fontSize: 24),),
          Container(
            height: ScreenConstant.defaultHeightTen,
          ),
          Text(date??"",style: TextStyles.homeBottomSubtitleTitleStyleSemiBold,),
          Container(
            height: ScreenConstant.defaultHeightFifteen,
          ),
          InkWell(
              onTap: onTap,
              child: Container(padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeMidLarge,vertical: ScreenConstant.sizeMedium),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: CustomColor.primaryBlue),child: Text(buttonText??"",style: TextStyles.homeBottomButtonTextStyleStyleSemiBold,),))
        ],
      ),
    );
  }
}
