import 'package:get/get.dart';

import 'controller.dart';

class FavoriteGlockersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FavoriteGlockersController>(FavoriteGlockersController());
  }
}
