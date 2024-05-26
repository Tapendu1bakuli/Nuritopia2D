class PerformerDetailsModel {
  String? status;
  Data? data;

  PerformerDetailsModel({this.status, this.data});

  PerformerDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? appleAuthorizationCode;
  String? appleIdentityToken;
  String? appleUserIdentifier;
  String? appleGivenName;
  String? appleFamilyName;
  Null? firstName;
  Null? lastName;
  String? nickName;
  Null? city;
  String? country;
  String? email;
  String? nuritopiaUserID;
  int? newUser;
  String? style;
  Null? emailVerifiedAt;
  String? accessToken;
  int? userType;
  Null? paymentAccountId;
  Null? subPaymenyAccountId;
  String? age;
  List<String>? profileImage;
  String? mBTI;
  Null? authorizationToken;
  int? hasAlreadySignIN;
  Null? paymentAccountAddress;
  int? userStatus;
  String? walletId;
  Null? blockchain;
  String? lenguage;
  String? countryCode;
  String? localZone;
  int? firstTimeLogin;
  int? parentId;
  Null? paymentType;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Data(
      {this.id,
        this.appleAuthorizationCode,
        this.appleIdentityToken,
        this.appleUserIdentifier,
        this.appleGivenName,
        this.appleFamilyName,
        this.firstName,
        this.lastName,
        this.nickName,
        this.city,
        this.country,
        this.email,
        this.nuritopiaUserID,
        this.newUser,
        this.style,
        this.emailVerifiedAt,
        this.accessToken,
        this.userType,
        this.paymentAccountId,
        this.subPaymenyAccountId,
        this.age,
        this.profileImage,
        this.mBTI,
        this.authorizationToken,
        this.hasAlreadySignIN,
        this.paymentAccountAddress,
        this.userStatus,
        this.walletId,
        this.blockchain,
        this.lenguage,
        this.countryCode,
        this.localZone,
        this.firstTimeLogin,
        this.parentId,
        this.paymentType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appleAuthorizationCode = json['appleAuthorizationCode'];
    appleIdentityToken = json['appleIdentityToken'];
    appleUserIdentifier = json['appleUserIdentifier'];
    appleGivenName = json['appleGivenName'];
    appleFamilyName = json['appleFamilyName'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    nickName = json['nickName'];
    city = json['city'];
    country = json['country'];
    email = json['email'];
    nuritopiaUserID = json['nuritopiaUserID'];
    newUser = json['newUser'];
    style = json['style'];
    emailVerifiedAt = json['email_verified_at'];
    accessToken = json['access_token'];
    userType = json['user_type'];
    paymentAccountId = json['payment_account_id'];
    subPaymenyAccountId = json['sub_paymeny_account_id'];
    age = json['age'];
    profileImage = json['profileImage'].cast<String>();
    mBTI = json['MBTI'];
    authorizationToken = json['authorizationToken'];
    hasAlreadySignIN = json['hasAlreadySignIN'];
    paymentAccountAddress = json['payment_account_address'];
    userStatus = json['user_status'];
    walletId = json['wallet_id'];
    blockchain = json['blockchain'];
    lenguage = json['lenguage'];
    countryCode = json['country_code'];
    localZone = json['local_zone'];
    firstTimeLogin = json['first_time_login'];
    parentId = json['parent_id'];
    paymentType = json['payment_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appleAuthorizationCode'] = this.appleAuthorizationCode;
    data['appleIdentityToken'] = this.appleIdentityToken;
    data['appleUserIdentifier'] = this.appleUserIdentifier;
    data['appleGivenName'] = this.appleGivenName;
    data['appleFamilyName'] = this.appleFamilyName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['nickName'] = this.nickName;
    data['city'] = this.city;
    data['country'] = this.country;
    data['email'] = this.email;
    data['nuritopiaUserID'] = this.nuritopiaUserID;
    data['newUser'] = this.newUser;
    data['style'] = this.style;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['access_token'] = this.accessToken;
    data['user_type'] = this.userType;
    data['payment_account_id'] = this.paymentAccountId;
    data['sub_paymeny_account_id'] = this.subPaymenyAccountId;
    data['age'] = this.age;
    data['profileImage'] = this.profileImage;
    data['MBTI'] = this.mBTI;
    data['authorizationToken'] = this.authorizationToken;
    data['hasAlreadySignIN'] = this.hasAlreadySignIN;
    data['payment_account_address'] = this.paymentAccountAddress;
    data['user_status'] = this.userStatus;
    data['wallet_id'] = this.walletId;
    data['blockchain'] = this.blockchain;
    data['lenguage'] = this.lenguage;
    data['country_code'] = this.countryCode;
    data['local_zone'] = this.localZone;
    data['first_time_login'] = this.firstTimeLogin;
    data['parent_id'] = this.parentId;
    data['payment_type'] = this.paymentType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
