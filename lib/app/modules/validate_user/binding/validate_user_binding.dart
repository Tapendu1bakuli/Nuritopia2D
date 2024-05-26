import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:nuritopia2d/app/modules/validate_user/controller/validate_user_controller.dart';

class ValidateUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValidateUserController>(
          () => ValidateUserController(),
    );
  }
}
