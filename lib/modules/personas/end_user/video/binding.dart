import 'package:get/get.dart';

import 'controller.dart';

class UserVideoCallBinding extends Bindings {
  String channel;
  String token;
  UserVideoCallBinding({required this.channel, required this.token});
  @override
  void dependencies() {
    Get.put<UserVideoCallController>(UserVideoCallController(
      channel: channel,
      token: token,
    ));
  }
}
