import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/auth_module/pages/otp_view.dart';
import 'package:glok/modules/auth_module/pages/sign_in_view.dart';
import 'package:glok/modules/auth_module/user_details_module/view.dart';
import 'package:glok/modules/walkthrough/view.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: !controller.walkthroughDone.value!
              ? WalkthroughView()
              : PageView(
                  controller: controller.pageController,
                  children: [SignInView(), OTPView(), UserDetailsView()],
                ),
        ),
      ),
    );
  }
}
