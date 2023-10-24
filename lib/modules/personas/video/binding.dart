import 'package:get/get.dart';

import 'controller.dart';

class VideoCallBinding extends Bindings {
  String channel;
  String token;
  VideoCallBinding({required this.channel, required this.token});
  @override
  void dependencies() {
    Get.put<VideoCallController>(VideoCallController(
      channel: channel,
      token: token,
    ));
  }
}
