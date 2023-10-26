import 'package:get/get.dart';

import 'controller.dart';

class GlockerVideoCallBinding extends Bindings {
  String channel;
  String token;
  GlockerVideoCallBinding({required this.channel, required this.token});
  @override
  void dependencies() {
    Get.put<GlockerVideoCallController>(GlockerVideoCallController(
      channel: channel,
      token: token,
    ));
  }
}
