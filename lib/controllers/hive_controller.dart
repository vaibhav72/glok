import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveController extends GetxController {
  static HiveController get to => Get.find<HiveController>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  init() async {
    await Hive.initFlutter();
    var box = await Hive.openBox('app');
  }

  writeData(String key, dynamic value) async {
    await Hive.box('app').put(key, value);
  }

  readData(String key) {
    return Hive.box('app').get(key);
  }
}
