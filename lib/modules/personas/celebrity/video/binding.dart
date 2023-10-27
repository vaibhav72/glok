import 'package:get/get.dart';

import 'controller.dart';

class GlockerVideoCallBinding extends Bindings {
  String channel;
  String token;
  int? userId;
  GlockerVideoCallBinding(
      {required this.channel, required this.token, this.userId = 0});
  @override
  void dependencies() {
    Get.put<GlockerVideoCallController>(GlockerVideoCallController(
      channel: channel,
      token: token,
      userId: userId!,
    ));
  }
}
