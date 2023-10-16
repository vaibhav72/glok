import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/glocker_repository.dart';
import 'package:glok/utils/helpers.dart';

import '../celebrity/celeb_profile/binding.dart';
import '../celebrity/celeb_profile/view.dart';

class GlockerListController extends GetxController {
  GlockerRepository glockerRepository = GlockerRepository();
  static GlockerListController get to => Get.find<GlockerListController>();
  Rxn<GlockerModel> selectedGlocker = Rxn();
  Rxn<List<GlockerModel>> currentGlockers = Rxn([]);
  Rxn<List<GlockerModel>> trendingGlockers = Rxn([]);
  Rxn<String> searchText = Rxn("");
  Rxn<String> currentCategory = Rxn("Movie Star");
  Rxn<bool> searching = Rxn(false);
  Rxn<bool> showOnline = Rxn(false);
  Rxn<bool> appliedShowOnline = Rxn(false);
  List<String> sortByList = ["Popular", "Lowest Price", "Highest Price"];
  Rxn<String> sortBy = Rxn("Popular");
  Rxn<String> appliedSortBy = Rxn("Popular");
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
    // getGlockerList();
    // getGlockerTrendingList();
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
    getGlockerList();
    Get.back();
  }

  getGlockerList() async {
    try {
      currentFilterString.value =
          "${currentCategory.value!.isNotEmpty ? 'category=${currentCategory.value}' : ''}${searching.value! ? '&search=${searchText.value}' : ''}${appliedSortBy.value != '' ? '&sortby=${appliedSortBy.value!.toLowerCase().trim()}' : ''}${appliedMinPrice.value != null && appliedMaxPrice.value != null ? "&minprice=${appliedMinPrice.value!.toInt()}&maxprice=${appliedMaxPrice.value!.toInt()}" : ''}";
      currentGlockers.value = await glockerRepository.getGlockerList(
          filters: currentFilterString.value, index: 1);
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
          "${currentCategory.value!.isNotEmpty ? 'category=${currentCategory.value}' : ''}${searching.value! ? '&search=${searchText.value}' : ''}${appliedSortBy.value != '' ? '&sortby=${appliedSortBy.value!.toLowerCase()}' : ''} ${appliedMinPrice.value != null && appliedMaxPrice.value != null ? "&minprice=${appliedMinPrice.value}&maxprice=${appliedMaxPrice.value}" : ''}";
      currentGlockers.value!.addAll(await glockerRepository.getGlockerList(
          filters: currentFilterString.value, index: page.value));
    } catch (e) {
      log("$e");
    }
  }

  void changeCategory(String pageTitle) {
    currentCategory.value = pageTitle;
    getGlockerList();
  }

  void viewGlocker(GlockerModel data) {
    selectedGlocker.value = data;
    Get.to(() => CelebrityProfileView(), binding: CelebrityProfileBinding());
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
}
