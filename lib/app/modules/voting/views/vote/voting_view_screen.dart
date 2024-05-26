import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/voting/views/vote/voting_dance_view.dart';
import 'package:nuritopia2d/app/modules/voting/views/vote/voting_rap_view.dart';
import '../../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../home/widgets/common_appbar_action_connect_widget.dart';
import '../../controller/voting_controller.dart';


class VotingViewScreen extends StatelessWidget {
   VotingViewScreen({Key? key}) : super(key: key);
  VotingController votingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        backgroundColor: CustomColor.fillOffWhiteColor,
        appBar: CommonAppbarWidget(
          actionWidgets: [CommonAppBarConnectWidget()],
          isActionPresent: true,
          backgroundColor: CustomColor.fillOffWhiteColor,
          titleTextStyle: TextStyles.appbarSmallTitleStyleBold,
          title: "BEAT : ${votingController.beatName.value}",
          leadingOnTap: () {
            Get.back();
          },
          isLeadingPresent: true,
          leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
          leadingWidgetSize: ScreenConstant.smallIconSize,
        ),
        body: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthTwenty,vertical: ScreenConstant.defaultHeightTen),
                      height: ScreenConstant.defaultHeightForty,
                      decoration: BoxDecoration(
                        color: CustomColor.white,
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors.transparent; // Color when tab is selected
                          }
                          return Colors.transparent; // Color when tab is not selected
                        }),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          color: CustomColor.primaryBlue,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        isScrollable: false,
                        // indicatorColor: Colors.black,
                        // labelPadding: EdgeInsets.symmetric(
                        //     horizontal: 50, vertical: 5),
                        labelStyle: TextStyles.tabSelectedStyleSemiBold,
                        labelColor: CustomColor.white,
                        unselectedLabelColor: CustomColor.homeGrey,
                        tabs: [
                          Text(AppStrings.dance.tr,),
                          Text(AppStrings.sing.tr)
                        ],
                      ),
                    ),
                    const Expanded(
                        child: TabBarView(
                          children: [
                            VotingDanceView(),
                            VotingRapView()
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  // Future modalBottomSheetMenu(BuildContext context,String? name) async {
  //   await showModalBottomSheet(
  //       backgroundColor: CustomColor.fillOffWhiteColor,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(25.0),
  //         ),
  //       ),
  //       context: context,
  //       builder: (builder) {
  //         return Container(
  //           height: ScreenConstant.screenHeightThird,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.vertical(
  //               top: Radius.circular(25.0),
  //             ),
  //           ),
  //           child: Center(
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 28.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     height: ScreenConstant.defaultHeightTwentyThree,
  //                   ),
  //                   Text("${AppStrings.voteFor.tr}$name",style: TextStyles.drawerSubTitleBold.copyWith(color: CustomColor.primaryBlack),),
  //                   Container(
  //                     height: ScreenConstant.defaultHeightTen,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(24.0),
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                           color: CustomColor.white,
  //                           borderRadius: BorderRadius.circular(15)),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               IconButton(
  //                                   splashRadius: 1,
  //                                   onPressed: (){
  //                                     // controller.negotiationPriceSetting(
  //                                     //     controller.minimumPrice.value,
  //                                     //     controller.originalPrice.value,
  //                                     //     controller.maximumPrice.value,
  //                                     //     false);
  //                                   },
  //                                   icon: Icon(
  //                                     Icons.remove,
  //                                     size: 30,
  //                                   )),
  //                             ],
  //                           ),
  //                           DropdownButton(
  //                             iconSize: 0.0,
  //                             underline: SizedBox.shrink(),
  //                             alignment: Alignment.center,
  //                             style: TextStyles.textStyleRegular.apply(
  //                                 color: Colors.black, fontSizeFactor: 1.7),
  //                             hint:Text("${controller.originalPrice}",style: TextStyles.drawerSubTitleBold.copyWith(color: CustomColor.primaryBlack),),
  //                             items: <double>[
  //                               1000.00,
  //                               2000.00,
  //                               3000.00,
  //                               5000.00,
  //                             ].map(
  //                                   (val) {
  //                                 return DropdownMenuItem<double>(
  //                                   value: val,
  //                                   child: Text(
  //                                     "$val",
  //                                     style: TextStyles.drawerSubTitleBold.copyWith(color: CustomColor.primaryBlack),
  //                                   ),
  //                                 );
  //                               },
  //                             ).toList(),
  //                             onChanged: (double? val) {
  //                               controller.originalPrice.value =
  //                               val!;
  //                               // controller.usd.value = int.parse(val);
  //                               // (int.parse(val.toString().replaceAll(" TOS", "")) /
  //                               //     controller.tosToken.value)
  //                               //     .ceil();
  //                             },
  //                           ),
  //                           Row(
  //                             children: [
  //                               IconButton(
  //                                   splashRadius: 1,
  //                                   onPressed: (){
  //                                     controller.negotiationPriceSetting(
  //                                         controller.minimumPrice.value,
  //                                         controller.originalPrice.value,
  //                                         controller.maximumPrice.value,
  //                                         true);
  //                                   },
  //                                   icon: Icon(
  //                                     Icons.add,
  //                                     size: 30,
  //                                   )),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Row(
  //                     children: [
  //                       Text("1 Vote ="),
  //                       Container(
  //                         width: ScreenConstant.defaultWidthTen,
  //                       ),
  //                       redHeartCurrency("1",ImageUtils.whiteHeartImage,TextStyles.drawerSubTitleBold.copyWith(color: CustomColor.primaryBlack),),
  //                     ],
  //                   ),
  //                   UniversalButtonWidget(
  //                     ontap: (){
  //                       Get.back();
  //                       Get.toNamed(Routes.VOTESUBMITTEDSUCCESSFULL);
  //                     },
  //                     color: CustomColor.primaryBlue,
  //                     margin: EdgeInsets.symmetric(
  //                       vertical: ScreenConstant.defaultHeightFifteen,
  //                       horizontal: ScreenConstant.defaultWidthTwenty,
  //                     ),
  //                     leadingIconvisible: true,
  //                     title: AppStrings.vote.tr,
  //                     titleTextStyle: TextStyles.textStyleRegular
  //                         .apply(color: CustomColor.white),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         );
  //       });
  //   // return choosedImage;
  // }
}
