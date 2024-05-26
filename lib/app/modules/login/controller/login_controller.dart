import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuritopia2d/app/modules/login/controller/theme_mode_controller.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../common/common_text_form_field.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/Store/HiveStore.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../models/GoogleLoginSendModel.dart';
import '../../../models/header_model.dart';
import '../../../models/login_model.dart';
import '../../../routes/routes.dart';
import '../../../services/core_service.dart';
import '../../../services/firebase_messaging_service.dart';
import '../../../services/urls.dart';
import '../../network_checker/controller/network_checker_controller.dart';
import 'dart:io' show Directory, Platform, exit;
class LoginController extends GetxController{
  final CommonNetWorkStatusCheckerController netWorkStatusChecker =
  Get.put(CommonNetWorkStatusCheckerController());
  ThemeModeController themeModeController = Get.put(ThemeModeController());
  TextEditingController referralText = TextEditingController();
  LoginModel loginModel = LoginModel();
  @override
  void onInit() async{
    netWorkStatusChecker.updateConnectionStatus();
    // Get called when controller is created
    super.onInit();
    print("Hello World");
   await Get.putAsync(() => FireBaseMessagingService().init());
  }

  @override
  void onReady() {
    print("Hello Love");
    // Get called after widget is rendered on the screen
    super.onReady();
  }

  @override
  void onClose() {
    //Get called when controller is removed from memory
    super.onClose();
  }
  static User? user = FirebaseAuth.instance.currentUser;
  var googleIdTokenForBackend = "".obs;
  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;
  RxString deviceType = "1".obs;
  RxString deviceId = "".obs;
  RxString email = "".obs;
  RxString googleIdToken = "".obs;
  RxString profileImageUrl = "".obs;

  Future<String?> _getId() async {
    if (Platform.isAndroid) {
      HiveStore().setString(Keys.DEVICETYPE, "1");
    } else if (Platform.isIOS) {
      HiveStore().setString(Keys.DEVICETYPE, "2");
    }
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  //Login with Google
  Future<User?> loginWithGoogle() async {
    try {
      if( Platform.isAndroid){
        final googleAccount = await GoogleSignIn(serverClientId:
        '',scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],).signIn();
        Get.log("googleAccount.email: ${googleAccount?.email}");
        Get.log("googleAccount.id: ${googleAccount?.id}");
        Get.log("googleAccount.serverAuthCode: ${googleAccount?.serverAuthCode}");


        final googleAuth = await googleAccount?.authentication;


        Get.log("googleAuth.accessToken: ${googleAuth?.accessToken}");
        Get.log("googleAuth.idToken: ${googleAuth?.idToken}");

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );


        Get.log("credential.serverAuthCode: ${credential.serverAuthCode}");
        Get.log("credential.signInMethod: ${credential.secret}");
        Get.log("credential.credentialtoken: ${credential.token}");
        Get.log("credential.credentialtoken: ${credential.providerId}");
        Get.log("credential.credentialtoken: ${credential.accessToken}");


        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
        googleIdTokenForBackend.value = credential.idToken ?? "";
        googleIdToken.value = credential.idToken??"";
        Get.log("userCredentialId:- ${googleIdTokenForBackend.value}");

        email.value = userCredential.additionalUserInfo?.profile?["email"];
        profileImageUrl.value = userCredential.additionalUserInfo?.profile?["picture"];

        Get.log("userCredential.providerId: ${userCredential.credential?.providerId}");
        Get.log("userCredential.signInMethod: ${userCredential.credential?.signInMethod}");
        Get.log("userCredential.token: ${userCredential.credential?.token}");
        debugPrint("userCredential:- ${credential.accessToken}");
        debugPrint("userCredential:- ${userCredential.additionalUserInfo?.profile?["email"]}");
        debugPrint("userCredential:- ${userCredential.additionalUserInfo?.profile?["picture"]}");
        debugPrint("userCredential:- ${credential.accessToken??""}");

        List<String> value = googleIdTokenForBackend.value.split('.');
        googleIdTokenForBackend.value = credential.idToken ?? "";

        return userCredential.user;
      }else if(Platform.isIOS){
      final googleAccount = await GoogleSignIn(serverClientId:
      '',scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],).signIn();
      Get.log("googleAccount.email: ${googleAccount?.email}");
      Get.log("googleAccount.id: ${googleAccount?.id}");
      Get.log("googleAccount.serverAuthCode: ${googleAccount?.serverAuthCode}");


      final googleAuth = await googleAccount?.authentication;


      Get.log("googleAuth.accessToken: ${googleAuth?.accessToken}");
      Get.log("googleAuth.idToken: ${googleAuth?.idToken}");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );


      Get.log("credential.serverAuthCode: ${credential.serverAuthCode}");
      Get.log("credential.signInMethod: ${credential.secret}");
      Get.log("credential.credentialtoken: ${credential.token}");
      Get.log("credential.credentialtoken: ${credential.providerId}");
      Get.log("credential.credentialtoken: ${credential.accessToken}");


      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      googleIdTokenForBackend.value = credential.idToken ?? "";
      googleIdToken.value = credential.idToken??"";
      Get.log("userCredentialId:- ${googleIdTokenForBackend.value}");

      email.value = userCredential.additionalUserInfo?.profile?["email"];
      profileImageUrl.value = userCredential.additionalUserInfo?.profile?["picture"];

      Get.log("userCredential.providerId: ${userCredential.credential?.providerId}");
      Get.log("userCredential.signInMethod: ${userCredential.credential?.signInMethod}");
      Get.log("userCredential.token: ${userCredential.credential?.token}");
      debugPrint("userCredential:- ${credential.accessToken}");
      debugPrint("userCredential:- ${userCredential.additionalUserInfo?.profile?["email"]}");
      debugPrint("userCredential:- ${userCredential.additionalUserInfo?.profile?["picture"]}");
      debugPrint("userCredential:- ${credential.accessToken??""}");

      List<String> value = googleIdTokenForBackend.value.split('.');
      googleIdTokenForBackend.value = credential.idToken ?? "";

      return userCredential.user;
      }



    } catch (error) {
        final bool canceled =
            error is PlatformException && error.code == 'sign_in_canceled';
        if (!canceled) {
          print(error);
        }
      }
      return null;
  }

  loginWithApple() async {
    //https://nuritopia2d.firebaseapp.com/__/auth/handler
    final credential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    debugPrint("$credential");
    debugPrint(
        "credential.authorizationCode  ${credential.authorizationCode}");
    debugPrint(
        "credential.identityToken  ${credential.identityToken}");
    debugPrint(
        "credential.userIdentifier  ${credential.userIdentifier}");
    debugPrint("credential.email ${credential.email}");
    debugPrint(
        "credential.givenName ${credential.givenName}");
    debugPrint(
        "credential.familyName ${credential.familyName}");
  }

  //Login
  Future login(String? email,String? googleIdToken,String? profileImage) async {
    isLoading.value = true;
       await logInApiCall(email,googleIdToken,profileImage).then((result) async {
         Get.log("googleResponse>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${result["data"]}");
           if (result["status"] == "Success") {
              loginModel = LoginModel.fromJson(result["data"]);
              HiveStore().put(Keys.AUTHORIZATIONTOKEN, "Bearer ${result["data"]["access_token"]}");
              HiveStore().put(Keys.NURITOPIAAUTHORIZATIONTOKEN, "Bearer ${result["data"]["nuritopiaAuthorizationToken"]}");
              HiveStore().put(Keys.NEWUSER, "${result["data"]["newUser"]}");
              HiveStore().put(Keys.EMAIL, "${result["data"]["email"]}");
              HiveStore().put(Keys.PROFILEIMAGE, "${result["data"]["profileImage"][0]}");
              HiveStore().put(Keys.PROFILEIMAGEARRAY, "${jsonEncode(result["data"]["profileImage"])}");
              HiveStore().put(Keys.FIRSTTIMELOGIN, "yes");
              HiveStore().put(Keys.NICKNAME, "${result["data"]["nickName"]}");
              HiveStore().put(Keys.OPENREFERRALCODE, result["data"]["hasRefer"] == false ? "yes" : "no");
              showSuccessSnackBar(
                 "Success", result["message"] ?? "Login Success");
              HiveStore().getString(Keys.NEWUSER) == "1"?Get.offAllNamed(Routes.EDITPROFILE):
             Get.offAndToNamed(Routes.HOME);
             isLoading.value = false;
           } else {
             showFailureSnackBar(
                 "Failed", result["message"] ?? "Login Failed");
             isLoading.value = false;
           }
       });
    isLoading.value = false;
  }

  //Login API call
  logInApiCall(String? email,String? googleIdToken,String? profileImage) async {
    Get.log("GoogleID:$googleIdToken");
    var result = await CoreService().apiService(
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
     commonPoint: Urls.APIV2,
     body: {
        "email" : email,
       "googleIdToken" : googleIdToken,
       "profileImage" : profileImage,
       "fcmToken": await HiveStore().getString(Keys.FCMTOKEN),
       "deviceType" : Platform.isAndroid?"1":"2",
       "deviceId" : await _getId()
     },
      method: METHOD.POST,
      endpoint: Urls.googleLogin,
    );
    return result;
  }

  //Login with apple token
  Future appleLogin(String? appleAuthorizationCode,String? appleIdentityToken,String? appleUserIdentifier,String? appleGivenName,String? appleFamilyName,String? email) async {
    isLoading.value = true;
    await appleLoginApiCall(appleAuthorizationCode,appleIdentityToken,appleUserIdentifier,appleGivenName,appleFamilyName,email).then((result) async {
      // Get.log("appleResponse${result}");
      Get.log("appleResponse>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${result["data"]}");
      if (result["status"] == "Success") {
        loginModel = LoginModel.fromJson(result["data"]);
        HiveStore().put(Keys.AUTHORIZATIONTOKEN, "Bearer ${result["data"]["access_token"]}");
        HiveStore().put(Keys.NURITOPIAAUTHORIZATIONTOKEN, "Bearer ${result["data"]["nuritopiaAuthorizationToken"]}");
        HiveStore().put(Keys.NEWUSER, "${result["data"]["newUser"]}");
        HiveStore().put(Keys.EMAIL, "${result["data"]["email"]}");
        HiveStore().put(Keys.PROFILEIMAGE, "${result["data"]["profileImage"][0]}");
        HiveStore().put(Keys.PROFILEIMAGEARRAY, "${jsonEncode(result["data"]["profileImage"])}");
        HiveStore().put(Keys.FIRSTTIMELOGIN, "yes");
        HiveStore().put(Keys.NICKNAME, "${result["data"]["nickName"]}");
        HiveStore().put(Keys.OPENREFERRALCODE, result["data"]["hasRefer"] == false ? "yes" : "no");
        print("NURITOPIAAUTHORIZATIONTOKEN:${HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN)}");
        showSuccessSnackBar(
            "Success", result["message"] ?? "Login Success");
        Get.offAndToNamed(Routes.HOME);
        isLoading.value = false;
      } else {
        showFailureSnackBar(
            "Failed", result["message"] ?? "Please try logging in again.");
        isLoading.value = false;
      }
    });
    isLoading.value = false;
  }

  //Login API call
  appleLoginApiCall(String? appleAuthorizationCode,String? appleIdentityToken,String? appleUserIdentifier,String? appleGivenName,String? appleFamilyName,String? email) async {
    var result = await CoreService().apiService(
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      commonPoint: Urls.APIV2,
      body: {
        "appleAuthorizationCode" : appleAuthorizationCode,
        "appleIdentityToken" : appleIdentityToken,
        "appleUserIdentifier" : appleUserIdentifier,
        "appleGivenName" : appleGivenName,
        "appleFamilyName" : appleFamilyName,
        "email" : email,
        "fcmToken": await HiveStore().getString(Keys.FCMTOKEN),
        "deviceId" : await _getId(),
        "deviceType" : await HiveStore().getString(Keys.DEVICETYPE),
      },
      method: METHOD.POST,
      endpoint: Urls.appleLogin,
    );
    return result;
  }
}