import 'package:get/get.dart';

import 'controller.dart';

class CelebrityProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CelebrityProfileController>(() => CelebrityProfileController());
  }
}