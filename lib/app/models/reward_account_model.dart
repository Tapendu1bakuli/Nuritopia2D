class RewardAccountModel {
  String? status;
  List<PaymentAccountTypesData>? paymentAccountTypesData;
  String? message;

  RewardAccountModel({this.status, this.paymentAccountTypesData, this.message});

  RewardAccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['paymentAccountTypesData'] != null) {
      paymentAccountTypesData = <PaymentAccountTypesData>[];
      json['paymentAccountTypesData'].forEach((v) {
        paymentAccountTypesData!.add(new PaymentAccountTypesData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.paymentAccountTypesData != null) {
      data['paymentAccountTypesData'] =
          this.paymentAccountTypesData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class PaymentAccountTypesData {
  int? id;
  String? paymentTypeName;
  String? paymentTypeDescription;
  String? logoPath;
  int? status;
  int? parrentId;
  bool? isExpanded;
 // List<Null>? mobileMoney;

  PaymentAccountTypesData(
      {this.id,
        this.paymentTypeName,
        this.paymentTypeDescription,
        this.logoPath,
        this.status,
        this.parrentId,
        this.isExpanded
      //  this.mobileMoney
      });

  PaymentAccountTypesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentTypeName = json['payment_type_name'];
    paymentTypeDescription = json['payment_type_description'];
    logoPath = json['logo_path'];
    status = json['status'];
    parrentId = json['parrent_id'];
    isExpanded = json['isExpanded'];
    // if (json['mobile_money'] != null) {
    //   mobileMoney = <Null>[];
    //   json['mobile_money'].forEach((v) {
    //     mobileMoney!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_type_name'] = this.paymentTypeName;
    data['payment_type_description'] = this.paymentTypeDescription;
    data['logo_path'] = this.logoPath;
    data['status'] = this.status;
    data['parrent_id'] = this.parrentId;
    // if (this.mobileMoney != null) {
    //   data['mobile_money'] = this.mobileMoney!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
