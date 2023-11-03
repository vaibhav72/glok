import 'package:get/get.dart';

import 'video_controller.dart';

class MyVideoViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyVideoViewController());
  }
}
