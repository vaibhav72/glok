import 'dart:io';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'controller.dart';

class MyVideoViewController extends GetxController {
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;
  MyGlockerProfileController get myGlockerProfileController =>
      MyGlockerProfileController.to;
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
    myGlockerProfileController.selectedFile.value = null;
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
    if (myGlockerProfileController.isUploadPreview.value!) {
      videoController = VideoPlayerController.file(
        File(myGlockerProfileController.selectedFile.value!.path),
      );
    } else {
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(myGlockerProfileController.selectedGalleryItem.value!.file!),
      );
    }

    initializeVideoPlayerFuture = videoController.initialize();
    loading.value = false;
  }
}
