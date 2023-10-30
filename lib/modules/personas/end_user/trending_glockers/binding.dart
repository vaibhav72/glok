import 'package:get/get.dart';

import 'controller.dart';

class TrendingGlockersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TrendingGlockersController>(TrendingGlockersController());
  }
}
