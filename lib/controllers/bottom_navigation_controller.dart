import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  static BottomNavigationController get to =>
      Get.find<BottomNavigationController>();
}
