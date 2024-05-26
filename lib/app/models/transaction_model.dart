class TransactionModel {
  int? httpcode;
  String? status;
  List<TransactionList>? data;

  TransactionModel({this.httpcode, this.status, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    httpcode = json['httpcode'];
    status = json['status'];
    if (json['data'] != null) {
      data = <TransactionList>[];
      json['data'].forEach((v) {
        data!.add(new TransactionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['httpcode'] = this.httpcode;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionList {
  String? transactionId;
  int? id;
  String? userId;
  int? amount;
  String? status;
  String? paymentStatus;
  String? message;
  String? createdAt;
  String? updatedAt;

  TransactionList(
      {this.transactionId,
        this.id,
        this.userId,
        this.amount,
        this.status,
        this.paymentStatus,
        this.message,
        this.createdAt,
        this.updatedAt});

  TransactionList.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    id = json['id'];
    userId = json['userId'];
    amount = json['amount'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    message = json['message'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['paymentStatus'] = this.paymentStatus;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
