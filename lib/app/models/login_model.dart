class LoginModel {
  int? id;
  String? appleAuthorizationCode;
  String? appleIdentityToken;
  String? appleUserIdentifier;
  String? appleGivenName;
  String? appleFamilyName;
  String? firstName;
  String? lastName;
  String? nickName;
  String? city;
  String? country;
  String? email;
  String? nuritopiaUserID;
  int? newUser;
  String? style;
  String? emailVerifiedAt;
  String? accessToken;
  int? userType;
  String? paymentAccountId;
  String? subPaymenyAccountId;
  String? age;
  List<String>? profileImage;
  String? mBTI;
  String? authorizationToken;
  int? hasAlreadySignIN;
  String? paymentAccountAddress;
  int? userStatus;
  String? walletId;
  String? blockchain;
  String? lenguage;
  String? countryCode;
  String? localZone;
  int? firstTimeLogin;
  int? parentId;
  String? paymentType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? hasRefer;
  String? nuritopiaAuthorizationToken;
  String? nuritopiaRefreshToken;
  ReferBy? referBy;

  LoginModel(
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
        this.deletedAt,
        this.hasRefer,
        this.nuritopiaAuthorizationToken,
        this.nuritopiaRefreshToken,
        this.referBy});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appleAuthorizationCode = json['appleAuthorizationCode']?? "";
    appleIdentityToken = json['appleIdentityToken']?? "";
    appleUserIdentifier = json['appleUserIdentifier']?? "";
    appleGivenName = json['appleGivenName']?? "";
    appleFamilyName = json['appleFamilyName']?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name']?? "";
    nickName = json['nickName']?? "";
    city = json['city']?? "";
    country = json['country']?? "";
    email = json['email']?? "";
    nuritopiaUserID = json['nuritopiaUserID']?? "";
    newUser = json['newUser']?? "";
    style = json['style']?? "";
    emailVerifiedAt = json['email_verified_at']?? "";
    accessToken = json['access_token']?? "";
    userType = json['user_type']?? 0;
    paymentAccountId = json['payment_account_id']?? "";
    subPaymenyAccountId = json['sub_paymeny_account_id']?? "";
    age = json['age']?? "";
    profileImage = json['profileImage'].cast<String>() ?? [];
    mBTI = json['MBTI']?? "";
    authorizationToken = json['authorizationToken']?? "";
    hasAlreadySignIN = json['hasAlreadySignIN']?? "";
    paymentAccountAddress = json['payment_account_address']?? "";
    userStatus = json['user_status']?? "";
    walletId = json['wallet_id']?? "";
    blockchain = json['blockchain']?? "";
    lenguage = json['lenguage']?? "";
    countryCode = json['country_code']?? "";
    localZone = json['local_zone']?? "";
    firstTimeLogin = json['first_time_login']?? "";
    parentId = json['parent_id']?? "";
    paymentType = json['payment_type']?? "";
    createdAt = json['created_at']?? "";
    updatedAt = json['updated_at']?? "";
    deletedAt = json['deleted_at']?? "";
    hasRefer = json['hasRefer']?? false;
    nuritopiaAuthorizationToken = json['nuritopiaAuthorizationToken'];
    nuritopiaRefreshToken = json['nuritopiaRefreshToken'];
    referBy = json['refer_by'] != null
        ? new ReferBy.fromJson(json['refer_by'])
        : null;
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
    data['hasRefer'] = this.hasRefer;
    data['nuritopiaAuthorizationToken'] = this.nuritopiaAuthorizationToken;
    data['nuritopiaRefreshToken'] = this.nuritopiaRefreshToken;
    if (this.referBy != String) {
      data['refer_by'] = this.referBy!.toJson();
    }
    return data;
  }
}

class ReferBy {
  int? id;
  int? userId;
  String? referralCode;
  int? referBy;
  String? createdAt;
  String? updatedAt;

  ReferBy(
      {this.id,
        this.userId,
        this.referralCode,
        this.referBy,
        this.createdAt,
        this.updatedAt});

  ReferBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    referralCode = json['referral_code'];
    referBy = json['refer_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['referral_code'] = this.referralCode;
    data['refer_by'] = this.referBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
