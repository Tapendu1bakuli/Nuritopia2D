import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/ui.dart';
import '../models/address_model.dart';
import '../models/setting_model.dart';
import '../repositories/setting_repository.dart';
import 'auth_service.dart';
import 'global_service.dart';

class SettingsService extends GetxService {
  final setting = Setting().obs;
  final address = Address().obs;
  final RxInt appVersion = 0.obs;

  late GetStorage _box;

  late SettingRepository _settingsRepo;

  SettingsService() {
    _settingsRepo = new SettingRepository();
    _box = new GetStorage();
  }

  Future<SettingsService> init() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //appVersion.value = int.tryParse(packageInfo.version.replaceAll(".", ""))!;
    address.listen((Address _address) {
      _box.write('current_address', _address.toJson());
    });
    setting.value = await _settingsRepo.get();
    checkVersionService();
    // await getAddress();
    return this;
  }

  ThemeData getLightTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        dividerColor: Ui.parseColor(setting.value.accentColor!, opacity: 0.1),
        focusColor: Ui.parseColor(setting.value.accentColor!),
        hintColor: Ui.parseColor(setting.value.secondColor!),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Ui.parseColor(setting.value.mainColor!)),
        ),
        colorScheme: ColorScheme.light(
          primary: Ui.parseColor(setting.value.mainColor!),
          secondary: Ui.parseColor(setting.value.mainColor!),
        ),
        textTheme: GoogleFonts.getTextTheme(
          _getLocale().startsWith('ar') ? 'Cairo' : 'Poppins',
          TextTheme(
            titleLarge: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: Ui.parseColor(setting.value.mainColor!),
                height: 1.2),
            headlineSmall: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Ui.parseColor(setting.value.secondColor!),
                height: 1.2),
            headlineMedium: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Ui.parseColor(setting.value.secondColor!),
                height: 1.3),
            displaySmall: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Ui.parseColor(setting.value.secondColor!),
                height: 1.3),
            displayMedium: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: Ui.parseColor(setting.value.mainColor!),
                height: 1.4),
            displayLarge: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
                color: Ui.parseColor(setting.value.secondColor!),
                height: 1.4),
            titleSmall: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Ui.parseColor(setting.value.secondColor!),
                height: 1.2),
            titleMedium: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: Ui.parseColor(setting.value.mainColor!),
                height: 1.2),
            bodyMedium: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: Ui.parseColor(setting.value.secondColor!),
                height: 1.2),
            bodyLarge: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Ui.parseColor(setting.value.secondColor!),
                height: 1.2),
            bodySmall: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                color: Ui.parseColor(setting.value.accentColor!),
                height: 1.2),
          ),
        ));
  }

  ThemeData getDarkTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Color(0xFF252525),
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0),
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        brightness: Brightness.dark,
        dividerColor:
            Ui.parseColor(setting.value.accentDarkColor!, opacity: 0.1),
        focusColor: Ui.parseColor(setting.value.accentDarkColor!),
        hintColor: Ui.parseColor(setting.value.secondDarkColor!),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Ui.parseColor(setting.value.mainColor!)),
        ),
        colorScheme: ColorScheme.dark(
          primary: Ui.parseColor(setting.value.mainDarkColor!),
          secondary: Ui.parseColor(setting.value.mainDarkColor!),
        ),
        textTheme: GoogleFonts.getTextTheme(
            _getLocale().startsWith('ar') ? 'Cairo' : 'Poppins',
            TextTheme(
              titleLarge: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: Ui.parseColor(setting.value.mainDarkColor!),
                  height: 1.2),
              headlineSmall: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Ui.parseColor(setting.value.secondDarkColor!),
                  height: 1.2),
              headlineMedium: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Ui.parseColor(setting.value.secondDarkColor!),
                  height: 1.3),
              displaySmall: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Ui.parseColor(setting.value.secondDarkColor!),
                  height: 1.3),
              displayMedium: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: Ui.parseColor(setting.value.mainDarkColor!),
                  height: 1.4),
              displayLarge: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w300,
                  color: Ui.parseColor(setting.value.secondDarkColor!),
                  height: 1.4),
              titleSmall: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Ui.parseColor(setting.value.secondDarkColor!),
                  height: 1.2),
              titleMedium: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: Ui.parseColor(setting.value.mainDarkColor!),
                  height: 1.2),
              bodyMedium: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Ui.parseColor(setting.value.secondDarkColor!),
                  height: 1.2),
              bodyLarge: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Ui.parseColor(setting.value.secondDarkColor!),
                  height: 1.2),
              bodySmall: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                  color: Ui.parseColor(setting.value.accentDarkColor!),
                  height: 1.2),
            )), checkboxTheme: CheckboxThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return Ui.parseColor(setting.value.mainDarkColor!); }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return Ui.parseColor(setting.value.mainDarkColor!); }
 return null;
 }),
 ), switchTheme: SwitchThemeData(
 thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return Ui.parseColor(setting.value.mainDarkColor!); }
 return null;
 }),
 trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return Ui.parseColor(setting.value.mainDarkColor!); }
 return null;
 }),
 ));
  }

  String _getLocale() {
    String _locale = GetStorage().read<String>('language')!;
    if (_locale.isEmpty) {
      _locale = setting.value.mobileLanguage!;
    }
    return _locale;
  }

  ThemeMode getThemeMode() {
    String _themeMode = GetStorage().read<String>('theme_mode') ?? "";
    switch (_themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: Colors.white),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark
              .copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        if (setting.value.defaultTheme == "dark") {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.dark
                .copyWith(systemNavigationBarColor: Colors.black87),
          );
          return ThemeMode.dark;
        } else {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light
                .copyWith(systemNavigationBarColor: Colors.white),
          );
          return ThemeMode.light;
        }
    }
  }

  // Future getAddress() async {
  //   try {
  //     if (_box.hasData('current_address')) {
  //       address.value = Address.fromJson(await _box.read('current_address'));
  //     } else if (Get.find<AuthService>().isAuth) {
  //       List<Address> _addresses = await _settingsRepo.getAddresses();
  //       if (_addresses.isNotEmpty) {
  //         address.value = _addresses
  //             .firstWhere((_address) => _address.isDefault!, orElse: () {
  //           return _addresses.first;
  //         });
  //       } else {
  //         address.value = new Address(address: "please_choose_your_address".tr);
  //       }
  //     } else {
  //       address.value = new Address(address: "please_choose_your_address".tr);
  //     }
  //   } catch (e) {
  //     Get.log(e.toString());
  //   }
  // }

  void checkVersionService() {
    if (int.tryParse(setting.value.appVersion!.replaceAll(".", ""))! <
        appVersion.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.defaultDialog(
          title: "update_title".tr,
          barrierDismissible: false,
          middleText: "update_message".tr,
          titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          textConfirm: "update_now".tr,
          onConfirm: () {
            if (Platform.isIOS) {
              launch(Get.find<GlobalService>().iosAppLink);
            }
            if (Platform.isAndroid) {
              launch(Get.find<GlobalService>().androidAppLink);
            }
          },
        );
      });
    }
  }
}
