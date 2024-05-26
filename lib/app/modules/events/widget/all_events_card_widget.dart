import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';

class AllEventsCardWidget extends StatelessWidget {
  AllEventsCardWidget(
      {Key? key,
      this.place,
      this.month,
      this.isUpcoming,
      this.eventName,
      this.day,
      this.time,
      this.date,
      this.image,
      this.ontap})
      : super(key: key);
  String? image;
  String? month;
  String? date;
  String? eventName;
  String? day;
  String? time;
  String? place;
  String? isUpcoming;
  Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ScreenConstant.defaultWidthTen,
            vertical: ScreenConstant.defaultHeightFifteen),
        decoration: BoxDecoration(
            color: CustomColor.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    child: Image.network(image ??
                        "http://122.248.251.140/storage/EventIcon/VvHwnbYm5RVsRgSICWjy9yC3GBW0TYYQIIoSqHM5.jpg")),
                isUpcoming == "Closed"
                    ? Positioned(
                        bottom: 15,
                        right: 15,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenConstant.defaultHeightFifteen,
                              vertical: ScreenConstant.defaultWidthTen),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: CustomColor.white),
                          child: Text(
                            AppStrings.closed.tr.toUpperCase(),
                            style: TextStyles.homeTabSecondCardSubTitleStyleBold
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ))
                    : const Offstage(),
                isUpcoming == "Upcoming"
                    ? Positioned(
                        bottom: 15,
                        right: 15,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenConstant.defaultHeightFifteen,
                              vertical: ScreenConstant.defaultWidthTen),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: CustomColor.white),
                          child: Text(
                            AppStrings.upcoming.tr.toUpperCase(),
                            style: TextStyles.homeTabSecondCardSubTitleStyleBold
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ))
                    : isUpcoming == "Open"
                        ? Positioned(
                            bottom: 15,
                            right: 15,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      ScreenConstant.defaultHeightFifteen,
                                  vertical: ScreenConstant.defaultWidthTen),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CustomColor.white),
                              child: Text(
                                AppStrings.open.tr.toUpperCase(),
                                style: TextStyles
                                    .homeTabSecondCardSubTitleStyleBold
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                              ),
                            ))
                        : const Offstage()
              ],
            ),
            Container(
              height: ScreenConstant.defaultHeightFifteen,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenConstant.defaultWidthTwenty),
              child: Row(
                children: [
                  Container(
                    height: ScreenConstant.defaultHeightSixty,
                    width: ScreenConstant.defaultWidthSixty,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColor.bluishWhite),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          month ?? "",
                          style: TextStyles.homeTabSecondCardSubTitleStyleBold
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          date ?? "",
                          style: TextStyles.splashTitleBlue.copyWith(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ScreenConstant.defaultWidthTen,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventName ?? "",
                        style: TextStyles.homeTabSecondCardTitleStyleBold
                            .copyWith(
                                fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "$day,",
                            style: TextStyles.homeTabSecondCardTitleStyleBold
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            " $time,",
                            style: TextStyles.homeTabSecondCardTitleStyleBold
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            " $place",
                            style: TextStyles.homeTabSecondCardTitleStyleBold
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            // ListTile(
            //   leading: Container(
            //     width: ScreenConstant.defaultWidthSixty,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: CustomColor.bluishWhite),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           month??"",
            //           style: TextStyles.homeTabSecondCardSubTitleStyleBold
            //               .copyWith(
            //               fontSize: 14, fontWeight: FontWeight.w400),
            //         ),
            //         Text(
            //           date??"",
            //           style: TextStyles.splashTitleBlue.copyWith(
            //               fontSize: 24, fontWeight: FontWeight.w700),
            //         ),
            //       ],
            //     ),
            //   ),
            //   title: Text(eventName??""),
            //   titleTextStyle: TextStyles.homeTabSecondCardTitleStyleBold
            //       .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            //   subtitleTextStyle: TextStyles.homeTabSecondCardTitleStyleBold
            //       .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            //   subtitle: Row(
            //     children: [
            //       Text("$day,"),
            //       Text(" $time,"),
            //       Text(" $place"),
            //     ],
            //   ),
            // ),
            Container(
              height: ScreenConstant.defaultHeightFifteen,
            ),
          ],
        ),
      ),
    );
  }
}
