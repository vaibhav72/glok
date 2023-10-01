import 'package:get/get.dart';

import 'controller.dart';

class EndUserHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EndUserHomeController>(() => EndUserHomeController());
  }
}
