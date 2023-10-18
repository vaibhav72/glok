import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';

import '../../../wallet/binding.dart';
import '../browse/binding.dart';
import '../more/bindings.dart';
import 'controller.dart';

class EndUserHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EndUserHomeController>(EndUserHomeController());

    BrowseBinding().dependencies();
    EndUserMoreBinding().dependencies();
    Get.put(GlockerListController());
  }
}
