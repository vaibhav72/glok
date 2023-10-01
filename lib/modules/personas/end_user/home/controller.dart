import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/utils/meta_assets.dart';

class EndUserHomeController extends GetxController {
  static EndUserHomeController get to => Get.find<EndUserHomeController>();
  Rxn<int> currentCarousel = Rxn<int>(0);
  final CarouselController carouselController = CarouselController();
  List<Widget> carouselItems = [
    Container(child: Image.asset(MetaAssets.carouselImage)),
    Container(child: Image.asset(MetaAssets.carouselImage)),
    Container(child: Image.asset(MetaAssets.carouselImage))
  ];
  var selectedPage = 0.obs;
  void changePage(int index) {
    selectedPage.value = index;
  }

  List<String> pageTitleList = ["Movie Star", "TV Star", "Music", "Influencer"];
}
