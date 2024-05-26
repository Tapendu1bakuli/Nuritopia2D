
import 'package:nuritopia2d/app/models/parents/model.dart';

class GoogleLoginSendModel extends Model{
  String? idToken;

  GoogleLoginSendModel({this.idToken});

  GoogleLoginSendModel.fromJson(Map<String, dynamic> json) {
    idToken = json['idToken'];
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idToken'] = this.idToken;
    return data;
  }
}
