import 'package:flutter/material.dart';

import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/utils.dart';
class HomeCardWidget extends StatelessWidget {
   HomeCardWidget({Key? key,this.title,this.onTap,this.boxFit,this.hideSubTitle = false,this.walletText,this.walletTextStyle,this.isForWallet = false,this.height,this.borderRadiusGeometry,this.margin,this.padding,this.titleTextStyle,this.subTitle,this.backgroundImage,this.isTextAtRight,this.subTitleTextStyle}) : super(key: key);
String? title;
String? subTitle;
bool? hideSubTitle;
String? backgroundImage;
TextStyle? titleTextStyle;
TextStyle? subTitleTextStyle;
bool? isTextAtRight;
Function()? onTap;
EdgeInsets? margin;
EdgeInsets? padding;
BorderRadiusGeometry? borderRadiusGeometry;
double? height;
bool? isForWallet;
String? walletText;
TextStyle? walletTextStyle;
BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin??EdgeInsets.symmetric(horizontal: ScreenConstant.sizeSmall),
        padding: padding??EdgeInsets.symmetric(horizontal: ScreenConstant.sizeMidLarge),
        height: height??ScreenConstant.screenHeightSixth,
        decoration: BoxDecoration(borderRadius: borderRadiusGeometry??BorderRadius.circular(10),image: DecorationImage(
            image: AssetImage(backgroundImage??ImageUtils.takeChallangeImage),fit: boxFit??BoxFit.fitWidth
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: isTextAtRight??false?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text(title??"",style: titleTextStyle,),
            hideSubTitle??false?Offstage():Container(height: ScreenConstant.defaultHeightFour,),
           hideSubTitle??false?Offstage():Text(subTitle??"",style: subTitleTextStyle,),
            isForWallet??false?Container(height: ScreenConstant.defaultHeightFour,): Offstage(),
            isForWallet??false?redHeartCurrency(walletText,ImageUtils.whiteHeartImage,walletTextStyle):Offstage(),
          ],
        ),
      ),
    );
  }
}
