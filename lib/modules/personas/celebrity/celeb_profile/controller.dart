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

  GalleryRepository galleryRepository = GalleryRepository();
  Rxn<GlockerModel> get data => glockerListController.selectedGlocker;
  Rxn<bool> loading = Rxn(false);
  Rxn<bool> galleryLoading = Rxn(false);
  Rxn<List<GalleryItem?>> galleryItems = Rxn([]);

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
      galleryItems.value = await galleryRepository.getMyGallery(1);
      galleryLoading.value = false;
    } catch (e) {
      showSnackBar(message: "Could not load gallery");
      galleryLoading.value = false;
    }
  }
}
