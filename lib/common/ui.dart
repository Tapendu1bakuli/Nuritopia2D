import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/colors/app_colors.dart';



class Ui {
  static Future<void> closeAllSnackBar() async {
     Get.closeAllSnackbars();
  }

  static GetSnackBar SuccessSnackBar(
      {String title = 'Success',
      String? message,
      SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Get.theme.primaryColor))),
      messageText: Text(message!,
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Get.theme.primaryColor))),
      snackPosition: snackPosition,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon: Icon(Icons.check_circle_outline,
          size: 32, color: Get.theme.primaryColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 5),
    );
  }

  static GetSnackBar ErrorSnackBar(
      {String title = 'Error',
      String? message,
      SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    Get.log("[$title] $message", isError: true);

    String msg = message!.replaceAll("Exception: ", "");
    msg = msg.replaceAll("[", "");
    msg = msg.replaceAll("]", "");
    msg = msg.split("[").first;
    if (msg.isEmpty) {
      msg = message.replaceAll("Exception: ", "");
      msg = msg.split("]").last.trim();
    }
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Get.theme.primaryColor))),
      messageText: Text(msg.tr,
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Get.theme.primaryColor))),
      snackPosition: snackPosition,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline,
          size: 32, color: Get.theme.primaryColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static GetSnackBar defaultSnackBar({String title = 'Alert', String? message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text(message!,
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.warning_amber_rounded,
          size: 32, color: Get.theme.hintColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static GetSnackBar notificationSnackBar(
      {String title = 'Notification',
      String? message,
      OnTap? onTap,
      Widget? mainButton}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      onTap: onTap,
      mainButton: mainButton,
      titleText: Text(title.tr,
          style: Get.textTheme.titleLarge!
              .merge(TextStyle(color: Get.theme.hintColor))),
      messageText: Text(message!,
          style: Get.textTheme.bodySmall!
              .merge(TextStyle(color: Get.theme.focusColor))),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon:
          Icon(Icons.notifications_none, size: 32, color: Get.theme.hintColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static String parseColorString(String hexCode, {double? opacity}) {
    try {
      hexCode = hexCode.replaceAll("0xff", "#");
      hexCode = hexCode.replaceAll("(", "");
      hexCode = hexCode.replaceAll(")", "");
      hexCode = hexCode.replaceAll("Color", "");
      return hexCode;
    } catch (e) {
      return "#CCCCCC";
    }
  }

  static Color getColorFromDateTime(DateTime dateTime, {double? opacity}) {
    if (dateTime == null) {
      return Get.theme.colorScheme.primary;
    } else {
      try {
        String colorHex =
            (dateTime.millisecondsSinceEpoch ~/ 1000).toRadixString(16);
        colorHex = colorHex.replaceRange(0, 1, "FF");
        return Color(int.parse(colorHex, radix: 16));
      } catch (e) {
        return Get.theme.colorScheme.primary;
      }
    }
  }

  static List<Icon> getStarsList(double rate, {double size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: Color(0xFFFFB24D)));
    }
    list.addAll(
        List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star_border, size: size, color: Color(0xFFFFB24D));
    }));
    return list;
  }

  static TextStyle getPriceStyle(TextStyle style) {
    if (style == null) {
      return Get.textTheme.titleSmall!.merge(
        TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: Get.textTheme.titleSmall!.fontSize! - 4),
      );
    } else {
      return style.merge(
          TextStyle(fontWeight: FontWeight.w300, fontSize: style.fontSize! - 4));
    }
  }

  static BoxDecoration getBoxDecoration(
      {Color? color, double? radius, Border? border, Gradient? gradient}) {
    return BoxDecoration(
      color: color ?? Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
            color: Get.theme.focusColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5)),
      ],
      border:
          border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static InputDecoration getInputDecoration(
      {String hintText = '',
      String? errorText,
      IconData? iconData,
      Widget? suffixIcon,
      Widget? prefixIcon,
      Widget? suffix}) {
    return InputDecoration(
        fillColor:CustomColor.primaryOffWhiteColor,
        filled: true,
      hintText: hintText,
      hintStyle: TextStyle(
        letterSpacing: 0,
        color: CustomColor.primaryBlue,
        fontSize: 14,
        fontWeight: FontWeight.w300),
      prefixIcon: prefixIcon,
      prefixIconConstraints: iconData != null
          ? BoxConstraints.expand(width: 38, height: 38)
          : BoxConstraints.expand(width: 20, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(vertical: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: CustomColor.homeGrey.withOpacity(0.6),
              width: 2,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CustomColor.homeGrey.withOpacity(0.4), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CustomColor.homeGrey.withOpacity(0.1), width: 2),
        ),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
      counterText: errorText,
      errorMaxLines: 5,
    );
  }


  static AlignmentDirectional getAlignmentDirectional(
      String alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  static CrossAxisAlignment getCrossAxisAlignment(String textPosition) {
    switch (textPosition) {
      case 'top_start':
        return CrossAxisAlignment.start;
      case 'top_center':
        return CrossAxisAlignment.center;
      case 'top_end':
        return CrossAxisAlignment.end;
      case 'center_start':
        return CrossAxisAlignment.center;
      case 'center':
        return CrossAxisAlignment.center;
      case 'center_end':
        return CrossAxisAlignment.center;
      case 'bottom_start':
        return CrossAxisAlignment.start;
      case 'bottom_center':
        return CrossAxisAlignment.center;
      case 'bottom_end':
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }


  static String timePassed(DateTime datetime, {bool full = false}) {
    if (datetime != null) {
      DateTime now = DateTime.now();
      DateTime ago = datetime;
      Duration dur = now.difference(ago);
      int days = dur.inDays;
      int years = days ~/ 365;
      int months = (days - (years * 365)) ~/ 30;
      int weeks = (days - (years * 365 + months * 30)) ~/ 7;
      int rdays = days - (years * 365 + months * 30 + weeks * 7).toInt();
      int hours = (dur.inHours % 24).toInt();
      int minutes = (dur.inMinutes % 60).toInt();
      int seconds = (dur.inSeconds % 60).toInt();
      var diff = {
        "d": rdays,
        "w": weeks,
        "m": months,
        "y": years,
        "s": seconds,
        "i": minutes,
        "h": hours
      };

      Map str = {
        'y': 'year',
        'm': 'month',
        'w': 'week',
        'd': 'day',
        'h': 'hour',
        'i': 'minute',
        's': 'second',
      };

      str.forEach((k, v) {
        if (diff[k]! > 0) {
          str[k] = diff[k].toString() +
              ' ' +
              v.toString() +
              (diff[k]! > 1 ? 's' : '');
        } else {
          str[k] = "";
        }
      });
      str.removeWhere((index, ele) => ele == "");
      List<String> tlist = [];
      str.forEach((k, v) {
        tlist.add(v);
      });
      if (full) {
        return str.length > 0 ? tlist.join(", ") + "_ago".tr : "just_now".tr;
      } else {
        return str.length > 0 ? tlist[0] + "_ago".tr : "just_now".tr;
      }
    } else {
      return "";
    }
  }
}
