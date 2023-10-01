import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/browse/celeb_by_category/controller.dart';
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
          "Influencer",
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
              decoration: searchFormDecoration("", "Search",
                  prefix: SvgPicture.asset(MetaAssets.browseIcon),
                  isLight: true),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: .8,
                    crossAxisCount: 2),
                itemBuilder: ((context, index) {
                  return CelebrityTile();
                })),
          ))
        ],
      ),
    );
  }
}