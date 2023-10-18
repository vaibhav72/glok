import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/gallery_repository.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/personas/end_user/glocker_profile/video_view.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/models/gallery_model.dart';
import '../../../../data/repositories/glocker_repository.dart';
import 'photo_view.dart';

class MyGlockerProfileController extends GetxController {
  static MyGlockerProfileController get to =>
      Get.find<MyGlockerProfileController>();
  bool get isCurrentGlocker => true;

  GalleryRepository galleryRepository = GalleryRepository();
  AuthController get authController => AuthController.to;
  GlockerRepository _glockerRepository = GlockerRepository();
  Rxn<GlockerModel> get glocker => authController.glocker;
  TextEditingController nameController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  Rxn<String> selectedCategory = Rxn<String>();
  Rxn<XFile?> profileImage = Rxn<XFile?>();
  Rxn<XFile?> coverImage = Rxn<XFile?>();
  final basicDetailsFormKey = GlobalKey<FormState>();
  Rxn<bool> loading = Rxn(false);
  Rxn<bool> isVideoPlaying = Rxn(false);
  Rxn<bool> galleryLoading = Rxn(false);
  Rxn<List<GalleryItem?>> galleryPhotos = Rxn([]);
  Rxn<List<GalleryItem?>> galleryVideos = Rxn([]);
  Rxn<XFile?> selectedFile = Rxn();
  ImagePicker picker = ImagePicker();
  Rxn<GalleryItem?> selectedGalleryItem = Rxn();
  Rxn<bool> isUploadPreview = Rxn(false);
  bool get isChanged {
    return isDataChanged ||
        profileImage.value != null ||
        coverImage.value != null;
  }

  bool get isDataChanged =>
      nameController.text != glocker()!.name ||
      rateController.text != glocker()!.price.toString() ||
      aboutMeController.text != glocker()!.aboutMe ||
      selectedCategory.value != glocker()!.category;

  initProfileData() {
    nameController.text = glocker.value!.name ?? '';
    rateController.text = glocker.value!.price.toString() ?? '';
    aboutMeController.text = glocker.value!.aboutMe ?? '';
    selectedCategory.value = glocker.value!.category ?? '';
  }

  updateGlockerData() async {
    try {
      if (!isChanged) {
        return;
      }
      if (basicDetailsFormKey.currentState!.validate()) {
        loading.value = true;
        if (isDataChanged) {
          await _glockerRepository.updateGlockerDetails(glocker.value!.copyWith(
            name: nameController.text,
            price: int.parse(rateController.text.trim()),
            aboutMe: aboutMeController.text,
            category: selectedCategory.value,
          ));
        }
        if (profileImage.value != null) {
          await _glockerRepository.updateGlockerProfile(profileImage.value!);
          loading.value = false;
          profileImage.value = null;
        }
        if (coverImage.value != null) {
          await _glockerRepository.updateGlockerCover(coverImage.value!);
          loading.value = false;
          coverImage.value = null;
        }
        await AuthController.to.getGlockerDetails();
        loading.value = false;
        showSnackBar(message: "Glocker Details updated", isError: false);
        return;
      }
    } catch (e) {
      loading.value = false;
      showSnackBar(message: "$e");
    }
  }

  pickProfileImage() async {
    ImageSource? source = await showImageSourceSelector();
    if (source == null) return;
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      profileImage.value = pickedFile;
    }
  }

  pickCoverImage() async {
    ImageSource? source = await showImageSourceSelector();
    if (source == null) return;
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      coverImage.value = pickedFile;
    }
  }

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
