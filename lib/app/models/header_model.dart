import 'package:meta/meta.dart';

class HeaderModel {
  HeaderModel({
    @required this.token,
    @required this.nuritopiaToken
  });

  final String? token;
  final String? nuritopiaToken;

  factory HeaderModel.fromJson(Map<String, String> json) => HeaderModel(
    token: json["Authorization"],
    nuritopiaToken: json["nuritopiaAuthorizationToken"],
  );

  Map<String, String> toHeader() => {
    "Authorization": token!,
    "nuritopiaAuthorizationToken": nuritopiaToken!,
  };
}