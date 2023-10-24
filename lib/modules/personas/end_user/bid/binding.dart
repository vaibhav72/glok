import 'package:get/get.dart';

import 'controller.dart';

class UserBiddingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserBiddingController>(UserBiddingController());
  }
}
