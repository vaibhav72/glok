import 'package:get/get.dart';

import 'controller.dart';

class GlockerMoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GlockerMoreController());
  }
}
