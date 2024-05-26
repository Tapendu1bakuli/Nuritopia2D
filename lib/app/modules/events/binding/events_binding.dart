import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/events_controller.dart';

class EventsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EventsController>(
          () => EventsController(),
    );
  }

}