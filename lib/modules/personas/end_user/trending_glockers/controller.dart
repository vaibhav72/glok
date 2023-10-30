import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/repositories/glocker_repository.dart';

import '../../../../data/models/glocker_model.dart';

class TrendingGlockersController extends GetxController {
  static TrendingGlockersController get to =>
      Get.find<TrendingGlockersController>();
  Rxn<List<GlockerModel>> trendingGlockers = Rxn([]);
  Rxn<bool> isLoading = Rxn(false);
  Rxn<bool> isFetchingNext = Rxn(false);
  Rxn<bool> lastPage = Rxn(false);
  GlockerRepository glockerRepository = GlockerRepository();
  Rxn<int> page = Rxn(0);
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    getTrendingGlockers();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 30) {
        // if (!isFetchingNext.value!) getNextTrendingGlockers();
      }
    });
  }

  getTrendingGlockers() async {
    try {
      page.value = 1;
      lastPage.value = false;
      isLoading.value = true;
      trendingGlockers.value = await glockerRepository.getTrendingGlockerList();

      trendingGlockers.refresh();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  getNextTrendingGlockers() async {
    try {
      if (lastPage.value!) return;
      isFetchingNext.value = true;
      page.value = page.value! + 1;
      List<GlockerModel> newGlockerList =
          await glockerRepository.getTrendingGlockerList(index: page.value!);

      trendingGlockers.refresh();
      if (newGlockerList.isNotEmpty) {
        trendingGlockers.value!.addAll(newGlockerList);
      } else {
        lastPage.value = true;
      }
      isFetchingNext.value = false;
    } catch (e) {
      isFetchingNext.value = false;
    }
  }
}
