import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../controller/voting_controller.dart';


class VoteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VotingController>(
          () => VotingController(),
    );
  }

}