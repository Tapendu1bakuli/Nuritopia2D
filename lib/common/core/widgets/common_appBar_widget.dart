

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../device_manager/screen_constants.dart';
import '../../../utils/TextStyles.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/text_utils/app_strings.dart';
class CommonAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
   CommonAppbarWidget({Key? key,this.titleSpacing,this.leadingWidth,this.backgroundColor,this.leadingIconColor,this.actionWidgets,this.isActionPresent,this.titleTextStyle,this.title,this.isLeadingPresent = false,this.centerTitle,this.leadingOnTap,this.leadingWidgetIcon,this.leadingWidgetSize}) : super(key: key);
   String? title;
   bool? centerTitle;
   bool? isLeadingPresent;
   bool? isActionPresent;
   TextStyle? titleTextStyle;
   Function()? leadingOnTap;
   IconData? leadingWidgetIcon;
   double? leadingWidgetSize;
   double? leadingWidth;
   List<Widget>? actionWidgets;
   Color? backgroundColor;
   double? titleSpacing;
   Color? leadingIconColor;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      titleSpacing: titleSpacing,
      scrolledUnderElevation: 0.0,
      actions: isActionPresent??false?actionWidgets:[],
      backgroundColor: backgroundColor??CustomColor.primaryScaffoldColor,
      centerTitle: centerTitle??false,
      title: Text(
        title??"",
        style: titleTextStyle,
      ),
      leading: isLeadingPresent??false?InkWell(
          onTap: leadingOnTap,
          child: Icon(
            leadingWidgetIcon,
            size: leadingWidgetSize,
            color: leadingIconColor,
          )):const Offstage(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
