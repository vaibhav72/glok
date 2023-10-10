import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.pageController.previousPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              controller.pageController.previousPage(
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            "OTP Verification",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Get.theme.primaryColor),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "We have sent a verification code to",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "+91-${controller.numberController.text}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    controller: controller.otpController,
                    autoDisposeControllers: false,
                    length: 5,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    pinTheme: PinTheme(
                      fieldHeight: 48,
                      fieldWidth: 55,
                      shape: PinCodeFieldShape.box,
                      borderWidth: 1,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Theme.of(context).dividerColor,
                      selectedColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Resend SMS",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.secondaryHeaderColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      title: "Continue",
                      onPressed: () {
                        controller.handleVerifyOTP();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
