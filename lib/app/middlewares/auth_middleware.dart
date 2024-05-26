import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
import '../services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    return null;
  }
}
