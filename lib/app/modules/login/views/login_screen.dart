import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/utils/Store/HiveStore.dart';
import 'dart:io' show Directory, Platform, exit;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../common/common_text_form_field.dart';
import '../../../../common/widgets/Loader.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../services/urls.dart';
import '../controller/login_controller.dart';
import 'package:http/http.dart' as http;
class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Image.asset(
                    ImageUtils.loginTop,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: ScreenConstant.screenHeightMoreThanHalf,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: ScreenConstant.screenHeightHalf,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CustomColor.secondaryBlue,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CustomColor.secondaryBlue.withOpacity(1),
                            // Lighter color for gradient
                            CustomColor.secondaryBlue,
                            // Same color as container for solid color
                          ],
                        ),
                      ),
                      child: FractionalTranslation(
                        translation: Offset(0.0, -1),
                        // Move the gradient up by 10%
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                CustomColor.secondaryBlue.withOpacity(0.03),
                                // Lighter color for gradient
                                CustomColor.secondaryBlue,
                                // Same color as container for solid color
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.welcomeToNuristar.tr,
                      style: TextStyles.titleWhite,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        UniversalButtonWidget(
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenConstant.screenWidthFifth),
                          ontap: () async {
                            try {
                              final user = await controller.loginWithGoogle();
                              Get.log("userrrrr>>>>>>>>>>>>>>>${user}");
                              Get.log("GoogleidTokenFinal${controller.googleIdToken.value}");
                              if (user != null) {
                                controller.login(controller.email.value,controller.googleIdToken.value,controller.profileImageUrl.value);
                              }
                            } on FirebaseAuthException catch (error) {
                              debugPrint(error.message);
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(
                              //         content: Text(
                              //   error.message ?? "Something went wrong",
                              // )));
                            } catch (error) {
                              print(error);
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(
                              //         content: Text(
                              //   error.toString(),
                              // )));
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          isRichText: true,
                          firstText: AppStrings.continueWith.tr,
                          secondText: AppStrings.Google.tr,
                          firstTextStyle: TextStyles.homeTabStyleSemiBold
                              .copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w300),
                          secondTextStyle: TextStyles.homeTabStyleSemiBold
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                          color: Colors.white,
                          prefixIcon: ImageUtils.googleIcon,
                          prefixIconHeight: ScreenConstant.smallIconSize,
                        ),
                        Container(
                          height: ScreenConstant.defaultHeightFifteen,
                        ),
                        UniversalButtonWidget(
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenConstant.screenWidthFifth),
                          ontap: () async {
                            print("Apple Signup");
                            final credential =
                            await SignInWithApple.getAppleIDCredential(
                              webAuthenticationOptions: WebAuthenticationOptions(
                                clientId: "",
                                redirectUri: Uri.parse(
                                "",
                              ),),
                              scopes: [
                                AppleIDAuthorizationScopes.email,
                                AppleIDAuthorizationScopes.fullName,
                              ],
                            );
                            if(credential.authorizationCode != null){
                              if(credential.email != null || credential.givenName != null || credential.familyName != null){
                                await HiveStore().setString(Keys.EMAIL, credential.email ?? "");
                                await HiveStore().setString(Keys.FIRSTNAME, credential.givenName ?? "");
                                await  HiveStore().setString(Keys.LASTNAME, credential.familyName ?? "");
                              }
                              controller.appleLogin(
                                credential.authorizationCode,
                                credential.identityToken,
                                credential.userIdentifier,
                                credential.givenName ?? await HiveStore().getString(Keys.FIRSTNAME),
                                credential.familyName ?? await HiveStore().getString(Keys.LASTNAME),
                                credential.email ?? await HiveStore().getString(Keys.EMAIL),
                              );
                            }
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
                          },
                          isRichText: true,
                          borderRadius: BorderRadius.circular(20),
                          prefixIconColor: CustomColor.white,
                          firstText: AppStrings.continueWith.tr,
                          secondText: AppStrings.Apple.tr,
                          firstTextStyle: TextStyles.homeTabStyleSemiBold
                              .copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: CustomColor.white),
                          secondTextStyle: TextStyles.homeTabStyleSemiBold
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: CustomColor.white),
                          color: Colors.black,
                          prefixIcon: ImageUtils.appleIcon,
                          prefixIconHeight: ScreenConstant.smallIconSize,
                        ),
                        Container(
                          height: ScreenConstant.defaultHeightSixty,
                        ),
                        Text(
                          AppStrings.pleaseReadOur.tr,
                          style: TextStyles.landingBottomText.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w300),
                        ),
                        Container(
                          height: ScreenConstant.defaultHeightTen,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  launchUrls(Uri.parse(AppStrings.termsUrl));
                                },
                                child: Text(
                                  AppStrings.termsOfService.tr,
                                  style: TextStyles.landingBottomUnderlinedText
                                      .copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                )),
                            Text(AppStrings.andLogo.tr,
                                style: TextStyles.landingBottomText.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )),
                            InkWell(
                                onTap: () {
                                  launchUrls(Uri.parse(AppStrings.privacyUrl));
                                },
                                child: Text(
                                  AppStrings.privacyPolicy.tr,
                                  style: TextStyles.landingBottomUnderlinedText
                                      .copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ))
                          ],
                        ),
                        Container(
                          height: ScreenConstant.defaultHeightForty,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              child: Loader(
                text: "",
              ),
              visible: controller.isLoading.value,
            )
          ],
        ),
      ),
    );
  }
}
