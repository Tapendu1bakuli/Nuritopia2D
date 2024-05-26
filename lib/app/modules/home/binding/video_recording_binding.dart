import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/video_recording_controller.dart';

class VideoRecordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VideoRecordingController>(
          () => VideoRecordingController(),
    );
  }

}