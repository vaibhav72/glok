import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/browse/celeb_by_category/controller.dart';

class CelebByCategoryBiding extends Bindings {
  @override
  void dependencies() {
    Get.put(CelebByCategoryController());
  }
}
