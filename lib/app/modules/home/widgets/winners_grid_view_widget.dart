import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
class WinnersGridViewWidget extends StatelessWidget {
   WinnersGridViewWidget({Key? key,this.date,this.beat,this.imageName,this.songName,this.onTap}) : super(key: key);
String? imageName;
String? songName;
String? beat;
String? date;
Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  child: Container(
                    width: Get.width,
                    child: Image.network(
                      imageName??"https://dbd716yj1y561.cloudfront.net/music/vGjUoxUJbsVzhjIWcBTgaVVu0w0OVDweVOi2CFeb.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
            Container(height: ScreenConstant.defaultHeightFifteen,),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthTen,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(AppStrings.songName.tr,style: TextStyles.homeTabSecondCardTitleStyleBold.copyWith(fontSize: 16),),
                        Flexible(child: Text(songName??"Goes like fly",style: TextStyles.homeTabSecondCardTitleStyleBold.copyWith(fontSize: 16),overflow: TextOverflow.ellipsis,)),
                      ],
                    ),
                    Container(height: ScreenConstant.defaultHeightFour,),
                    Row(
                      children: [
                        Text(AppStrings.beat.tr,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 14),),
                        Flexible(child: Text(beat??"Voice",style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 14,overflow: TextOverflow.ellipsis),),),
                      ],
                    ),
                    Container(height: ScreenConstant.defaultHeightFour,),
                    Row(
                      children: [
                        Text(AppStrings.date.tr,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 14),),
                        Text(date??"02 Feb, 2024",style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 14),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 15,),
          ],
        ),
      ),
    );
  }
}
