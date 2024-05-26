import 'package:flutter/material.dart';

import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/colors/app_colors.dart';

class VotingBottomAvatarWidget extends StatelessWidget {
  VotingBottomAvatarWidget(
      {Key? key, this.image, this.onTap, this.isColored = false})
      : super(key: key);
  String? image;
  bool? isColored;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5)  ,
        width: ScreenConstant.defaultWidthNinetyEight * 0.9,
        // height: ScreenConstant.defaultWidthNinetyEight * 0.9,
        // width: 150,
        decoration: BoxDecoration(
          color: CustomColor.white,
          border: Border.all(
              color: isColored ?? false
                  ? CustomColor.primaryBlue
                  : Colors.transparent,
              width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Image.network(
              image ?? "",
              fit: BoxFit.fill,
              // width: 50,height: 1,
            )),
      ),
    );
  }
}
