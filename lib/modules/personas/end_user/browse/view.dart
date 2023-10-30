import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/browse/celeb_by_category/binding.dart';
import 'package:glok/modules/personas/end_user/browse/celeb_by_category/view.dart';
import 'package:glok/modules/personas/end_user/browse/controller.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/modules/personas/end_user/home/view.dart';
import 'package:glok/modules/personas/end_user/trending_glockers/binding.dart';
import 'package:glok/modules/personas/end_user/trending_glockers/view.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';

class BrowseView extends GetView<BrowseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: MediaQuery.of(context).padding,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      GlockerListController.to.searching.value = true;
                      GlockerListController.to.searchText.value = value;
                      GlockerListController.to.clearFiltersValues();
                      GlockerListController.to.getGlockerList();
                    } else {
                      GlockerListController.to.searching.value = false;
                      GlockerListController.to.searchText.value = "";
                    }
                  },
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: searchFormDecoration("", "Search",
                      prefix: SvgPicture.asset(
                        MetaAssets.browseIcon,
                        height: 24,
                        width: 24,
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      )),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Expanded(
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          if (GlockerListController.to.searching.value!) ...[
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: GlockerListController
                                        .to.currentGlockers.isEmpty
                                    ? Center(
                                        child: Text("No Glockers found"),
                                      )
                                    : Column(
                                        children: [
                                          GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: GlockerListController
                                                  .to
                                                  .currentGlockers
                                                  .value!
                                                  .length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 10,
                                                      childAspectRatio: .8,
                                                      crossAxisCount: 2),
                                              itemBuilder: ((context, index) {
                                                return GlockerTile(
                                                  data: GlockerListController
                                                      .to
                                                      .currentGlockers
                                                      .value![index],
                                                  resfreshEnum: RefreshEnum
                                                      .refreshCurrentGlockers,
                                                );
                                              })),
                                        ],
                                      ),
                              ),
                            )
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.all(16.0)
                                  .copyWith(bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Trending",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Get.theme.colorScheme.secondary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => TrendingGlockersView(),
                                          binding: TrendingGlockersBinding());
                                    },
                                    child: Text(
                                      "View All",
                                      style: Get.theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Get.theme.primaryColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.all(16.0)
                                    .copyWith(right: 0, top: 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        GlockerListController
                                            .to.trendingGlockers.value!.length,
                                        (index) => GlockerTile(
                                              data: GlockerListController
                                                  .to
                                                  .trendingGlockers
                                                  .value![index],
                                              resfreshEnum: RefreshEnum
                                                  .refreshTrendingGlockers,
                                            )),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: CustomPaint(
                                painter: DashedLinePainter(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0)
                                  .copyWith(bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Browse by Category",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Get.theme.colorScheme.secondary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemCount: pageTitleList.length,
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                    onTap: () {
                                      GlockerListController.to
                                          .changeCategory(pageTitleList[index]);
                                      Get.to(CelebByCategoryView(),
                                          binding: CelebByCategoryBinding());
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor:
                                                MetaColors.dividerColor,
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                MetaAssets.dummyCeleb,
                                              ),
                                              radius: 38,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "${pageTitleList[index]}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }))
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
