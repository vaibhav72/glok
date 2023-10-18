import 'package:get/get.dart';

import 'controller.dart';

class GlockerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GlockerProfileController>(GlockerProfileController());
  }
}
