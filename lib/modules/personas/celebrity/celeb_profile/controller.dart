import 'package:get/get.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/gallery_repository.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/utils/helpers.dart';

import '../../../../data/models/gallery_model.dart';

class CelebrityProfileController extends GetxController {
  static CelebrityProfileController get to =>
      Get.find<CelebrityProfileController>();
  GlockerListController get glockerListController => GlockerListController.to;
  GlockerModel? get glocker => glockerListController.selectedGlocker.value;
  GalleryRepository galleryRepository = GalleryRepository();
  Rxn<GlockerModel> get data => glockerListController.selectedGlocker;
  Rxn<bool> loading = Rxn(false);
  Rxn<bool> galleryLoading = Rxn(false);
  Rxn<List<GalleryItem?>> galleryPhotos = Rxn([]);
  Rxn<List<GalleryItem?>> galleryVideos = Rxn([]);

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
          glockerId: 1, category: "photo", page: 1);
      galleryVideos.value = await galleryRepository.getGlockerGallery(
          glockerId: 1, category: "video", page: 1);
      galleryLoading.value = false;
    } catch (e) {
      showSnackBar(message: "Could not load gallery");
      galleryLoading.value = false;
    }
  }
}
