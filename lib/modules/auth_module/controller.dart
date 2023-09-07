import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/hive_controller.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find<AuthController>();
  final hiveController = HiveController.to;
  final formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  PageController pageController = PageController();
  Rxn<bool> showWalkthrough = Rxn<bool>(false);
  Rxn<bool> get walkthroughDone =>
      Rxn((getWalkthroughStatus() ?? false) || showWalkthrough.value!);
  getWalkthroughStatus() {
    return hiveController.readData('walkthrough');
  }

  setWalkthroughStatus(bool value) async {
    showWalkthrough.value = value;
    await hiveController.writeData('walkthrough', value);
  }

  handleSendOTP() {
    if (formKey.currentState!.validate()) {
      pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  handleVerifyOTP() {}

  @override
  void dispose() {
    // TODO: implement dispose
    numberController.dispose();
    super.dispose();
  }
}
