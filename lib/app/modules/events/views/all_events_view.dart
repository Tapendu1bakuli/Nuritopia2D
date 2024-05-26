import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/core/widgets/common_appBar_widget.dart';
import '../../../../common/country_code_picker/country_picker.dart';
import '../../../../common/widgets/Loader.dart';
import '../../../../device_manager/screen_constants.dart';
import '../../../../utils/TextStyles.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../models/city_list.dart';
import '../../../models/events_list_models.dart';
import '../controller/events_controller.dart';
import '../widget/SearchCity.dart';
import '../widget/all_events_card_widget.dart';
import '../../home/widgets/common_appbar_action_connect_widget.dart';

class AllEventsViewScreen extends GetView<EventsController> {
  const AllEventsViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: CustomColor.fillOffWhiteColor,
            appBar: CommonAppbarWidget(
              actionWidgets: [CommonAppBarConnectWidget()],
              isActionPresent: true,
              backgroundColor: CustomColor.white,
              titleSpacing: 0,
              titleTextStyle: TextStyles.appbarSmallTitleStyleBold,
              title: AppStrings.event.tr,
              isLeadingPresent: true,
              leadingOnTap: () {
                Get.back();
              },
              centerTitle: false,
              leadingWidgetIcon: Icons.arrow_back_ios_new_rounded,
              leadingWidgetSize: ScreenConstant.smallIconSize,
            ),
            body: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenConstant.sizeExtraSmall),
                  height: ScreenConstant.screenHeightNineteen,
                  decoration: const BoxDecoration(color: CustomColor.white),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                textStyle: TextStyles
                                    .homeTabSecondCardTitleStyleBold
                                    .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300)),
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                exclude: <String>['KN', 'MF'],
                                favorite: <String>['SE'],
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  controller.countryData = country;
                                  controller.countryName.value =
                                      country.displayName;
                                  controller.countryFlag.value =
                                      country.flagEmoji;
                                  controller.countryCode.value =
                                      country.countryCode;
                                  controller.currentCityName.value = "";
                                  controller
                                      .getCities(controller.countryCode.value);
                                  controller.allEvents(
                                      cCode: controller.countryCode.value);
                                  // controller.allEvents(
                                  //   cCode: controller.countryData.countryCode,
                                  //   city: controller.currentCity.name,
                                  //   eventTypeListFiltered: controller.selectedEventType?.id.toString(),
                                  //   page: controller.page,
                                  // );
                                },
                                // Optional. Sets the theme for the country list picker.
                                countryListTheme: CountryListThemeData(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  // Optional. Styles the text in the search field
                                  searchTextStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                controller.countryFlag.value == ""
                                    ? Image.asset(
                                        ImageUtils.demoFlag,
                                        scale: 1.6,
                                      )
                                    : Text(
                                        controller.countryFlag.value,
                                        style: TextStyles.drawerTitleBold
                                            .copyWith(fontSize: 20),
                                      ),
                                Container(
                                  width: ScreenConstant.defaultWidthTen,
                                ),
                                controller.countryName.value == ""
                                    ? Text('India')
                                    : Expanded(
                                        child: Text(controller.countryName.value
                                            .split("(")
                                            .first)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                textStyle: TextStyles
                                    .homeTabSecondCardTitleStyleBold
                                    .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300)),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.80,
                                  decoration: const BoxDecoration(
                                    color: CustomColor.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                    ),
                                  ),
                                  child: SearchCity(
                                    allCityList: controller.cityList.cities,
                                    currentCity: controller.currentCity,
                                    callBackChange: (Cities cities) {
                                      controller.currentCity = cities;
                                      controller.currentCityName.value =
                                          cities.name;
                                      controller.allEvents(
                                          cCode: controller.countryCode.value,
                                          city:
                                              controller.currentCityName.value);
                                    },
                                  ),
                                ),
                              );
                            },
                            child: controller.currentCityName.value == ""
                                ? const Text('All')
                                : Text(controller.currentCityName.value),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: CustomColor.dividerColor.withOpacity(0.2),
                      ),
                      Expanded(
                          flex: 0,
                          child: Obx(
                            () => DropdownButton<Types>(
                              hint: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        ScreenConstant.defaultWidthTwenty),
                                child: controller.filterType.value == ""
                                    ? Image.asset(
                                        ImageUtils.filter,
                                        scale: 1.5,
                                      )
                                    : Text(controller.filterType.value,
                                        style: TextStyles.textStyleRegular
                                            .copyWith(
                                                fontSize: 12,
                                                color:
                                                    CustomColor.colorTextHint,
                                                fontWeight: FontWeight.w400)),
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              items: controller.filterLists.map((Types value) {
                                return DropdownMenuItem<Types>(
                                  value: value,
                                  child: Text(value.name ?? "",
                                      style: TextStyles.textStyleRegular),
                                );
                              }).toList(),
                              onChanged: (val) {
                                controller.filterID.value = val!.id ?? 0;
                                controller.filterType.value = val!.name ?? "";
                                print(
                                    "Filter Type:${controller.filterType.value}");
                                controller.allEvents(
                                    cCode: controller.countryCode.value,
                                    city: controller.currentCityName.value,
                                    eventTypeListFiltered:
                                        controller.filterID.value);
                              },
                              value: controller.selectedEventType,
                            ),
                          )),
                    ],
                  ),
                ),
                Obx(
                  () => controller.eventsList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          //itemCount: controller.allEventList.length,
                          itemCount: controller.eventsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AllEventsCardWidget(
                              ontap: () {
                                if (controller.eventsList[index].eventStatus ==
                                    "Open") {
                                  launchUrls(Uri.parse(
                                      controller.eventsList[index].eventUrl ??
                                          ""));
                                }
                              },
                              isUpcoming:
                                  controller.eventsList[index].eventStatus ??
                                      "",
                              image:
                                  controller.eventsList[index].thumbnail ?? "",
                              date: getDate(
                                  controller.eventsList[index].dateOfEvent ??
                                      ""),
                              day: getDay(
                                  controller.eventsList[index].dateOfEvent ??
                                      ""),
                              month: getMonth(
                                  controller.eventsList[index].dateOfEvent ??
                                      ""),
                              eventName:
                                  controller.eventsList[index].title ?? "",
                              time: getTime(
                                  controller.eventsList[index].dateOfEvent ??
                                      ""),
                              place: controller.eventsList[index].venue ?? "",
                            );
                          })
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: ScreenConstant.screenHeightThirdAndHalf,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      ScreenConstant.defaultHeightTwentyThree),
                              height: ScreenConstant.screenHeightEighth,
                              decoration: BoxDecoration(
                                  color: CustomColor.fillOffWhiteColor),
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
                ),
              ],
            ),
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
  }
}
