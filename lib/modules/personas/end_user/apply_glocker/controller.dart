import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/glocker_repository.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ApplyToGlockerController extends GetxController {
  PageController pageController = PageController();
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
  final taxDetailsFormKey = GlobalKey<FormState>();
  Rxn<bool> isVideoPlaying = Rxn(false);
  //Tax info
  TextEditingController panController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController panNameController = TextEditingController();

  //adhaar
  Rxn<XFile?> adhaarFront = Rxn<XFile?>();
  Rxn<XFile?> adhaarBack = Rxn<XFile?>();

  //videoKyc
  Rxn<XFile?> videoKyc = Rxn<XFile?>();
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;

  ImagePicker picker = ImagePicker();

  RxBool isLoading = false.obs;
  validateAndProceedToTaxDetails() {
    if (basicDetailsFormKey.currentState!.validate()) {
      if (profileImage.value == null) {
        showSnackBar(message: "Please selet profile image");
        return;
      }
      if (coverImage.value == null) {
        showSnackBar(message: "Please selet cover image");
        return;
      }
      pageController.nextPage(
          duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    }
  }

  validateTaxDetailsAndApply() async {
    if (taxDetailsFormKey.currentState!.validate()) {
      await applyToGlocker();
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

  pickAadharFront() async {
    ImageSource? source = await showImageSourceSelector();
    if (source == null) return;
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      adhaarFront.value = pickedFile;
    }
  }

  pickAadharBack() async {
    ImageSource? source = await showImageSourceSelector();
    if (source == null) return;
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      adhaarBack.value = pickedFile;
    }
  }

  pickVideoKyc() async {
    ImageSource? source = await showImageSourceSelector();
    if (source == null) return;
    final pickedFile = await picker.pickVideo(source: source);
    if (pickedFile != null) {
      videoController = VideoPlayerController.file(
        File(pickedFile.path),
      );
      initializeVideoPlayerFuture = videoController.initialize();
      videoKyc.value = pickedFile;
    }
  }

  applyToGlocker() async {
    try {
      isLoading.value = true;
      await _glockerRepository.applyAsGlocker(
        params: {
          "name": nameController.text,
          "price": rateController.text,
          "about_me": aboutMeController.text,
          "category": selectedCategory.value!,
          "pan_number": panController.text,
          if (gstController.text.isNotEmpty) "gst": gstController.text,
          "name_as_per_pan": panNameController.text,
        },
        profileImage: profileImage.value!,
        coverImage: coverImage.value!,
      );
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showSnackBar(message: "${e}");
    }
  }

  addAadhaar() async {
    try {
      if (adhaarFront.value == null) {
        showSnackBar(message: "Please select adhaar front image");
        return;
      }
      if (adhaarBack.value == null) {
        showSnackBar(message: "Please select adhaar back image");
        return;
      }
      isLoading.value = true;
      await _glockerRepository.updateGlockerAdhaarPhotos(
        aadhaarFront: adhaarFront.value!,
        aadhaarBack: adhaarBack.value!,
      );
      pageController.nextPage(
          duration: Duration(milliseconds: 100), curve: Curves.easeIn);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showSnackBar(message: "${e}");
    }
  }

  updateVideoKYC() async {
    try {
      if (videoKyc.value == null) {
        showSnackBar(message: "Please select video");
        return;
      }
      isLoading.value = true;
      await _glockerRepository.updateGlockerVideoKYC(
        video: videoKyc.value!,
      );
      isLoading.value = false;
      pageController.nextPage(
          duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    } catch (e) {
      isLoading.value = false;
      showSnackBar(message: "${e}");
    }
  }

  void refreshVideo() {
    videoController.dispose();
    videoKyc.value = null;
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
}
