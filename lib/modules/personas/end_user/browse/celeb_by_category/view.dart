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
          Obx(
            () => Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                        onTap: () {
                          controller.showFilters();
                        },
                        child: SvgPicture.asset(
                          MetaAssets.filterIcon,
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                              Get.theme.primaryColor, BlendMode.srcIn),
                        )),
                  ),
                  if (controller.glockerListController.filtersCount != 0)
                    Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                            backgroundColor: Get.theme.primaryColor,
                            radius: 8,
                            child: Text(
                              controller.glockerListController.filtersCount
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            )))
                ],
              ),
            ),
          )
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
                if (value.isNotEmpty) {
                  controller.glockerListController.searching.value = true;
                  controller.glockerListController.searchText.value = value;
                  controller.glockerListController.getGlockerList();
                } else {
                  controller.glockerListController.searching.value = false;
                  controller.glockerListController.searchText.value = "";
                }
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
                        if (controller
                            .glockerListController.appliedShowOnline.value!)
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
                                            .appliedShowOnline.value = false;
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
                        if (controller
                            .glockerListController.appliedSortBy.value!
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
                                      controller.glockerListController
                                          .appliedSortBy.value!
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
                                        controller.glockerListController
                                            .appliedSortBy.value = '';
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
                        if (controller.glockerListController.appliedMinPrice
                                    .value !=
                                null &&
                            controller.glockerListController.appliedMinPrice
                                    .value !=
                                null)
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
                                      "₹ ${controller.glockerListController.appliedMinPrice.value!.toInt()} - ₹ ${controller.glockerListController.appliedMaxPrice.value!.toInt()}"
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
                                        controller.glockerListController
                                            .appliedMinPrice.value = null;
                                        controller.glockerListController
                                            .appliedMaxPrice.value = null;
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
                            .glockerListController.appliedFilters.value!
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
                                              controller
                                                  .removeAppliedFilter(element);
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
              child: GlockerListController.to.currentGlockers.isEmpty
                  ? Center(
                      child: Text("No Glockers found"),
                    )
                  : GridView.builder(
                      itemCount: GlockerListController
                          .to.currentGlockers.value!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: .8,
                          crossAxisCount: 2),
                      itemBuilder: ((context, index) {
                        return GlockerTile(
                          data: GlockerListController
                              .to.currentGlockers.value![index],
                          resfreshEnum: RefreshEnum.refreshCurrentGlockers,
                        );
                      })),
            ),
          ))
        ],
      ),
    );
  }
}
