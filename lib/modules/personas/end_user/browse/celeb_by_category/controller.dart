import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CelebByCategoryController extends GetxController {
  GlockerListController get glockerListController => GlockerListController.to;

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
                            thumbColor: glockerListController.showOnline.value!
                                ? MetaColors.transactionSuccess
                                : Colors.white,
                            value: glockerListController.showOnline.value!,
                            onChanged: (value) {
                              glockerListController.showOnline.value = value;
                              glockerListController.getGlockerList();
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
                            glockerListController.sortByList.length,
                            (index) => InkWell(
                                  onTap: () {
                                    glockerListController.sortBy.value =
                                        glockerListController.sortByList[index];
                                    glockerListController.getGlockerList();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: glockerListController
                                                      .sortByList[index] ==
                                                  glockerListController
                                                      .sortBy.value
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
                                          glockerListController
                                              .sortByList[index],
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
                            glockerListController.priceList.length,
                            (index) => InkWell(
                                  onTap: () {
                                    handleFilter(
                                        glockerListController.priceList[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 22,
                                          width: 22,
                                          decoration: BoxDecoration(
                                              color: glockerListController
                                                      .selectedFilters.value!
                                                      .contains(
                                                          glockerListController
                                                              .priceList[index])
                                                  ? Get.theme.primaryColor
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: glockerListController
                                                          .selectedFilters
                                                          .value!
                                                          .contains(glockerListController
                                                              .priceList[index])
                                                      ? Get.theme.primaryColor
                                                      : Get.theme.dividerColor),
                                              borderRadius: BorderRadius.circular(4)),
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
                                          glockerListController
                                              .priceList[index],
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
    glockerListController.selectedFilters.value!.remove(element);
    glockerListController.selectedFilters.refresh();
  }

  void addFilter(String element) {
    glockerListController.selectedFilters.value!.add(element);
    glockerListController.selectedFilters.refresh();
  }

  void handleFilter(String element) {
    if (glockerListController.selectedFilters.value!.contains(element)) {
      removeFilter(element);
    } else {
      addFilter(element);
    }
    glockerListController.getGlockerList();
  }
}
