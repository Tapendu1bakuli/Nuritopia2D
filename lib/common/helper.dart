import 'dart:convert' as convert;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../app/services/settings_service.dart';
import 'ui.dart';
import 'package:intl/intl.dart';

class Helper {
  DateTime? currentBackPressTime;

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String toApiUrl(String path) {
    path = toUrl(path);
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(Ui.defaultSnackBar(message: "tap_again_to_leave".tr));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
  static PhoneNumber getPhoneNumberFromCompleteNumber(String phoneNumber) {
    String? dialCode1;
    String? dialCode2;
    String? dialCode3;
    try{
      phoneNumber = phoneNumber.replaceAll(' ', '');
      dialCode1 = phoneNumber.substring(1, 2);
      dialCode2 = phoneNumber.substring(1, 3);
      dialCode3 = phoneNumber.substring(1, 4);
    }catch(e){
      print("ERROR: $e");
    }
    for (int i = 0; i < countries.length; i++) {
      if (countries[i].dialCode == dialCode1) {
        return PhoneNumber(
            countryISOCode: countries[i].code,
            countryCode: dialCode1!,
            number: phoneNumber.substring(2));
      } else if (countries[i].dialCode == dialCode2) {
        return PhoneNumber(
            countryISOCode: countries[i].code,
            countryCode: dialCode2!,
            number: phoneNumber.substring(3));
      } else if (countries[i].dialCode == dialCode3) {
        return PhoneNumber(
            countryISOCode: countries[i].code,
            countryCode: dialCode3!,
            number: phoneNumber.substring(4));
      }
    }
    return PhoneNumber(
        countryISOCode:
        Get.find<SettingsService>().setting.value.defaultCountryCode!,
        countryCode: Get.find<SettingsService>().setting.value.defaultCountryCode!,
        number: '');
  }
  String convert12HourTo24Hour(String? inputTime) {
    if(inputTime != null || inputTime!.isNotEmpty){
      String amOrPm = inputTime.split(" ").last;
      String leftEnd = inputTime.split(":").first.padLeft(2, "0");
      String rightEnd = inputTime.split(":").last.padLeft(2, "0");
      // Define a 12-hour time format
      final inputFormat = DateFormat("hh:mm a");

      // Define a 24-hour time format
      final outputFormat = DateFormat("HH:mm");

      try {
        // Parse the input time using the 12-hour format
        final dateTime = inputFormat.parse("$leftEnd:$rightEnd $amOrPm");

        // Format the parsed time using the 24-hour format
        final outputTime = outputFormat.format(dateTime);

        return outputTime;
      } catch (e) {
        // Handle parsing errors if necessary
        print("Error parsing the time: $e");
        return "00:00"; // Return an empty string or an error message
      }
    }else{
      return "00:00";
    }
  }


}
