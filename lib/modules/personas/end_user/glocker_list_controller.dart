import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/glocker_repository.dart';

class GlockerListController extends GetxController {
  GlockerRepository glockerRepository = GlockerRepository();
  static GlockerListController get to => Get.find<GlockerListController>();
  Rxn<List<GlockerModel>> currentGlockers = Rxn([]);
  Rxn<List<GlockerModel>> trendingGlockers = Rxn([]);
  Rxn<String> searchText = Rxn("");
  Rxn<String> currentCategory = Rxn("Movie Star");
  Rxn<bool> searching = Rxn(false);
  Rxn<bool> showOnline = Rxn(false);
  List<String> sortByList = ["Popular", "Lowest Price", "Highest Price"];
  Rxn<String> sortBy = Rxn("Popular");
  Rxn<List<String>> selectedFilters = Rxn([]);
  Rxn<String> currentFilterString = Rxn("");
  Rxn<int> page = Rxn(1);

  List<String> priceList = [
    "Below \u20b9 499",
    "\u20b9 999 - \u20b9 1999",
    "\u20b9 1999 - \u20b9 2999",
    "\u20b9 2999 - \u20b9 3999",
    "\u20b9 1999 - \u20b9 4999",
    "Above \u20b9 4999"
  ];

  @override
  void onInit() {
    super.onInit();
    getGlockerList();
    getGlockerTrendingList();
  }

  getGlockerList() async {
    try {
      currentFilterString.value =
          "${currentCategory.value!.isNotEmpty ? 'category=${currentCategory.value}' : ''}${searching.value! ? '&search=${searchText.value}' : ''}${sortBy.value != '' ? '&sortby=${sortBy.value!.toLowerCase()}' : ''}";
      currentGlockers.value = await glockerRepository.getGlockerList(
          filters: currentFilterString.value);
    } catch (e) {
      log("$e");
    }
  }

  getGlockerTrendingList() async {
    try {
      currentGlockers.value!
          .addAll(await glockerRepository.getTrendingGlockerList());
    } catch (e) {
      log("$e");
    }
  }

  fetchNext() async {
    try {
      page.value = page.value! + 1;
      currentFilterString.value =
          "${currentCategory.value!.isNotEmpty ? 'category=${currentCategory.value}' : ''}${searching.value! ? '&search=${searchText.value}' : ''}${sortBy.value != '' ? 'sortby=${sortBy.value!.toLowerCase()}' : ''}";
      currentGlockers.value!.addAll(await glockerRepository.getGlockerList(
          filters: currentFilterString.value));
    } catch (e) {
      log("$e");
    }
  }

  void changeCategory(String pageTitle) {
    currentCategory.value = pageTitle;
    getGlockerList();
  }
}
