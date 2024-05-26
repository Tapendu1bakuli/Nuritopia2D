class GetWalletDetailsModel {
  String? status;
  Data? data;
  String? message;

  GetWalletDetailsModel({this.status, this.data, this.message});

  GetWalletDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? walletBallence;
  int? maxTransfer;
  int? minTransfer;
  int? maxTopup;
  int? minTopup;
  int? tosToken;
  int? usd;
  String? walletID;
  List<Null>? benefesheryUserList;

  Data(
      {this.walletBallence,
        this.maxTransfer,
        this.minTransfer,
        this.maxTopup,
        this.minTopup,
        this.tosToken,
        this.usd,
        this.walletID,
        this.benefesheryUserList});

  Data.fromJson(Map<String, dynamic> json) {
    walletBallence = json['wallet_ballence'];
    maxTransfer = json['max_transfer'];
    minTransfer = json['min_transfer'];
    maxTopup = json['max_topup'];
    minTopup = json['min_topup'];
    tosToken = json['tos_token'];
    usd = json['usd'];
    walletID = json['Wallet ID'];
    // if (json['benefeshery_user_list'] != null) {
    //   benefesheryUserList = <Null>[];
    //   json['benefeshery_user_list'].forEach((v) {
    //     benefesheryUserList!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_ballence'] = this.walletBallence;
    data['max_transfer'] = this.maxTransfer;
    data['min_transfer'] = this.minTransfer;
    data['max_topup'] = this.maxTopup;
    data['min_topup'] = this.minTopup;
    data['tos_token'] = this.tosToken;
    data['usd'] = this.usd;
    data['Wallet ID'] = this.walletID;
    // if (this.benefesheryUserList != null) {
    //   data['benefeshery_user_list'] =
    //       this.benefesheryUserList!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
