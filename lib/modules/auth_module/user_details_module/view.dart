import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/auth_module/user_details_module/controller.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';

import '../../../utils/helpers.dart';
import '../../personas/end_user/apply_glocker/view.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.authController.pageController.jumpToPage(0);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  controller.authController.pageController.jumpToPage(0);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: Obx(
            () => AuthController.to.authLoading.value!
                ? Center(
                    child: Loader(),
                  )
                : Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: controller.image.value !=
                                          null
                                      ? FileImage(
                                          File(controller.image.value!.path))
                                      : AssetImage(MetaAssets.dummyProfile)
                                          as ImageProvider<Object>?,
                                  backgroundColor: Get.theme.dividerColor,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: Text(
                                    "Add Your Photo",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
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
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: controller.nameController,
                                      decoration: formDecoration(
                                          "Name", "Enter your name"),
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
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.gender.value = "male";
                                          },
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 11,
                                                backgroundColor:
                                                    MetaColors.tertiaryText,
                                                child: CircleAvatar(
                                                  backgroundColor: controller
                                                              .gender.value ==
                                                          "male"
                                                      ? Get.theme.primaryColor
                                                      : Colors.white,
                                                  radius: 10,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 5,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Male")
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.gender.value = "female";
                                          },
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 11,
                                                backgroundColor:
                                                    MetaColors.tertiaryText,
                                                child: CircleAvatar(
                                                  backgroundColor: controller
                                                              .gender.value ==
                                                          "female"
                                                      ? Get.theme.primaryColor
                                                      : Colors.white,
                                                  radius: 10,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 5,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Female")
                                            ],
                                          ),
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
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: controller.numberController,
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
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      decoration: formDecoration(
                                          "Mobile Number",
                                          "Enter Mobile Number"),
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
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: controller.emailController,
                                      validator: validateEmail,
                                      decoration: formDecoration(
                                          "Email Address",
                                          "Enter email address"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.agreement.value =
                                        !controller.agreement.value!;
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0)
                                            .copyWith(left: 0),
                                        child: Container(
                                          height: 22,
                                          width: 22,
                                          decoration: BoxDecoration(
                                              color: controller.agreement.value!
                                                  ? Get.theme.primaryColor
                                                  : Colors.white,
                                              border: Border.all(
                                                  color:
                                                      Get.theme.primaryColor),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
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
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                    title: "Continue",
                                    onPressed: () {
                                      controller.register();
                                    })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          )),
    );
  }
}
