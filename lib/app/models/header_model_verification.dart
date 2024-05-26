import 'package:meta/meta.dart';

class HeaderModelVerification {
  HeaderModelVerification(
      {@required this.token, @required this.nuritopiaToken});

  final String? token;
  final String? nuritopiaToken;

  factory HeaderModelVerification.fromJson(Map<String, String> json) =>
      HeaderModelVerification(
        token: json["Authorization"],
        nuritopiaToken: json["nuritopiaAuthorizationToken"],
      );

  Map<String, String> toHeader() => {
        "Authorization": token!,
        "nuritopiaAuthorizationToken": nuritopiaToken!,
      };
}
