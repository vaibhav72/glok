import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/utils/meta_colors.dart';

class CelebByCategoryController extends GetxController {
  Rxn<List<String>> filtersList = Rxn([]);
  Rxn<bool> showOnline = Rxn(false);

  showFilters() {
    Get.bottomSheet(Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
              child: Row(
                children: [
                  Text(
                    "Filter",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
              child: Row(
                children: [
                  Text(
                    "Show Only Online",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
              child: Row(
                children: [
                  Text(
                    "Sort By",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  
                ],
              ),
            ),
            Column(children: [
              Row(children: [
                CircleAvatar()
              ],)
            ],)
          ],
        ),
      ),
    ));
  }
}
