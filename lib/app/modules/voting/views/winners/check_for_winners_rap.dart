import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuritopia2d/app/modules/voting/controller/voting_controller.dart';
import '../../../../../common/common_text_form_field.dart';
import '../../../../../common/widgets/Loader.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/image_utils/image_utils.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../home/widgets/winners_grid_view_widget.dart';
import 'WinnersVideoPlayBack.dart';

class CheckForWinnersRap extends GetView<VotingController> {
  const CheckForWinnersRap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<VotingController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 200), () async {
        await controller.getWinner("1","");
      });
    }, builder: (_) {
      return Scaffold(
        backgroundColor: CustomColor.fillOffWhiteColor,
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: ScreenConstant.defaultHeightFifteen,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenConstant.defaultWidthTwenty,
                  ),
                  child: DefaultEditText(
                    onSaved: (input) {},
                    onChanged: (input) {
                      print(input);
                      if (input.isNotEmpty) {
                        controller.getWinner("2", input);
                      } else {
                        controller.getWinner("2", input);
                      }
                    },
                    onSubmit: controller.onSubmit.value = false,
                    type: Type.searchField,
                    prefixIcon: Container(),
                    style: TextStyles.textFieldTextStyleSemiBold,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: controller.currentPasswordController,
                    hintText: AppStrings.search.tr,
                  ),
                ),
                Container(
                  height: ScreenConstant.defaultHeightFifteen,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenConstant.defaultWidthTwenty,
                  ),
                  child: controller.winnerListDance.isNotEmpty
                      ?GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 2.9,
                      crossAxisCount: 2,
                      crossAxisSpacing: ScreenConstant.defaultWidthTen,
                      mainAxisSpacing:
                      ScreenConstant.defaultHeightFifteen,
                    ),
                    itemCount: controller.winnerListDance.length,
                    itemBuilder: (BuildContext context, int index) {
                      return WinnersGridViewWidget(
                        imageName:
                        controller.winnerListDance[index].imagePath,
                        songName:
                        controller.winnerListDance[index].beatName,
                        beat: controller.winnerListDance[index].stageName,
                        date: controller.formatDate(
                            controller.winnerListDance[index].createdAt ??
                                "2024-04-24T07:32:07.000000Z"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WinnersVideoPlayBack(
                                    videoPath: controller
                                        .winnerListDance[index].path,
                                    beatname: controller
                                        .winnerListDance[index]
                                        .beatName,
                                    artistName: controller
                                        .winnerListDance[index]
                                        .stageName,
                                    tos: controller
                                        .winnerListDance[index].tos
                                        .toString(),
                                    performerNickName: controller.winnerListDance[index].performerNickName,
                                    performerEmail: controller.winnerListDance[index].performerEmail,
                                    //model: controller.model,
                                    index: index,
                                  )));
                        },
                      );
                    },
                  ) : Column(
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
                )
              ],
            ),
            Visibility(
              child: Loader(
                text: "",
              ),
              visible: controller.isLoading.value,
            )
          ],
        ),
      );
    });
  }
}
