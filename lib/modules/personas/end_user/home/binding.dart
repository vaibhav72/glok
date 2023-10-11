import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';

import 'controller.dart';

class EndUserHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EndUserHomeController>(() => EndUserHomeController());
    Get.put(GlockerListController());
  }
}
