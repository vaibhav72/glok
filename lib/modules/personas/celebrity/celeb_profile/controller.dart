import 'dart:io';

import 'package:get/get.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/gallery_repository.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/personas/celebrity/celeb_profile/video_view.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/models/gallery_model.dart';
import 'photo_view.dart';

class CelebrityProfileController extends GetxController {
  static CelebrityProfileController get to =>
      Get.find<CelebrityProfileController>();
  GlockerListController get glockerListController => GlockerListController.to;
  Rxn<GlockerModel>? get glocker => glockerListController.selectedGlocker;
  bool get isCurrentGlocker =>
      glockerListController.selectedGlocker.value?.id ==
      AuthController.to.glocker.value?.id;
  GalleryRepository galleryRepository = GalleryRepository();
  Rxn<GlockerModel> get data => glockerListController.selectedGlocker;
  Rxn<bool> loading = Rxn(false);
  Rxn<bool> isVideoPlaying = Rxn(false);
  Rxn<bool> galleryLoading = Rxn(false);
  Rxn<List<GalleryItem?>> galleryPhotos = Rxn([]);
  Rxn<List<GalleryItem?>> galleryVideos = Rxn([]);
  Rxn<XFile?> selectedFile = Rxn();
  ImagePicker picker = ImagePicker();
  Rxn<GalleryItem?> selectedGalleryItem = Rxn();
  Rxn<bool> isUploadPreview = Rxn(false);

  //video
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;
  void refreshVideo() {
    videoController.dispose();
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
    if (isUploadPreview.value!) {
      videoController = VideoPlayerController.file(
        File(selectedFile.value!.path),
      );
    } else {
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(selectedGalleryItem.value!.file!),
      );
    }

    initializeVideoPlayerFuture = videoController.initialize();
  }

  @override
  void onInit() {
    super.onInit();
    getGlockerData();
    getGallery();
  }

  getGlockerData() async {
    loading.value = true;
    await glockerListController.getSelectedGlockerData();
    loading.value = false;
  }

  getGallery() async {
    try {
      galleryLoading.value = true;
      galleryPhotos.value = await galleryRepository.getGlockerGallery(
          glockerId: glocker!.value!.id!, category: "photo", page: 1);
      galleryVideos.value = await galleryRepository.getGlockerGallery(
          glockerId: glocker!.value!.id!, category: "video", page: 1);
      galleryLoading.value = false;
    } catch (e) {
      showSnackBar(message: "Could not load gallery");
      galleryLoading.value = false;
    }
  }

  void addGalleryItem() async {
    bool? isVideo = await selectVideoOrPhoto();
    if (isVideo == null) return;
    await pickFile(isVideo);
  }

  pickFile(bool isVideo) async {
    ImageSource? source = await showImageSourceSelector();
    if (source == null) return;
    if (isVideo) {
      selectedFile.value = await picker.pickVideo(source: source);
      isUploadPreview.value = true;
      initVideo();
      Get.to(() => VideoView());
    } else {
      selectedFile.value = await picker.pickImage(source: source);
      isUploadPreview.value = true;
      Get.to(() => PhotoView());
    }
  }

  uploadVideo() async {
    try {
      loading.value = true;
      await galleryRepository.uploadVideo(selectedFile.value!);
      await getGallery();
      loading.value = false;
      Get.back();
      showSnackBar(message: "Video uploaded successfully", isError: false);
    } catch (e) {
      loading.value = false;
      showSnackBar(message: "$e");
    }
  }

  uploadPhoto() async {
    try {
      loading.value = true;
      await galleryRepository.uploadPhoto(selectedFile.value!);
      await getGallery();
      loading.value = false;
      Get.back();
      showSnackBar(message: "Photo uploaded successfully", isError: false);
    } catch (e) {
      loading.value = false;
      showSnackBar(message: "$e");
    }
  }

  void deleteGalleryItem() async {
    try {
      loading.value = true;
      await galleryRepository
          .deleteGalleryItem(selectedGalleryItem.value!.id!.toString());
      await getGallery();
      loading.value = false;
      Get.back();
      showSnackBar(message: "Item deleted successfully", isError: false);
    } catch (e) {
      loading.value = false;
      showSnackBar(message: "$e");
    }
  }

  void handleVideoBackButton() {
    refreshVideo();
    resetGalleryItem();
    Get.back();
  }

  resetGalleryItem() {
    isUploadPreview.value = false;
    selectedFile.value = null;
    selectedGalleryItem.value = null;
  }

  void handlePhotoBackButton() {
    resetGalleryItem();
    Get.back();
  }

  viewGalleryItem(GalleryItem item) {
    selectedGalleryItem.value = item;
    if (item.category == "video") {
      Get.to(() => VideoView());
    } else {
      Get.to(() => PhotoView());
    }
  }
}
