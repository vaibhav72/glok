import 'package:get/get.dart';

import 'controller.dart';

class EndUserMoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EndUserMoreController());
  }
}
