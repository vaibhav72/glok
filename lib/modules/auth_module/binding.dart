import 'package:get/get.dart';
import 'package:glok/modules/auth_module/user_details_module/binding.dart';
import 'package:glok/modules/walkthrough/binding.dart';

import 'controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    WalkthroughBinding().dependencies();
    UserDetailsBinding().dependencies();
  }
}
