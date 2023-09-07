import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glok/modules/auth_module/user_details_module/controller.dart';
import 'package:glok/utils/meta_assets.dart';

import '../../../utils/helpers.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.authController.pageController.previousPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  controller.authController.pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Get.theme.dividerColor,
                      child: Image.asset(
                        MetaAssets.dummyProfile,
                        height: 48,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      child: Text(
                        "Add Your Photo",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                        TextFormField(
                          decoration: formDecoration("Name", "Enter your name"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Gender",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Get.theme.primaryColor,
                                  radius: 10,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 5,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Male")
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Get.theme.primaryColor,
                                  radius: 10,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 5,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Female")
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Mobile Number",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.trim().length != 10) {
                              return "Enter a valid mobile number";
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          decoration: formDecoration(
                              "Mobile Number", "Enter Mobile Number"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Email Address",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {},
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          decoration: formDecoration(
                              "Email Address", "Enter email address"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0).copyWith(left: 0),
                          child: Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                color: Get.theme.primaryColor,
                                border:
                                    Border.all(color: Get.theme.primaryColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                              "I hereby acknowledge and agree to the terms and conditions."),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(title: "Continue", onPressed: () {})
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
