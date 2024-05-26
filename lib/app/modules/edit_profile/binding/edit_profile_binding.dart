import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(
          () => EditProfileController(),
    );
  }

}