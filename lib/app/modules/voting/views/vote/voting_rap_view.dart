import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../../common/widgets/Loader.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../../../utils/utils.dart';
import '../../../../routes/routes.dart';
import '../../../home/widgets/voting_bottom_avatar_widget.dart';
import '../../controller/voting_controller.dart';
import '../winners/WinnersVideoPlayBack.dart';

class VotingRapView extends GetView<VotingController> {
  const VotingRapView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<VotingController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 200), () async {
        await controller.getRapVideo();
      });
    }, builder: (_) {
      return Scaffold(
        body: Stack(
          children: [
            controller.rapVotingVideoLists.isNotEmpty
                ? ListView(children: [
                    Container(
                      height: ScreenConstant.defaultHeightTen,
                    ),
                    Center(
                      child: Text(
                        controller
                                .rapVotingVideoLists[
                                    controller.currentIndex.value]
                                .stageName ??
                            "",
                        style: TextStyles.homeTabStyleSemiBold.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      height: ScreenConstant.defaultHeightTwentyThree,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.screenWidthFifteen),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Center(
                            child: Stack(children: [
                              Image.network(
                                controller
                                        .rapVotingVideoLists[
                                            controller.currentIndex.value]
                                        .imagePathBanner ??
                                    "",
                              ),
                              Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  WinnersVideoPlayBack(
                                                    performerEmail: controller
                                                            .rapVotingVideoLists[
                                                                controller
                                                                    .currentIndex
                                                                    .value]
                                                            .performarEmail ??
                                                        "",
                                                    performerNickName: controller
                                                            .rapVotingVideoLists[
                                                                controller
                                                                    .currentIndex
                                                                    .value]
                                                            .performarNuritopiaNickname ??
                                                        "",
                                                    videoPath: controller
                                                            .rapVotingVideoLists[
                                                                controller
                                                                    .currentIndex
                                                                    .value]
                                                            .path ??
                                                        "",
                                                    beatname: controller
                                                            .rapVotingVideoLists[
                                                                controller
                                                                    .currentIndex
                                                                    .value]
                                                            .videoName ??
                                                        "",
                                                    artistName: controller
                                                            .rapVotingVideoLists[
                                                                controller
                                                                    .currentIndex
                                                                    .value]
                                                            .stageName ??
                                                        "",
                                                    tos: controller
                                                        .rapVotingVideoLists[
                                                            controller
                                                                .currentIndex
                                                                .value]
                                                        .votingScore
                                                        .toString(),
                                                    //model: controller.model,
                                                    index: 1,
                                                  )));
                                    },
                                    child: Image.asset(
                                      ImageUtils.playVideo,
                                      scale: 2,
                                    ),
                                  ))
                            ]),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.screenWidthMinimum,
                          vertical: ScreenConstant.defaultHeightFifteen),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: UniversalButtonWidget(
                              ontap: () {},
                              borderRadius: BorderRadius.circular(15),
                              color: controller.isChallenges.value
                                  ? CustomColor.primaryBlue
                                  : CustomColor.fillOffWhiteColor,
                              borderColor: CustomColor.primaryBlue,
                              margin: EdgeInsets.symmetric(
                                horizontal: ScreenConstant.defaultWidthTwenty,
                              ),
                              leadingIconvisible: false,
                              prefixIcon: ImageUtils.vote,
                              prefixIconColor: CustomColor.primaryBlue,
                              prefixIconHeight: ScreenConstant.minimumIconSize,
                              title:
                                  "${AppStrings.vote.tr.toUpperCase()} : ${controller.rapVotingVideoLists[controller.currentIndex.value].votingScore}",
                              titleTextStyle: TextStyles
                                  .redHeartTextStyleStyleBold
                                  .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.secondaryBlue),
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: UniversalButtonWidget(
                                ontap: () {
                                  Get.toNamed(Routes.CONNECTWITHPERSON,
                                      arguments: [
                                        controller
                                            .rapVotingVideoLists[
                                                controller.currentIndex.value]
                                            .performarNuritopiaNickname,
                                        controller
                                            .rapVotingVideoLists[
                                                controller.currentIndex.value]
                                            .performarEmail,
                                        controller
                                            .rapVotingVideoLists[
                                                controller.currentIndex.value]
                                            .beatName,
                                      ]);
                                },
                                borderRadius: BorderRadius.circular(15),
                                color: controller.isChallenges.value
                                    ? CustomColor.primaryBlue
                                    : CustomColor.fillOffWhiteColor,
                                borderColor: CustomColor.primaryBlue,
                                margin: EdgeInsets.symmetric(
                                  horizontal: ScreenConstant.defaultWidthTwenty,
                                ),
                                leadingIconvisible: false,
                                prefixIcon: ImageUtils.connect,
                                prefixIconColor: CustomColor.primaryBlue,
                                prefixIconHeight:
                                    ScreenConstant.minimumIconSize,
                                title: AppStrings.connect.tr,
                                titleTextStyle: TextStyles
                                    .redHeartTextStyleStyleBold
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: CustomColor.secondaryBlue),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenConstant.defaultHeightTwentyThree,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.screenWidthFifteen),
                      child: Center(
                        child: SizedBox(
                          height: ScreenConstant.screenHeightFourth,
                          child: ListView.separated(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: controller.rapVotingVideoLists.length,
                            itemBuilder: (BuildContext context, int index) {
                              return VotingBottomAvatarWidget(
                                onTap: () {
                                  controller.currentIndex.value = index;
                                  controller.beatName.value = controller
                                          .rapVotingVideoLists[index]
                                          .beatName ??
                                      "";
                                  controller.videoPlayerController.pause();
                                  controller.videoPlayerController =
                                      VideoPlayerController.networkUrl(
                                          Uri.parse(controller
                                                  .rapVotingVideoLists[index]
                                                  .path ??
                                              ""))
                                        ..initialize().then((_) {
                                          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                        });
                                  controller.isPlaying.value = false;
                                  for (var element
                                      in controller.rapVotingVideoLists) {
                                    element.isSelected = false;
                                  }
                                  debugPrint("index:$index");
                                  controller.rapVotingVideoLists[index]
                                          .isSelected =
                                      !controller.rapVotingVideoLists[index]
                                          .isSelected!;
                                  controller.rapVotingVideoLists.refresh();
                                  // controller.rapVotingVideoLists[index].ontap!();
                                },
                                image: controller.rapVotingVideoLists[index]
                                    .imageFileNuritopia,
                                isColored: controller
                                    .rapVotingVideoLists[index].isSelected,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                width: ScreenConstant.screenWidthMinimum,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenConstant.defaultHeightForty,
                    ),
                    UniversalButtonWidget(
                      ontap: () {
                        controller.originalPrice.value = 1;
                        modalBottomSheetMenu(
                            context,
                            controller
                                    .rapVotingVideoLists[
                                        controller.currentIndex.value]
                                    .stageName ??
                                "");
                      },
                      color: CustomColor.primaryBlue,
                      borderRadius: BorderRadius.circular(15),
                      margin: EdgeInsets.symmetric(
                        vertical: ScreenConstant.defaultHeightTen,
                        horizontal: ScreenConstant.screenWidthTenth,
                      ),
                      leadingIconvisible: true,
                      title: AppStrings.vote.tr,
                      titleTextStyle: TextStyles.textStyleRegular
                          .apply(color: CustomColor.white),
                    )
                  ])
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: ScreenConstant.screenHeightSixth,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenConstant.defaultHeightTwentyThree),
                        height: ScreenConstant.screenHeightEighth,
                        decoration:
                            BoxDecoration(color: CustomColor.fillOffWhiteColor),
                        child: Image.asset(
                          ImageUtils.deleteIcon,
                          color: CustomColor.primaryBlue,
                        ),
                      ),
                      Text(
                        AppStrings.empty,
                        style: TextStyles.hintTextStyle,
                      ),
                    ],
                  ),
            Visibility(
              visible: controller.isLoading.value,
              child: Loader(
                text: "",
              ),
            )
          ],
        ),
      );
    });
  }

  Future modalBottomSheetMenu(BuildContext context, String? name) async {
    await showModalBottomSheet(
        backgroundColor: CustomColor.fillOffWhiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (builder) {
          return Obx(
            () => Container(
              height: ScreenConstant.screenHeightThird,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenConstant.defaultHeightTwentyThree,
                      ),
                      Text(
                        "${AppStrings.voteFor.tr}$name",
                        style: TextStyles.drawerSubTitleBold
                            .copyWith(color: CustomColor.primaryBlack),
                      ),
                      Container(
                        height: ScreenConstant.defaultHeightTen,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: CustomColor.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      splashRadius: 1,
                                      onPressed: () {
                                        controller.negotiationPriceSetting(
                                            controller.minimumPrice.value,
                                            controller.originalPrice.value,
                                            controller.maximumPrice.value,
                                            false);
                                        print(
                                            "Minimum:${controller.minimumPrice.value}");
                                        print(
                                            "Minimum:${controller.originalPrice.value}");
                                        print(
                                            "Minimum:${controller.maximumPrice.value}");
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        size: 30,
                                      )),
                                ],
                              ),
                              DropdownButton(
                                iconSize: 0.0,
                                underline: SizedBox.shrink(),
                                alignment: Alignment.center,
                                style: TextStyles.textStyleRegular.apply(
                                    color: Colors.black, fontSizeFactor: 1.7),
                                hint: Text(
                                  "${controller.originalPrice.value}",
                                  style: TextStyles.drawerSubTitleBold.copyWith(
                                      color: CustomColor.primaryBlack),
                                ),
                                items: <int>[
                                  10,
                                  20,
                                  30,
                                  50,
                                ].map(
                                  (val) {
                                    return DropdownMenuItem<int>(
                                      value: val,
                                      child: Text(
                                        "$val",
                                        style: TextStyles.drawerSubTitleBold
                                            .copyWith(
                                                color:
                                                    CustomColor.primaryBlack),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (int? val) {
                                  controller.originalPrice.value = val!;
                                  // controller.usd.value = int.parse(val);
                                  // (int.parse(val.toString().replaceAll(" TOS", "")) /
                                  //     controller.tosToken.value)
                                  //     .ceil();
                                },
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      splashRadius: 1,
                                      onPressed: () {
                                        controller.negotiationPriceSetting(
                                            controller.minimumPrice.value,
                                            controller.originalPrice.value,
                                            controller.maximumPrice.value,
                                            true);
                                        print(
                                            "Minimum:${controller.minimumPrice.value}");
                                        print(
                                            "Minimum:${controller.originalPrice.value}");
                                        print(
                                            "Minimum:${controller.maximumPrice.value}");
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 30,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text("${controller.originalPrice.value} Vote ="),
                          Container(
                            width: ScreenConstant.defaultWidthTen,
                          ),
                          redHeartCurrency(
                            "${controller.originalPrice.value * 500}",
                            ImageUtils.whiteHeartImage,
                            TextStyles.drawerSubTitleBold
                                .copyWith(color: CustomColor.primaryBlack),
                          ),
                        ],
                      ),
                      controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : UniversalButtonWidget(
                              ontap: () {
                                print("Type:D");
                                print(
                                    "VideoId:${controller.rapVotingVideoLists[controller.currentIndex.value].id}");
                                print("Vote:${controller.originalPrice.value}");
                                print(
                                    "ArtistName:${controller.rapVotingVideoLists[controller.currentIndex.value].stageName}");
                                print(
                                    "BeatName:${controller.rapVotingVideoLists[controller.currentIndex.value].stageName}");
                                print(
                                    "VideoName:${controller.rapVotingVideoLists[controller.currentIndex.value].stageName}");
                                controller.submitVotingDetails(
                                    "S",
                                    controller
                                        .rapVotingVideoLists[
                                            controller.currentIndex.value]
                                        .id
                                        .toString(),
                                    controller
                                        .rapVotingVideoLists[
                                            controller.currentIndex.value]
                                        .id
                                        .toString(),
                                    controller.originalPrice.value.toString(),
                                    controller
                                        .rapVotingVideoLists[
                                            controller.currentIndex.value]
                                        .stageName,
                                    controller
                                        .rapVotingVideoLists[
                                            controller.currentIndex.value]
                                        .stageName,
                                    controller
                                        .rapVotingVideoLists[
                                            controller.currentIndex.value]
                                        .stageName);
                              },
                              color: CustomColor.primaryBlue,
                              margin: EdgeInsets.symmetric(
                                vertical: ScreenConstant.defaultHeightFifteen,
                                horizontal: ScreenConstant.defaultWidthTwenty,
                              ),
                              leadingIconvisible: true,
                              title: AppStrings.vote.tr,
                              titleTextStyle: TextStyles.textStyleRegular
                                  .apply(color: CustomColor.white),
                            )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
    // return choosedImage;
  }
}
