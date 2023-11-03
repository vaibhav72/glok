import 'dart:io';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'controller.dart';

class UserVideoViewController extends GetxController {
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;
  GlockerProfileController get glockerProfileController =>
      GlockerProfileController.to;
  Rxn<bool> loading = Rxn(false);
  Rxn<bool> isVideoPlaying = Rxn(false);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initVideo();
  }

  @override
  void onClose() {
    glockerProfileController.selectedFile.value = null;
    refreshVideo();
    super.onClose();
  }

  void refreshVideo() {
    initializeVideoPlayerFuture = Future(() => null);
    if (videoController.value.isInitialized) videoController.dispose();
  }

  void playPauseVideo() {
    if (videoController.value.isPlaying) {
      isVideoPlaying.value = false;
      videoController.pause();
    } else {
      isVideoPlaying.value = true;
      videoController.play();
    }
  }

  void initVideo() async {
    loading.value = true;
    if (glockerProfileController.isUploadPreview.value!) {
      videoController = VideoPlayerController.file(
        File(glockerProfileController.selectedFile.value!.path),
      );
    } else {
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(glockerProfileController.selectedGalleryItem.value!.file!),
      );
    }

    initializeVideoPlayerFuture = videoController.initialize();
    loading.value = false;
  }
}
