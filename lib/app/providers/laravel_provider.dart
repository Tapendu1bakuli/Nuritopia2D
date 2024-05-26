/*
 * File name: laravel_provider.dart
 * Last modified: 2022.02.27 at 23:37:17
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/ui.dart';
import '../../common/uuid.dart';

import '../models/address_model.dart';

import '../models/setting_model.dart';
import '../models/user_model.dart';
import '../services/translation_service.dart';
import 'api_provider.dart';

class LaravelApiClient extends GetxService with ApiClient {
  late dio.Dio _httpClient;
  late dio.Options _optionsNetwork;
  late dio.Options _optionsCache;

  LaravelApiClient() {
    this.baseUrl = this.globalService.global.value.laravelBaseUrl;
    _httpClient = new dio.Dio();
  }

  Future<LaravelApiClient> init() async {
    if (foundation.kIsWeb || foundation.kDebugMode) {
      _optionsNetwork = dio.Options();
      _optionsCache = dio.Options();
    } else {
      _optionsNetwork =
          buildCacheOptions(Duration(days: 3), forceRefresh: true);
      _optionsCache =
          buildCacheOptions(Duration(minutes: 10), forceRefresh: false);
      _httpClient.interceptors.add(
          DioCacheManager(CacheConfig(baseUrl: getApiBaseUrl(""))).interceptor);
    }
    return this;
  }

  void forceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
      _optionsCache = dio.Options();
    }
  }

  void unForceRefresh({Duration duration = const Duration(minutes: 10)}) {
    if (!foundation.kDebugMode) {
      _optionsCache = buildCacheOptions(duration, forceRefresh: false);
    }
  }

  // Future<User> getUser(User user) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "you_dont_have_the_permission_to_access_to_this_area".tr +
  //             "[ getUser() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //     'with': 'salons'
  //   };
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters.addAll(
  //         {'locale': Get.find<TranslationService>().getLocale().languageCode});
  //   Uri _uri = getApiBaseUri("salon_owner/user")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.getUri(
  //     _uri,
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     return User.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<User> login(User user) async {
  //   var _queryParameters;
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters = {
  //       'locale': Get.find<TranslationService>().getLocale().languageCode,
  //     };
  //   Uri _uri = getApiBaseUri("salon_owner/login")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   try {
  //     var response = await _httpClient.postUri(
  //       _uri,
  //       data: json.encode(user.toJson()),
  //       options: _optionsNetwork,
  //     );
  //     if (response.data['success'] == true) {
  //       response.data['data']['auth'] = true;
  //       return User.fromJson(response.data['data']);
  //     } else {
  //       var error = BaseModel.fromJson(response.data);
  //       Get.showSnackbar(Ui.ErrorSnackBar(message: error.message));
  //       return user;
  //     }
  //   } catch (e) {
  //     print("Catch: $e");
  //   }
  //   return user;
  // }
  //
  // Future<User> register(User user) async {
  //   var _queryParameters;
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters = {
  //       'locale': Get.find<TranslationService>().getLocale().languageCode,
  //     };
  //   Uri _uri = getApiBaseUri("salon_owner/register")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(
  //     _uri,
  //     data: json.encode(user.toJson()),
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     response.data['data']['auth'] = true;
  //     return User.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<bool> sendResetLinkEmail(User user) async {
  //   var _queryParameters;
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters = {
  //       'locale': Get.find<TranslationService>().getLocale().languageCode,
  //     };
  //   Uri _uri = getApiBaseUri("salon_owner/send_reset_link_email")
  //       .replace(queryParameters: _queryParameters);
  //   Get.log(_uri.toString());
  //   // to remove other attributes from the user object
  //   user = new User(email: user.email);
  //   try {
  //     var response = await _httpClient.postUri(
  //       _uri,
  //       data: json.encode(user.toJson()),
  //       options: _optionsNetwork,
  //     );
  //     if (response.data['success'] == true) {
  //       Get.showSnackbar(Ui.SuccessSnackBar(
  //           message: "the_password_reset_link_has_been_sent_to_your_email".tr +
  //               user.email!));
  //       return true;
  //     } else {
  //       var error = BaseModel.fromJson(response.data);
  //       Get.showSnackbar(Ui.ErrorSnackBar(message: error.message));
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //     return false;
  //   }
  // }
  //
  // Future<User> updateUser(User user) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "you_dont_have_the_permission_to_access_to_this_area".tr +
  //             "[ updateUser() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters.addAll(
  //         {'locale': Get.find<TranslationService>().getLocale().languageCode});
  //   print("Data: ${json.encode(user.toJson())}");
  //   Uri _uri = getApiBaseUri("salon_owner/users/${user.id}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(
  //     _uri,
  //     data: json.encode(user.toJson()),
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     response.data['data']['auth'] = true;
  //     return User.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<User> updateEmployee(User user) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "you_dont_have_the_permission_to_access_to_this_area".tr +
  //             "[ updateUser() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters.addAll(
  //         {'locale': Get.find<TranslationService>().getLocale().languageCode});
  //   print("Data: ${json.encode(user.toEmployeeJson())}");
  //   Uri _uri = getApiBaseUri("salon_owner/employee_update/${user.id}")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(
  //     _uri,
  //     data: json.encode(user.toEmployeeJson()),
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     response.data['data']['auth'] = true;
  //     return User.fromJson(response.data['data']);
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<bool> deleteUser(User user) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "you_dont_have_the_permission_to_access_to_this_area".tr +
  //             "[ deleteUser() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters.addAll(
  //         {'locale': Get.find<TranslationService>().getLocale().languageCode});
  //   Uri _uri =
  //       getApiBaseUri("users").replace(queryParameters: _queryParameters);
  //   var response = await _httpClient.deleteUri(
  //     _uri,
  //     options: _optionsNetwork,
  //   );
  //   if (response.data['success'] == true) {
  //     Get.showSnackbar(Ui.SuccessSnackBar(message: response.data['message']));
  //     return response.data['data'];
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }

  Future<bool> providerSignUp(
    String name,
    int eProviderTypeId,
    String phoneNumber,
    String mobileNumber,
    String availRange,
    double lat,
    double lng,
    String add,
    String userId,
    String description,
    String country,
  ) async {
    print(name);
    print(eProviderTypeId);
    print(phoneNumber);
    print(mobileNumber);
    print(availRange);
    print(lat);
    print(lng);
    print(add);
    print(userId);
    print(description);
    print(country);

    dio.FormData formData() {
      var formData = new dio.FormData.fromMap({
        'name': name,
        'salon_level_id': eProviderTypeId,
        'phone_number': phoneNumber,
        'mobile_number': mobileNumber,
        'availability_range': availRange,
        'latitude': lat,
        'longitude': lng,
        'address': add,
        'description': description,
        'user_id': userId,
        'available': 1,
        'country': country,
      });
      return formData;
    }

    print("data: ${json.encode({
          'name': name,
          'salon_level_id': eProviderTypeId,
          'phone_number': phoneNumber,
          'mobile_number': mobileNumber,
          'availability_range': availRange,
          'latitude': lat,
          'longitude': lng,
          'address': add,
          'description': description,
          'user_id': userId,
          'available': 1,
          'country': country,
        })}");
    var _queryParameters;
    if (Get.isRegistered<TranslationService>())
      _queryParameters = {
        'locale': Get.find<TranslationService>().getLocale().languageCode,
      };
    Uri _uri = getApiBaseUri("salon_owner/signup")
        .replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(
      _uri,
      data: formData(),
      options: _optionsNetwork,
    );
    print(response.data);
    if (response.data['success'] == true) {
      return true;
    } else {
      throw new Exception(response.data['message']);
    }
  }

  // Future<List<Address>> getAddresses() async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "you_dont_have_the_permission_to_access_to_this_area".tr +
  //             "[ getAddresses() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //     'search': "user_id:${authService.user.value.id}",
  //     'searchFields': 'user_id:=',
  //     'orderBy': 'id',
  //     'sortedBy': 'desc',
  //   };
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters.addAll(
  //         {'locale': Get.find<TranslationService>().getLocale().languageCode});
  //   Uri _uri =
  //       getApiBaseUri("addresses").replace(queryParameters: _queryParameters);
  //   var response = await _httpClient.getUri(_uri, options: _optionsCache);
  //   if (response.data['success'] == true) {
  //     return response.data['data']
  //         .map<Address>((obj) => Address.fromJson(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }

  Future<Setting> getSettings() async {
    var _queryParameters;
    if (Get.isRegistered<TranslationService>())
      _queryParameters = {
        'locale': Get.find<TranslationService>().getLocale().languageCode,
      };
    Uri _uri = getApiBaseUri("salon_owner/settings")
        .replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return Setting.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Map<String, String>> getTranslations(String locale) async {
    startProgress('getTranslations');
    var _queryParameters = {
      'locale': locale,
    };
    Uri _uri = getApiBaseUri("salon_owner/translations")
        .replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    endProgress();
    if (response.data['success'] == true) {
      if (!(response.data['data'] is List))
        return Map<String, String>.from(response.data['data']);
      else
        return <String, String>{};
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<String>> getSupportedLocales() async {
    var _queryParameters;
    if (Get.isRegistered<TranslationService>())
      _queryParameters = {
        'locale': Get.find<TranslationService>().getLocale().languageCode,
      };
    Uri _uri = getApiBaseUri("salon_owner/supported_locales")
        .replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return List.from(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  // Future<String> uploadImage(File file, String field) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "you_dont_have_the_permission_to_access_to_this_area".tr +
  //             "[ uploadImage() ]");
  //   }
  //   String fileName = file.path.split('/').last;
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters.addAll(
  //         {'locale': Get.find<TranslationService>().getLocale().languageCode});
  //   Uri _uri = getApiBaseUri("uploads/store")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   dio.FormData formData = dio.FormData.fromMap({
  //     "file": await dio.MultipartFile.fromFile(file.path, filename: fileName),
  //     "uuid": Uuid().generateV4(),
  //     "field": field,
  //   });
  //   var response;
  //   response = await _httpClient.postUri(_uri,
  //       options: dio.Options(headers: {"Accept": "application/json"}),
  //       data: formData);
  //   print(response);
  //   if (response.data['success'] != false) {
  //     return response.data['data'];
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<bool> deleteUploaded(String uuid) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "you_dont_have_the_permission_to_access_to_this_area".tr +
  //             "[ deleteUploaded() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters.addAll(
  //         {'locale': Get.find<TranslationService>().getLocale().languageCode});
  //   Uri _uri = getApiBaseUri("uploads/clear")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(_uri, data: {'uuid': uuid});
  //   print(response.data);
  //   if (response.data['data'] != false) {
  //     return true;
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }
  //
  // Future<bool> deleteAllUploaded(List<String> uuids) async {
  //   if (!authService.isAuth) {
  //     throw new Exception(
  //         "you_dont_have_the_permission_to_access_to_this_area".tr +
  //             "[ deleteUploaded() ]");
  //   }
  //   var _queryParameters = {
  //     'api_token': authService.apiToken,
  //   };
  //   if (Get.isRegistered<TranslationService>())
  //     _queryParameters.addAll(
  //         {'locale': Get.find<TranslationService>().getLocale().languageCode});
  //   Uri _uri = getApiBaseUri("uploads/clear")
  //       .replace(queryParameters: _queryParameters);
  //   printUri(StackTrace.current, _uri);
  //   var response = await _httpClient.postUri(_uri, data: {'uuid': uuids});
  //   print(response.data);
  //   if (response.data['data'] != false) {
  //     return true;
  //   } else {
  //     throw new Exception(response.data['message']);
  //   }
  // }


}
