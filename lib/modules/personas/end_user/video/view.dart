import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/video/controller.dart';

import '../../../../utils/meta_assets.dart';
import '../../../../utils/meta_colors.dart';
import '../apply_glocker/view.dart';

class UserVideoView extends GetView<UserVideoCallController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.loading.value!
            ? Center(
                child: Loader(),
              )
            : Stack(children: [
                Center(
                  child: _remoteVideo(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.red,
                            width: 110,
                            height: 140,
                            child: Center(
                              child: AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: controller.engine!,
                                  canvas: const VideoCanvas(uid: 0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: SvgPicture.asset(MetaAssets.swapCamera),
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: MetaColors.transactionFailed,
                            child: SvgPicture.asset(MetaAssets.endCall),
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: SvgPicture.asset(MetaAssets.mic),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: MediaQuery.of(context).padding,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black12,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ))
              ]),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (controller != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: controller.engine!,
          canvas: VideoCanvas(uid: controller.remoteUid.value ?? 1),
          connection: RtcConnection(channelId: controller.channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
