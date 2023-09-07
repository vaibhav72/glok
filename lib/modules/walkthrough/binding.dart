import 'package:get/get.dart';

import 'controller.dart';

class WalkthroughBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalkthroughController>(() => WalkthroughController());
  }
}