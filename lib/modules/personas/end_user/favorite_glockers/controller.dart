import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/repositories/glocker_repository.dart';

import '../../../../data/models/glocker_model.dart';

class FavoriteGlockersController extends GetxController {
  static FavoriteGlockersController get to =>
      Get.find<FavoriteGlockersController>();
  Rxn<List<GlockerModel>> favoriteGlockers = Rxn([]);
  Rxn<bool> isLoading = Rxn(false);
  Rxn<bool> isFetchingNext = Rxn(false);
  Rxn<bool> lastPage = Rxn(false);
  GlockerRepository glockerRepository = GlockerRepository();
  Rxn<int> page = Rxn(0);
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    getFavoriteGlockers();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 30) {
        // if (!isFetchingNext.value!) getNextTrendingGlockers();
      }
    });
  }

  getFavoriteGlockers() async {
    try {
      page.value = 1;
      lastPage.value = false;
      isLoading.value = true;
      favoriteGlockers.value = await glockerRepository.getGlockerList(
          filters: "favourite=true", index: 1);

      favoriteGlockers.refresh();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  getNextFavoriteGlockers() async {
    try {
      if (lastPage.value!) return;
      isFetchingNext.value = true;
      page.value = page.value! + 1;
      List<GlockerModel> newGlockerList = await glockerRepository
          .getGlockerList(filters: "favourite=true", index: page.value!);

      favoriteGlockers.refresh();
      if (newGlockerList.isNotEmpty) {
        favoriteGlockers.value!.addAll(newGlockerList);
      } else {
        lastPage.value = true;
      }
      isFetchingNext.value = false;
    } catch (e) {
      isFetchingNext.value = false;
    }
  }
}
