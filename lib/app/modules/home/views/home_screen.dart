import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/Loader.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../routes/routes.dart';
import '../controller/home_controller.dart';
import '../widgets/carousal_image_widget.dart';
import '../widgets/common_appbar_action_connect_widget.dart';
import '../widgets/home_bottom_container_widget.dart';
import '../widgets/home_card_widgets.dart';
import 'drawer_data_view.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rightSlide = MediaQuery
        .of(context)
        .size
        .width * 0.6;
   return
        Obx(()=> Stack(
                children: [
          AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, child) {
                double slide = rightSlide * controller.animationController.value +
                    ScreenConstant.defaultHeightFifteen;
                double scale = 1.1 - (controller.animationController.value * 0.3);
                return Stack(
                  children: [
                    PopScope(
                      canPop: false,
                      onPopInvoked: (didPop) {
                        onWillPop();
                      },
                      child:  Scaffold(
                        backgroundColor: CustomColor.primaryBlue,
                        body: DrawerData(),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.identity()
                        ..translate(slide)
                        ..scale(scale),
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: ScreenConstant.defaultWidthThirty),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: CustomColor.secondaryBlue,
                              spreadRadius: 30,
                              blurRadius: 50,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Scaffold(
                          backgroundColor: CustomColor.white,
                          body: ListView(
                            children: [
                              Container(height: ScreenConstant
                                  .defaultHeightTwentyThree,),
                              AppBar(
                                scrolledUnderElevation: 0.0,
                                backgroundColor: CustomColor.white,
                                centerTitle: false,
                                leading: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenConstant.defaultWidthTen),
                                  child: IconButton(
                                    onPressed: () => controller.toggleAnimation(),
                                    icon: AnimatedIcon(
                                      icon: AnimatedIcons.menu_close,
                                      progress: controller.animationController,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  AppStrings.home.tr,
                                  // AppString.beat + beatName,
                                  style: TextStyles.textStyleSemiBold.apply(
                                      fontSizeFactor: 1.34,
                                      color: CustomColor.homeGrey),
                                ),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: CommonAppBarConnectWidget(),
                                  )
                                ],
                                iconTheme:
                                const IconThemeData(
                                    color: CustomColor.secondaryBlack),
                                leadingWidth: ScreenConstant.defaultWidthForty,
                              ),
                              Stack(
                                children: [
                                  CarouselSlider(
                                    items: controller.sliders
                                        .map((item) =>
                                        CarousalImageWidget(
                                          image: item.imagePath,
                                          onTapString: item.url,
                                        ))
                                        .toList(),
                                    carouselController:
                                    controller.homeCarousalController,
                                    options: CarouselOptions(
                                      onPageChanged: (int index,
                                          CarouselPageChangedReason reason) {
                                        controller.currentIndex.value = index;
                                      },
                                      autoPlay: true,
                                      enlargeCenterPage: false,
                                      viewportFraction: 1,
                                    ),
                                  ),
                                  Obx(() =>
                                      Positioned(
                                        bottom: ScreenConstant
                                            .defaultHeightFifteen,
                                        right: ScreenConstant.screenWidthFifth,
                                        left: ScreenConstant.screenWidthFifth,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: List.generate(
                                            controller.sliders.length,
                                                (index) =>
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      3.0),
                                                  child: Container(
                                                    width: ScreenConstant
                                                        .defaultWidthTen,
                                                    height:
                                                    ScreenConstant
                                                        .defaultHeightFour,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(10),
                                                        color:
                                                        controller.currentIndex
                                                            .value ==
                                                            index
                                                            ? CustomColor.white
                                                            : CustomColor
                                                            .primaryBlue),
                                                  ),
                                                ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenConstant.sizeSmallHighest),
                                child: Text(AppStrings.challenge.tr,
                                    style: TextStyles.homeTabStyleSemiBold),
                              ),
                              Container(
                                height: ScreenConstant.defaultHeightTen,
                              ),
                              HomeCardWidget(
                                onTap: () {
                                  //Get.toNamed(Routes.TAKECHALLENGE);
                                  Get.toNamed(Routes.INSTRUCTIONVIEW);
                                },
                                title: AppStrings.take.tr,
                                subTitle: AppStrings.aChallenge.tr,
                                isTextAtRight: false,
                                backgroundImage: ImageUtils.takeChallangeImage,
                                titleTextStyle: TextStyles
                                    .homeTabCardTitleStyleBold,
                                subTitleTextStyle:
                                TextStyles.homeTabCardSubTitleStyleBold.copyWith(
                                    fontSize: 14),
                              ),
                              Container(
                                height: ScreenConstant.defaultHeightFifteen,
                              ),
                              HomeCardWidget(
                                onTap: () {
                                  Get.toNamed(Routes.CHECKWINNER);
                                },
                                title: AppStrings.check.tr,
                                subTitle: AppStrings.checkTheWinner.tr,
                                isTextAtRight: true,
                                backgroundImage: ImageUtils.checkWinnersImage,
                                titleTextStyle:
                                TextStyles.homeTabSecondCardTitleStyleBold,
                                subTitleTextStyle:
                                TextStyles.homeTabSecondCardSubTitleStyleBold
                                    .copyWith(fontSize: 14),
                              ),
                              Container(
                                height: ScreenConstant.defaultHeightFifteen,
                              ),
                              HomeCardWidget(
                                onTap: () {
                                  Get.toNamed(Routes.VOTINGSCREEN);
                                },
                                title: AppStrings.cast.tr,
                                subTitle: AppStrings.yourVote.tr,
                                isTextAtRight: false,
                                backgroundImage: ImageUtils.voteImageImage,
                                titleTextStyle:
                                TextStyles.homeTabSecondCardTitleStyleBold,
                                subTitleTextStyle:
                                TextStyles.homeTabSecondCardSubTitleStyleBold
                                    .copyWith(fontSize: 14),
                              ),
                              Container(
                                height: ScreenConstant.defaultHeightFifteen,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenConstant
                                            .sizeSmallHighest),
                                    child: Text(AppStrings.events.tr,
                                        style: TextStyles.homeTabStyleSemiBold),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.ALLEVENTS);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: ScreenConstant
                                              .sizeSmallHighest),
                                      child: Text(AppStrings.viewAll.tr,
                                          style: TextStyles
                                              .homeViewAllStyleSemiBold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: ScreenConstant.defaultHeightFifteen,
                              ),
                              HomeBottomContainerWidget(
                                onTap: () {
                                  Get.toNamed(Routes.ALLEVENTS);
                                },
                                buttonText: AppStrings.buytickets,
                                firstTitle: AppStrings.concerts.tr,
                                secondTitle: AppStrings.festivals.tr,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
          Visibility(
            visible: controller.isLoading.value,
            child: Loader(
              text: "",
            ),
          )
                ],
              ),
        );
  }
}
