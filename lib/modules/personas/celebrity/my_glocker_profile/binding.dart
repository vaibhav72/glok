import 'package:get/get.dart';

import 'controller.dart';

class MyGlockerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MyGlockerProfileController>(MyGlockerProfileController());
  }
}
