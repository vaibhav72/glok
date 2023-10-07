import 'package:get/get.dart';

import 'controller.dart';

class ApplyToGlockerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApplyToGlockerController());
  }
}
