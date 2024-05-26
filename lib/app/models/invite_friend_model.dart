class InviteFriendModel {
  String? qrCode;
  int? httpcode;
  String? status;
  String? message;
  String? referralCode;
  Null? rewardDescription;
  String? urlToGoogleAppStore;
  String? urlToAppleAppStore;
  String? qrCodeImage;
  List<String>? RewardPoints;

  InviteFriendModel(
      {this.qrCode,
        this.httpcode,
        this.status,
        this.message,
        this.referralCode,
        this.rewardDescription,
        this.urlToGoogleAppStore,
        this.urlToAppleAppStore,
        this.qrCodeImage,
        this.RewardPoints});

  InviteFriendModel.fromJson(Map<String, dynamic> json) {
    qrCode = json['qrCode'];
    httpcode = json['httpcode'];
    status = json['status'];
    message = json['message'];
    referralCode = json['referralCode'];
    rewardDescription = json['rewardDescription'];
    urlToGoogleAppStore = json['urlToGoogleAppStore'];
    urlToAppleAppStore = json['urlToAppleAppStore'];
    qrCodeImage = json['qrCodeImage'];
    RewardPoints = json['RewardPoints'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qrCode'] = this.qrCode;
    data['httpcode'] = this.httpcode;
    data['status'] = this.status;
    data['message'] = this.message;
    data['referralCode'] = this.referralCode;
    data['rewardDescription'] = this.rewardDescription;
    data['urlToGoogleAppStore'] = this.urlToGoogleAppStore;
    data['urlToAppleAppStore'] = this.urlToAppleAppStore;
    data['qrCodeImage'] = this.qrCodeImage;
    data['RewardPoints'] = this.RewardPoints;
    return data;
  }
}
