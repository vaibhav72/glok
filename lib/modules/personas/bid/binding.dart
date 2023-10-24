import 'package:get/get.dart';

import 'controller.dart';

class GlockerBiddingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GlockerBiddingController>(GlockerBiddingController());
  }
}
