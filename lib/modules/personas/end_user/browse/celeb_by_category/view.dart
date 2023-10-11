import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/browse/celeb_by_category/controller.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/modules/personas/end_user/home/view.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';

class CelebByCategoryView extends GetView<CelebByCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        actions: [
          InkWell(
              onTap: () {
                controller.showFilters();
              },
              child: SvgPicture.asset(MetaAssets.filterIcon))
        ],
        centerTitle: true,
        title: Text(
          GlockerListController.to.currentCategory.value!,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: MetaColors.primaryText),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              onChanged: (value) {
                controller.glockerListController.searchText.value = value;
                controller.glockerListController.getGlockerList();
              },
              decoration: searchFormDecoration("", "Search",
                  prefix: SvgPicture.asset(MetaAssets.browseIcon),
                  isLight: true),
            ),
          ),
          Obx(() => Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (controller.glockerListController.showOnline.value!)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: MetaColors.secondaryPurple
                                      .withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Row(
                                  children: [
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                          color: Get.theme.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.glockerListController
                                            .showOnline.value = false;
                                        controller.glockerListController
                                            .getGlockerList();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Get.theme.primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (controller.glockerListController.sortBy.value!
                            .trim()
                            .isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: MetaColors.secondaryPurple
                                      .withOpacity(.2)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Row(
                                  children: [
                                    Text(
                                      controller
                                          .glockerListController.sortBy.value!
                                          .toString(),
                                      style: TextStyle(
                                          color: Get.theme.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.glockerListController.sortBy
                                            .value = '';
                                        controller.glockerListController
                                            .getGlockerList();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Get.theme.primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ...controller
                            .glockerListController.selectedFilters.value!
                            .map((element) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: MetaColors.secondaryPurple
                                            .withOpacity(.2)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      child: Row(
                                        children: [
                                          Text(
                                            element.toString(),
                                            style: TextStyle(
                                                color: Get.theme.primaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.removeFilter(element);
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Get.theme.primaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
              child: Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GridView.builder(
                  itemCount:
                      GlockerListController.to.currentGlockers.value!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: .8,
                      crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    return CelebrityTile(
                        data: GlockerListController
                            .to.currentGlockers.value![index]);
                  })),
            ),
          ))
        ],
      ),
    );
  }
}
