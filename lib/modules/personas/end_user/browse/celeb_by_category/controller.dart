import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CelebByCategoryController extends GetxController {
  RxList<String> filtersList = RxList.empty();
  Rxn<bool> showOnline = Rxn(false);
  List<String> sortBy = ["Popular", "Lowest Price", "Highest Price"];
  Rxn<List<String>> selectedFilters = Rxn([]);
  List<String> priceList = [
    "Below \u20b9 499",
    "\u20b9 999 - \u20b9 1999",
    "\u20b9 1999 - \u20b9 2999",
    "\u20b9 2999 - \u20b9 3999",
    "\u20b9 1999 - \u20b9 4999",
    "Above \u20b9 4999"
  ];

  showFilters() {
    Get.bottomSheet(
        Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          height: 6,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Get.theme.dividerColor,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0).copyWith(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          "Filter",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(24.0).copyWith(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          "Show Only Online",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Obx(() => CupertinoSwitch(
                            activeColor:
                                MetaColors.transactionSuccess.withOpacity(0.2),
                            thumbColor: showOnline.value!
                                ? MetaColors.transactionSuccess
                                : Colors.white,
                            value: showOnline.value!,
                            onChanged: (value) {
                              showOnline.value = value;
                            }))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0).copyWith(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          "Sort By",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(24).copyWith(top: 8),
                      child: Column(
                        children: List.generate(
                            sortBy.length,
                            (index) => InkWell(
                                  onTap: () {
                                    sortBy.forEach(
                                      (element) {
                                        if (selectedFilters.value!
                                                .contains(element) &&
                                            element != sortBy[index]) {
                                          selectedFilters.value!
                                              .remove(element);
                                        }
                                      },
                                    );

                                    handleFilter(sortBy[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: selectedFilters
                                                  .value!
                                                  .contains(sortBy[index])
                                              ? Get.theme.primaryColor
                                              : Colors.white,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 5,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          sortBy[index],
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0).copyWith(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          "By Price",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(24).copyWith(top: 8),
                      child: Column(
                        children: List.generate(
                            priceList.length,
                            (index) => InkWell(
                                  onTap: () {
                                    handleFilter(priceList[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 22,
                                          width: 22,
                                          decoration: BoxDecoration(
                                              color: selectedFilters.value!
                                                      .contains(
                                                          priceList[index])
                                                  ? Get.theme.primaryColor
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: selectedFilters.value!
                                                          .contains(
                                                              priceList[index])
                                                      ? Get.theme.primaryColor
                                                      : Get.theme.dividerColor),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: SvgPicture.asset(
                                                MetaAssets.tickMark),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          priceList[index],
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isScrollControlled: true);
  }

  void removeFilter(String element) {
    selectedFilters.value!.remove(element);
    selectedFilters.refresh();
  }

  void addFilter(String element) {
    selectedFilters.value!.add(element);
    selectedFilters.refresh();
  }

  void handleFilter(String element) {
    if (selectedFilters.value!.contains(element)) {
      removeFilter(element);
    } else {
      addFilter(element);
    }
  }
}
