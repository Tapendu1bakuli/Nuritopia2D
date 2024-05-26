import 'package:flutter/material.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/utils.dart';
class CarousalImageWidget extends StatelessWidget {
   CarousalImageWidget({Key? key,this.image,this.onTapString}) : super(key: key);
  String? image;
  // String? title;
  // String? subTitleLarge;
  // String? subTitleMid;
  String? onTapString;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        launchUrls(Uri.parse(onTapString??""));
      },
      child: Stack(children:[
        Image.network(image??ImageUtils.carousalImages,height: ScreenConstant.defaultMidHeight,fit: BoxFit.cover,),
        // Positioned(
        //   left: ScreenConstant.screenWidthTwelve,
        //     top: ScreenConstant.screenHeightMinimum,
        //     bottom: ScreenConstant.screenHeightFourteen,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(title??"",style: TextStyles.carousalTitleWidgetBlueText,),
        //         Container(height: ScreenConstant.defaultHeightFour,),
        //         Text(subTitleLarge??"",style: TextStyles.carousalSubTitleWidgetBlueText,),
        //         Container(height: ScreenConstant.defaultHeightFour,),
        //         Text(subTitleMid??"",style: TextStyles.carousalMidTitleWidgetBlueText,),
        //       ],
        //     ))
      ] ),
    );
  }
}
