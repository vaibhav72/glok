import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/meta_colors.dart';
import '../../celebrity/home/view.dart';
import '../glocker_list_controller.dart';
import '../home/view.dart';
import 'controller.dart';

class TrendingGlockersView extends GetView<TrendingGlockersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        actions: [],
        centerTitle: true,
        title: Text(
          "Trending Glockers",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: MetaColors.primaryText),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Expanded(
              child: Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GlockerListController.to.trendingGlockers.isEmpty
                  ? Center(
                      child: Text("No Glockers found"),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await controller.getTrendingGlockers();
                      },
                      child: GridView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.trendingGlockers.value!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: .8,
                                  crossAxisCount: 2),
                          itemBuilder: ((context, index) {
                            return GlockerTile(
                                data: controller.trendingGlockers.value![index],
                                resfreshEnum:
                                    RefreshEnum.refreshTrendingGlockers);
                          })),
                    ),
            ),
          ))
        ],
      ),
    );
  }
}
