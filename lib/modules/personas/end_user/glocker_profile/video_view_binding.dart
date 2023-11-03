import 'package:get/get.dart';

import 'video_controller.dart';

class UserVideoViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserVideoViewController());
  }
}
