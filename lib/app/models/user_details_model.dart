class UserDetailsModel {
  int? id;
  int? nouropiaUserID;
  String? nickName;
  String? firstName;
  Null? lastName;
  String? email;
  Null? emailVerifiedAt;
  String? style;
  int? age;
  String? country;
  String? profileImage;
  String? mBTI;
  String? authorizationToken;
  Null? walletId;
  int? hasAlreadySignIN;
  String? createdAt;
  String? updatedAt;

  UserDetailsModel(
      {this.id,
        this.nouropiaUserID,
        this.nickName,
        this.firstName,
        this.lastName,
        this.email,
        this.emailVerifiedAt,
        this.style,
        this.age,
        this.country,
        this.profileImage,
        this.mBTI,
        this.authorizationToken,
        this.walletId,
        this.hasAlreadySignIN,
        this.createdAt,
        this.updatedAt});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nouropiaUserID = json['nouropiaUserID'];
    nickName = json['nickName'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    style = json['style'];
    age = json['age'];
    country = json['country'];
    profileImage = json['profileImage'];
    mBTI = json['MBTI'];
    authorizationToken = json['authorizationToken'];
    walletId = json['walletId'];
    hasAlreadySignIN = json['hasAlreadySignIN'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nouropiaUserID'] = this.nouropiaUserID;
    data['nickName'] = this.nickName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['style'] = this.style;
    data['age'] = this.age;
    data['country'] = this.country;
    data['profileImage'] = this.profileImage;
    data['MBTI'] = this.mBTI;
    data['authorizationToken'] = this.authorizationToken;
    data['walletId'] = this.walletId;
    data['hasAlreadySignIN'] = this.hasAlreadySignIN;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
