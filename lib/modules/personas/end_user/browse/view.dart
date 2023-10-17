import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/browse/celeb_by_category/binding.dart';
import 'package:glok/modules/personas/end_user/browse/celeb_by_category/view.dart';
import 'package:glok/modules/personas/end_user/browse/controller.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/modules/personas/end_user/home/view.dart';
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
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
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  width: double.maxFinite,
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
                      Padding(
                        padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
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
                            Text(
                              "View All",
                              style: Get.theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Get.theme.primaryColor),
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
                                            .to.trendingGlockers.value![index],
                                        resfreshEnum:
                                            RefreshEnum.refreshTrendingGlockers,
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
                        padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
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
                                    binding: CelebByCategoryBiding());
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: MetaColors.dividerColor,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
