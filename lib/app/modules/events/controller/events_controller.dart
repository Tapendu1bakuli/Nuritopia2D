import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import '../../../../common/country_code_picker/src/country.dart';
import '../../../../utils/Store/HiveStore.dart';
import '../../../../utils/image_utils/image_utils.dart';
import '../../../../utils/text_utils/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../../models/all_events_list_model.dart';
import '../../../models/city_list.dart';
import '../../../models/events_list_models.dart';
import '../../../models/header_model.dart';
import '../../../services/core_service.dart';
import '../../../services/urls.dart';
import '../../login/controller/theme_mode_controller.dart';
import '../../network_checker/controller/network_checker_controller.dart';

class EventsController extends GetxController {
  final CommonNetWorkStatusCheckerController netWorkStatusChecker =
      Get.put(CommonNetWorkStatusCheckerController());
  ThemeModeController themeModeController = Get.put(ThemeModeController());
  @override
  void onInit() {
    netWorkStatusChecker.updateConnectionStatus();
    allEvents();
    // Get called when controller is created
    super.onInit();
  }

  @override
  void onReady() {
    // Get called after widget is rendered on the screen
    super.onReady();
  }

  @override
  void onClose() {
    //Get called when controller is removed from memory
    super.onClose();
  }

  RxString countryName = "".obs;
  CityList cityList =
      CityList(cities: [Cities(id: 0, name: AppStrings.all.tr)]);
  late Cities currentCity = Cities(id: 0, name: AppStrings.all.tr);
  RxString currentCityName = "".obs;
  late Country countryData = Country.parse("WW");
  RxString countryFlag = "".obs;
  RxString filterType = "".obs;
  RxInt filterID = 0.obs;

  Types? selectedEventType;
  RxBool isLoading = false.obs;
  late num page = 1;
  RxList<dynamic> eventList = <dynamic>[].obs;
  RxString countryCode = "".obs;
  RxList<Events> eventsList = <Events>[].obs;
  RxList<Types> filterLists =
      <Types>[Types(id: 0, name: AppStrings.all.tr)].obs;
  //all event
  Future allEvents({
    String? cCode,
    String? city,
    int? eventTypeListFiltered,
  }) async {
    isLoading.value = true;
    await allEventsApiCall(cCode, city, eventTypeListFiltered)
        .then((result) async {
      if (result is EventsListModel) {
        if (result.status == "Success") {
          eventsList.clear();
          filterLists.clear();
          filterLists.add(Types(id: 0, name: AppStrings.all.tr));
          eventsList.value = result.data?.events ?? [];
          filterLists.addAll(result.data?.types ?? []);
          Get.log("Length:${eventsList.length}");
          print("Length:${filterLists.length}");
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showFailureSnackBar("Failed", result.message ?? "Login Failed");
        }
      }
    });
  }

  //All event API call
  allEventsApiCall(
      String? cCode, String? city, int? eventTypeListFiltered) async {
    String _timezone = await FlutterTimezone.getLocalTimezone();
    HeaderModel headerModel = HeaderModel(
      token: HiveStore().get(Keys.AUTHORIZATIONTOKEN),
      nuritopiaToken: HiveStore().get(Keys.NURITOPIAAUTHORIZATIONTOKEN),
    );
    var result = await CoreService().apiService(
      header: headerModel.toHeader(),
      ssl: SSL.HTTP,
      baseURL: Urls.baseUrl,
      body: {
        "search_by_country_code": cCode,
        "search_by_city_name": city,
        "search_by_event_type": eventTypeListFiltered,
        "timezone": _timezone,
      },
      method: METHOD.POST,
      endpoint: Urls.allEvents,
    );
    return EventsListModel.fromJson(result);
  }

  getCities(String countryCode) async {
    isLoading.value = true;
    final response = await CoreService().apiService(
        method: METHOD.GET,
        baseURL: Urls.CITY_BASE_URL,
        commonPoint: Urls.CITY_API_V1,
        endpoint: "$countryCode${Urls.CITY_END_POINT}",
        header: {"X-CSCAPI-KEY": Urls.APIKEY});
    isLoading.value = false;

    if (List.from(response).isNotEmpty) {
      cityList = CityList(
          cities: List.from(response).map((e) => Cities.fromJson(e)).toList());
      currentCity = Cities(id: 0, name: AppStrings.all.tr);
    } else {
      cityList = CityList(cities: [Cities(id: 0, name: AppStrings.all.tr)]);
      currentCity = Cities(id: 0, name: AppStrings.all.tr);
    }
  }
}
