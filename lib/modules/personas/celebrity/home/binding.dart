import 'package:get/get.dart';
import 'package:glok/modules/personas/celebrity/my_glocker_profile/binding.dart';
import 'package:glok/modules/personas/celebrity/my_glocker_profile/controller.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';

import '../../../wallet/binding.dart';

import '../more/bindings.dart';
import 'controller.dart';

class GlockerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GlockerHomeController>(GlockerHomeController());
    MyGlockerProfileBinding().dependencies();
    GlockerMoreBinding().dependencies();
  }
}
