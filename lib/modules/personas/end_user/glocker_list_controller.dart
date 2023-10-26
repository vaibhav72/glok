import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/glocker_repository.dart';
import 'package:glok/utils/helpers.dart';
import 'package:http/http.dart';

import 'glocker_profile/binding.dart';
import 'glocker_profile/view.dart';

class GlockerListController extends GetxController {
  GlockerRepository glockerRepository = GlockerRepository();
  static GlockerListController get to => Get.find<GlockerListController>();
  Rxn<GlockerModel> selectedGlocker = Rxn();
  RxList<GlockerModel> currentGlockers = RxList([]);
  RxList<GlockerModel> trendingGlockers = RxList([]);
  RxList<GlockerModel> favoriteGlockers = RxList([]);
  Rxn<String> searchText = Rxn("");
  Rxn<String> currentCategory = Rxn("Movie Star");
  Rxn<bool> searching = Rxn(false);
  Rxn<bool> showOnline = Rxn(false);
  Rxn<bool> appliedShowOnline = Rxn(false);
  List<String> sortByList = ["Popular", "Lowest Price", "Highest Price"];
  Rxn<String> sortBy = Rxn("Lowest Price");
  Rxn<String> appliedSortBy = Rxn("Lowest Price");
  Rxn<List<String>> selectedFilters = Rxn([]);
  Rxn<List<String>> appliedFilters = Rxn([]);
  Rxn<String> currentFilterString = Rxn("");
  Rxn<int> page = Rxn(1);
  Rxn<double> minPrice = Rxn(499);
  Rxn<double> maxPrice = Rxn(4999);
  Rxn<double> appliedMinPrice = Rxn(499);
  Rxn<double> appliedMaxPrice = Rxn(4999);
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
    initData();
  }

  initData() {
    getGlockerList();
    getGlockerTrendingList();
  }

  applyFilters() {
    appliedFilters.value = selectedFilters.value;
    appliedShowOnline.value = showOnline.value;
    appliedSortBy.value = sortBy.value;
    appliedMinPrice.value = minPrice.value;
    appliedMaxPrice.value = maxPrice.value;
    getGlockerList();
    Get.back();
  }

  clearFilters() {
    clearFiltersValues();
    getGlockerList();
    Get.back();
  }

  clearFiltersValues() {
    appliedFilters.value = [];
    selectedFilters.value = [];
    appliedShowOnline.value = false;
    showOnline.value = false;
    appliedSortBy.value = "";
    sortBy.value = "";
    minPrice.value = 499;
    maxPrice.value = 4999;
    appliedMinPrice.value = null;
    appliedMaxPrice.value = null;
  }

  getGlockerList() async {
    try {
      currentFilterString.value =
          "${currentCategory.value!.isNotEmpty ? 'category=${currentCategory.value}' : ''}${searching.value! ? '&search=${searchText.value}' : ''}${appliedSortBy.value != '' ? '&sortby=${appliedSortBy.value!.toLowerCase().trim()}' : ''}${appliedMinPrice.value != null && appliedMaxPrice.value != null ? "&minprice=${appliedMinPrice.value!.toInt()}&maxprice=${appliedMaxPrice.value!.toInt()}" : ''}";
      currentGlockers.value = await glockerRepository.getGlockerList(
          filters: currentFilterString.value, index: 1);
      currentGlockers.refresh();
    } catch (e) {
      log("$e");
    }
  }

  getFavoriteList() async {
    try {
      favoriteGlockers.value = await glockerRepository.getGlockerList(
          filters: "avorite=true", index: 1);
      favoriteGlockers.refresh();
    } catch (e) {
      log("$e");
    }
  }

  getGlockerTrendingList() async {
    try {
      trendingGlockers.value = await glockerRepository.getTrendingGlockerList();

      trendingGlockers.refresh();
    } catch (e) {
      log("$e");
    }
  }

  fetchNext() async {
    try {
      page.value = page.value! + 1;
      currentFilterString.value =
          "${currentCategory.value!.isNotEmpty ? 'category=${currentCategory.value}' : ''}${searching.value! ? '&search=${searchText.value}' : ''}${appliedSortBy.value != '' ? '&sortby=${appliedSortBy.value!.toLowerCase()}' : ''} ${appliedMinPrice.value != null && appliedMaxPrice.value != null ? "&minprice=${appliedMinPrice.value}&maxprice=${appliedMaxPrice.value}" : ''}";
      currentGlockers.addAll(await glockerRepository.getGlockerList(
          filters: currentFilterString.value, index: page.value));
      currentGlockers.refresh();
    } catch (e) {
      log("$e");
    }
  }

  void changeCategory(String pageTitle) async {
    currentCategory.value = pageTitle;
    await getGlockerList();
    await getGlockerTrendingList();
    refresh();
  }

  void viewGlocker(GlockerModel data) {
    selectedGlocker.value = data;
    Get.to(() => GlockerProfileView(), binding: GlockerProfileBinding());
  }

  getSelectedGlockerData() async {
    try {
      selectedGlocker.value = await glockerRepository
          .getGlockerDetailsById(selectedGlocker.value!.id!);
      return;
    } catch (e) {
      showSnackBar(message: "$e");
      return;
    }
  }

  handleFavourite(GlockerModel model, RefreshEnum refreshEnum) async {
    try {
      await glockerRepository.favorite(model.id!);

      if (refreshEnum == RefreshEnum.refreshAllGlockers) {
        await getFavoriteList();
        await getGlockerList();
        await getGlockerTrendingList();
        await getSelectedGlockerData();
      } else {
        if (refreshEnum == RefreshEnum.refreshCurrentGlockers) {
          await getGlockerList();
        } else if (refreshEnum == RefreshEnum.refreshTrendingGlockers) {
          await getGlockerTrendingList();
        } else if (refreshEnum == RefreshEnum.refreshFavoriteGlockers) {
          await getFavoriteList();
        } else if (refreshEnum == RefreshEnum.refreshSelectedGlocker) {
          await getSelectedGlockerData();
        }
      }

      refresh();
    } catch (e) {
      // showSnackBar(message: "$e");
    }
  }
}

enum RefreshEnum {
  refreshAllGlockers,
  refreshCurrentGlockers,
  refreshTrendingGlockers,
  refreshFavoriteGlockers,
  refreshSelectedGlocker
}
