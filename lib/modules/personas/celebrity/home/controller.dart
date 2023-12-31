import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/controllers/bottom_navigation_controller.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/user_repository.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/utils/meta_assets.dart';

import '../../../../data/models/stats_model.dart';
import '../../../auth_module/controller.dart';

class GlockerHomeController extends GetxController {
  static GlockerHomeController get to => Get.find<GlockerHomeController>();
  BottomNavigationController get bottomNav => BottomNavigationController.to;
  UserRepository userRepository = UserRepository();
  Rxn<int> currentCarousel = Rxn<int>(0);
  PersonaController get personaController => PersonaController.to;
  Rxn<GlockerStatsModel> get glockerStats => personaController.glockerStats;

  final CarouselController carouselController = CarouselController();
  Rxn<GlockerModel> get currentGlocker => AuthController.to.glocker;
  List<Widget> carouselItems = [
    Container(child: Image.asset(MetaAssets.carouselImage)),
    Container(child: Image.asset(MetaAssets.carouselImage)),
    Container(child: Image.asset(MetaAssets.carouselImage))
  ];
  var selectedPage = 0.obs;
  void changePage(int index) {
    selectedPage.value = index;
  }
}
