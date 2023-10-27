import 'package:get/get.dart';

import 'controller.dart';

class UserVideoCallBinding extends Bindings {
  String channel;
  String token;
  int? userId;
  UserVideoCallBinding(
      {required this.channel, required this.token, this.userId = 0});
  @override
  void dependencies() {
    Get.put<UserVideoCallController>(UserVideoCallController(
        channel: channel, token: token, userId: userId));
  }
}
