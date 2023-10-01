import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/browse/controller.dart';

class BrowseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BrowseController());
  }
}
