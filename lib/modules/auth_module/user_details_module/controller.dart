import 'package:get/get.dart';
import 'package:glok/modules/auth_module/controller.dart';

class UserDetailsController extends GetxController{
  static UserDetailsController get to => Get.find<UserDetailsController>();
  final AuthController authController = AuthController.to;
  @override
  void onInit() {}
}