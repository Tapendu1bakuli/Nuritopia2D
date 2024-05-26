import 'parents/model.dart';

class Global extends Model {
  String? mockBaseUrl;
  String? laravelBaseUrl;
  String? apiPath;
  String? iosAppLink;
  String? androidAppLink;
  int? received;
  int? accepted;
  int? done;
  int? failed;

  Global({this.mockBaseUrl, this.laravelBaseUrl, this.apiPath});

  Global.fromJson(Map<String, dynamic> json) {
    mockBaseUrl = json['mock_base_url'].toString();
    androidAppLink = json['android_app'].toString();
    iosAppLink = json['ios_app'].toString();
    laravelBaseUrl = json['laravel_base_url'].toString();
    apiPath = json['api_path'].toString();
    received = intFromJson(json, 'received');
    accepted = intFromJson(json, 'accepted');
    done = intFromJson(json, 'done');
    failed = intFromJson(json, 'failed');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mock_base_url'] = this.mockBaseUrl == null ? null : this.mockBaseUrl;
    data['laravel_base_url'] = this.laravelBaseUrl == null ? null : this.laravelBaseUrl;
    data['api_path'] = this.apiPath == null ? null : this.apiPath;
    data['android_app'] = this.androidAppLink == null ? null : this.androidAppLink;
    data['ios_app'] = this.iosAppLink == null ? null : this.iosAppLink;
    return data;
  }
}
