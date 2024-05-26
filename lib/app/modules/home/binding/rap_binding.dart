import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/challange_controller.dart';

class RapBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChallengeController>(
          () => ChallengeController(),
    );
  }

}