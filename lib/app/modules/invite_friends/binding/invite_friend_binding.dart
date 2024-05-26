import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/invite_friend_controller.dart';

class InviteFriendBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<InviteFriendController>(
          () => InviteFriendController(),
    );
  }

}