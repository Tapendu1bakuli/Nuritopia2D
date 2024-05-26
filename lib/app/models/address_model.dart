/*
 * File name: address_model.dart
 * Last modified: 2022.02.27 at 23:37:17
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */


import 'parents/model.dart';

class Address extends Model {
  String? id;
  String? description;
  String? address;
  double? latitude;
  double? longitude;
  bool? isDefault;
  String? userId;

  Address(
      {this.id,
      this.description,
      this.address,
      this.latitude,
      this.longitude,
      this.isDefault,
      this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = stringFromJson(json, 'description').replaceAll('\n', ' ');
    address = stringFromJson(json, 'address').replaceAll('\n', ' ');
    latitude = doubleFromJson(json, 'latitude', defaultValue: null);
    longitude = doubleFromJson(json, 'longitude', defaultValue: null);
    isDefault = boolFromJson(json, 'default');
    userId = stringFromJson(json, 'user_id');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = nullCheck(this.id);
    data['description'] = nullCheck(this.description == null ? getDescription : this.description);
    data['address'] = nullCheck(this.address);
    data['latitude'] = nullCheck(this.latitude);
    data['longitude'] = nullCheck(this.longitude);
    data['default'] = nullCheck(this.isDefault);
    data['user_id'] = nullCheck(this.userId);
    return data;
  }

  bool isUnknown() {
    return longitude == null;
  }

  String? get getDescription {
    if (hasDescription()) return description;
    return address;
  }

  bool hasDescription() {
    if (description?.isNotEmpty??false) return true;
    return false;
  }

  // LatLng getLatLng() {
  //   if (this.isUnknown()) {
  //     return LatLng(38.806103, 52.4964453);
  //   } else {
  //     return LatLng(this.latitude!, this.longitude!);
  //   }
  // }
}
