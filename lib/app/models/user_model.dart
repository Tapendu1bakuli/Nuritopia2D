
import 'package:nuritopia2d/app/models/parents/model.dart';

class Users extends Model{
  int? status;
  String? message;
  Data? data;

  Users({this.status, this.message, this.data});

  Users.usersFromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? newUser;
  String? userId;
  String? nickName;
  String? email;
  String? style;
  int? age;
  String? country;
  String? profileImage;
  String? mBTI;
  String? authorizationToken;
  String? walletId;

  Data(
      {this.newUser,
        this.userId,
        this.nickName,
        this.email,
        this.style,
        this.age,
        this.country,
        this.profileImage,
        this.mBTI,
        this.authorizationToken,
        this.walletId});

  Data.fromJson(Map<String, dynamic> json) {
    newUser = json['newUser'];
    userId = json['userId'];
    nickName = json['nickName'];
    email = json['email'];
    style = json['style'];
    age = json['age'];
    country = json['country'];
    profileImage = json['profileImage'];
    mBTI = json['MBTI'];
    authorizationToken = json['authorizationToken'];
    walletId = json['walletId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newUser'] = this.newUser;
    data['userId'] = this.userId;
    data['nickName'] = this.nickName;
    data['email'] = this.email;
    data['style'] = this.style;
    data['age'] = this.age;
    data['country'] = this.country;
    data['profileImage'] = this.profileImage;
    data['MBTI'] = this.mBTI;
    data['authorizationToken'] = this.authorizationToken;
    data['walletId'] = this.walletId;
    return data;
  }
}
