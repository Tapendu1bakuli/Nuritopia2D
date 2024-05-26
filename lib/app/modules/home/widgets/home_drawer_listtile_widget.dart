import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
class HomeDrawerListTileWidget extends StatelessWidget {
   HomeDrawerListTileWidget({Key? key,this.leadingImage,this.isColoured,this.isDefaultIcon,this.titleText,this.leadingImageHeight,this.titleTextStyles,this.onTap}) : super(key: key);
String? leadingImage;
String? titleText;
double? leadingImageHeight;
TextStyle? titleTextStyles;
Function()? onTap;
bool? isDefaultIcon;
bool? isColoured;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isColoured??false?CustomColor.secondaryBlue:CustomColor.primaryBlue,
        padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultHeightFifteen,vertical: ScreenConstant.defaultHeightFour),
        child: ListTile(
          leading: isDefaultIcon??false?Icon(Icons.delete,color: CustomColor.white,):Image.asset(
            leadingImage??ImageUtils.share,
            color: CustomColor.white,
            height: leadingImageHeight??ScreenConstant.defaultHeightTwentyThree,
          ),
          title: Text(
            titleText??AppStrings.inviteFriend.tr,
            style:
            titleTextStyles??TextStyles.textStyleRegular.apply(color: Colors.black),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
