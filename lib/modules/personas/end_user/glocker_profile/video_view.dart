import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/glocker_profile/controller.dart';
import 'package:glok/modules/personas/end_user/glocker_profile/video_controller.dart';
import 'package:video_player/video_player.dart';

import '../../../../utils/helpers.dart';
import '../apply_glocker/view.dart';

class VideoView extends GetView<UserVideoViewController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(true);
      },
      child: Scaffold(
        body: Obx(
          () => controller.loading.value!
              ? Center(
                  child: Loader(),
                )
              : Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FutureBuilder(
                            future: controller.initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                // If the VideoPlayerController has finished initialization, use
                                // the data it provides to limit the aspect ratio of the video.
                                return InkWell(
                                  onTap: () {
                                    controller.playPauseVideo();
                                  },
                                  child: Stack(
                                    children: [
                                      VideoPlayer(
                                        controller.videoController,
                                      ),
                                      Obx(() => controller.isVideoPlaying.value!
                                          ? Container()
                                          : Center(
                                              child: Icon(
                                                Icons.play_arrow,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            )),
                                    ],
                                  ),
                                );
                              } else {
                                // If the VideoPlayerController is still initializing, show a
                                // loading spinner.
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        )),
                        if (controller
                            .glockerProfileController.isUploadPreview.value!)
                          CustomButton(
                              title: "Upload",
                              onPressed: () {
                                controller.glockerProfileController
                                    .uploadVideo();
                              })
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
                            if (controller.glockerProfileController
                                    .isCurrentGlocker &&
                                !controller.glockerProfileController
                                    .isUploadPreview.value!)
                              InkWell(
                                  onTap: () {
                                    controller.glockerProfileController
                                        .deleteGalleryItem();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
