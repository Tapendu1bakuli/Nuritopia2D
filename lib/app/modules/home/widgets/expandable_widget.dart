import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_text_form_field.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
class ExpandableCard extends StatelessWidget {
   ExpandableCard({Key? key,this.isExpanded,this.textEditingController,this.subtitle,this.hintText,this.initiallyExpanded,this.isSubtitleVisible = false,this.title,this.image,this.ontap}) : super(key: key);
  String? image;
  String? title;
  String? subtitle;
  String? hintText;
  bool? isExpanded;
  bool? initiallyExpanded;
  bool? isSubtitleVisible;
  TextEditingController? textEditingController;
  Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenConstant.defaultWidthTwenty),
      child: InkWell(
        onTap: ontap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(color: CustomColor.white),
            padding: EdgeInsets.symmetric(
            vertical: ScreenConstant.defaultHeightFifteen,
            horizontal: ScreenConstant.defaultWidthTwenty),
            child: Column(
              children: [
                Row(
                  children: [
            Container(
                width: ScreenConstant.defaultWidthFifty,
                height: ScreenConstant.defaultHeightFifty,
                decoration: BoxDecoration(
                    color: CustomColor.fillOffWhiteColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    image??ImageUtils.paypal,
                  ),
                ),
              ),
            Container(width: ScreenConstant.defaultWidthTen,),
            Text(
                  title??"",
                  style: TextStyles.homeTabSecondCardTitleStyleBold
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                    Spacer(),
              Container(
                  height: ScreenConstant.defaultHeightTwentyThree,
                  width: ScreenConstant.defaultWidthTwenty,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isExpanded??false?CustomColor.primaryBlue:CustomColor.fillOffWhiteColor),
                  child: isExpanded??false?Icon(Icons.check,color: CustomColor.white,size: ScreenConstant.minimumIconSize,):Offstage(),
                ),
                  ],
                ),
                isExpanded??false?Container(height: ScreenConstant.defaultHeightFifteen,):Offstage(),
                isExpanded??false?
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      color: CustomColor.dividerColor.withOpacity(0.6),
                    )
                    :Offstage(),
                isExpanded??false?Container(height: ScreenConstant.defaultHeightFifteen,):Offstage(),
                isExpanded??false?
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenConstant.defaultWidthTen,
                      ),
                      child: DefaultEditText(
                        onSaved: (input) {
                          textEditingController?.text = input!;
                        },
                       // onSubmit: controller.onSubmit.value = false,
                        type: Type.stageName,
                        prefixIcon: Container(),
                        style: TextStyles.textFieldTextStyleSemiBold,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: textEditingController,
                        hintText: hintText??"",
                      ),
                    )
                    :Offstage(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
