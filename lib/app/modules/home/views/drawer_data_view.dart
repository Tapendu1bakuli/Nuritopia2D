import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/universal_button_widget.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/Store/HiveStore.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../routes/routes.dart';
import '../controller/home_controller.dart';
import '../widgets/home_drawer_listtile_widget.dart';

class DrawerData extends StatelessWidget {
   DrawerData({Key? key}) : super(key: key);
HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    print("CurrentUser:${controller.userDetailsModel.email}");
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 48, 0, 12),
      child: Container(
        color: CustomColor.primaryBlue,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenConstant.defaultHeightTwentyThree,
                  bottom: ScreenConstant.defaultHeightTwentyThree,
                  left: ScreenConstant.defaultWidthTwenty),
              child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: CachedNetworkImage(
                        height: ScreenConstant.screenHeightTwelve,
                        width: ScreenConstant.screenWidthSixth,
                        fit: BoxFit.fill,
                        imageUrl:
                          HiveStore().get(Keys.PROFILEIMAGE) ?? AppStrings.loginBackgroundImageUrl,
                        placeholder: (context, url) => Image.asset(
                          ImageUtils.loadingImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline),
                      ),
                    ),
                    Container(
                      width: ScreenConstant.defaultWidthTen,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HiveStore().get(Keys.NEWUSER) == "0"? Text(
                          HiveStore().get(Keys.NICKNAME),
                          style: TextStyles.drawerTitleBold,
                          overflow: TextOverflow.ellipsis,
                        ):Offstage(),
                        SizedBox(height: ScreenConstant.defaultHeightFour),
                        HiveStore().get(Keys.NEWUSER) == "1"?Text(
                          HiveStore().get(Keys.EMAIL),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.drawerSubTitleBold,
                        ):Offstage(),
                      ],
                    )
                  ],
                ),

            ),
            Obx(()=> ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.drawerListModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HomeDrawerListTileWidget(
                        leadingImage: controller.drawerListModel[index].icon,
                        titleText: controller.drawerListModel[index].title,
                        titleTextStyles: TextStyles.drawerSubTitleBold,
                        onTap: () {
                          controller.drawerListModel.forEach(
                                  (element) => element.isColoured = false);
                          debugPrint("index:$index");
                          controller.drawerListModel[index].isColoured =
                          !controller
                              .drawerListModel[index].isColoured!;
                          controller.drawerListModel.refresh();
                          controller.drawerListModel[index].ontap!();
                        },
                        isColoured: controller.drawerListModel[index].isColoured,
                        leadingImageHeight:
                            ScreenConstant.defaultHeightTwentyThree);
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenConstant.screenHeightSixth,
                  horizontal: ScreenConstant.defaultWidthTwenty),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: UniversalButtonWidget(
                      borderColor: CustomColor.white,
                      borderRadius: BorderRadius.circular(15),
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.defaultWidthTen,
                          vertical: ScreenConstant.defaultHeightTwentyThree),
                      ontap: () {
                        showAlertDialogForLogOut();
                      },
                      leadingIconvisible: true,
                      title: AppStrings.logout.tr,
                      titleTextStyle: TextStyles.textStyleRegular
                          .apply(color: CustomColor.primaryBlue),
                      color: CustomColor.white,
                    ),
                  ),
                  Expanded(flex: 3, child: Container())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  showAlertDialogForLogOut() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Builder(
          builder: (context) {
            return Container(
              height: ScreenConstant.screenHeightThird,
              width: MediaQuery.of(context).size.width-80,
              padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightTen,horizontal: ScreenConstant.defaultWidthThirty),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageUtils.deleteIcon,color: Colors.red,
                    height: ScreenConstant.defaultHeightFifty,
                    width: ScreenConstant.defaultWidthFifty,
                  ),
                  Container(height: ScreenConstant.defaultHeightFifteen,),
                  Text(AppStrings.logout,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 20,fontWeight: FontWeight.w500),),
                  Container(height: ScreenConstant.defaultHeightFifteen,),
                  Text(AppStrings.areYouSure,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 18,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                  Container(height: ScreenConstant.defaultHeightTen,),
                 Obx(()=> controller.isLoading.value?const CircularProgressIndicator(color: CustomColor.primaryBlue,): Row(
                      children: [
                        Expanded(flex:5,
                            child:  UniversalButtonWidget(
                              ontap: (){
                                Get.back();
                              },
                              color: CustomColor.alertDialogButton,
                              margin: EdgeInsets.symmetric(
                                vertical: ScreenConstant.defaultHeightTen,
                                horizontal: ScreenConstant.defaultWidthTwenty,
                              ),
                              leadingIconvisible: true,
                              borderRadius: BorderRadius.circular(20),
                              title: AppStrings.cancel.tr,
                              titleTextStyle: TextStyles.textStyleRegular
                                  .apply(color: CustomColor.white),
                            )),
                        Expanded(flex:5,
                            child:  UniversalButtonWidget(
                              ontap: (){
                                controller.logout();
                                //controller.toggleAnimation();
                              },
                              color: CustomColor.primaryBlue,
                              margin: EdgeInsets.symmetric(
                                vertical: ScreenConstant.defaultHeightFifteen,
                                horizontal: ScreenConstant.defaultWidthTwenty,
                              ),
                              leadingIconvisible: true,
                              borderRadius: BorderRadius.circular(20),
                              title: AppStrings.yes.tr,
                              titleTextStyle: TextStyles.textStyleRegular
                                  .apply(color: CustomColor.white),
                            ))
                      ],
                    ),
                 )

                ],
              ),
            );
          },
        ),
      ),
    );
  }
  showAlertDialogForDeleteAccount() {
    Get.dialog(
      AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Builder(
          builder: (context) {
            return Container(
              height: ScreenConstant.screenHeightHalfPointFive,
              width: MediaQuery.of(context).size.width-50,
              padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightTwentyThree,horizontal: ScreenConstant.defaultWidthThirty),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageUtils.deleteIcon,color: Colors.red,
                    height: ScreenConstant.defaultHeightFifty,
                    width: ScreenConstant.defaultWidthFifty,
                  ),
                  Container(height: ScreenConstant.defaultHeightFifteen,),
                  Text(AppStrings.deleteAccount,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 20,fontWeight: FontWeight.w500),),
                  Container(height: ScreenConstant.defaultHeightFifteen,),
                  Text(AppStrings.deleteAccountMessage,style: TextStyles.homeTabSecondCardSubTitleStyleBold.copyWith(fontSize: 18,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                  Container(height: ScreenConstant.defaultHeightFifteen,),
                  Row(
                    children: [
                      Expanded(flex:5,
                          child:  UniversalButtonWidget(
                            ontap: (){
                              Get.back();
                            },
                            color: CustomColor.alertDialogButton,
                            margin: EdgeInsets.symmetric(
                              vertical: ScreenConstant.defaultHeightFifteen,
                              horizontal: ScreenConstant.defaultWidthTwenty,
                            ),
                            leadingIconvisible: true,
                            borderRadius: BorderRadius.circular(20),
                            title: AppStrings.cancel.tr,
                            titleTextStyle: TextStyles.textStyleRegular
                                .apply(color: CustomColor.white),
                          )),
                      Expanded(flex:5,
                          child:  UniversalButtonWidget(
                            ontap: (){
                              controller.deleteAccount();
                            },
                            color: CustomColor.primaryBlue,
                            margin: EdgeInsets.symmetric(
                              vertical: ScreenConstant.defaultHeightFifteen,
                              horizontal: ScreenConstant.defaultWidthTwenty,
                            ),
                            leadingIconvisible: true,
                            borderRadius: BorderRadius.circular(20),
                            title: AppStrings.confirm.tr,
                            titleTextStyle: TextStyles.textStyleRegular
                                .apply(color: CustomColor.primaryBlack),
                          ))
                    ],
                  )

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
