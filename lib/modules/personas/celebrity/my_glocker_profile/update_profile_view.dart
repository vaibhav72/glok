import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/celebrity/my_glocker_profile/controller.dart';

import '../../../../utils/helpers.dart';
import '../../../../utils/meta_assets.dart';
import '../../end_user/apply_glocker/view.dart';

class UpdateMyGlockerProfileView extends GetView<MyGlockerProfileController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Obx(
      () => controller.loading.value!
          ? Center(
              child: Loader(),
            )
          : Container(
              child: Stack(
                children: [
                  Form(
                    key: controller.basicDetailsFormKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: controller.coverImage.value != null
                                      ? FileImage(File(
                                          controller.coverImage.value!.path))
                                      : CachedNetworkImageProvider(controller
                                          .glocker
                                          .value!
                                          .coverPhoto!) as ImageProvider,
                                  fit: BoxFit.cover)),
                          width: double.maxFinite,
                          height: Get.height * .5,
                        ),
                        Expanded(
                            child: Container(
                          color: Colors.white,
                        ))
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black38,
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          controller.pickCoverImage();
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black38,
                                          child: SvgPicture.asset(
                                            MetaAssets.addCoverImage,
                                            colorFilter: ColorFilter.mode(
                                                Colors.white, BlendMode.srcIn),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: Get.height * .15,
                                ),
                                Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 54),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24),
                                                topRight: Radius.circular(24))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                height: 56,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 6),
                                                    child: Text(
                                                      "Name",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    controller: controller
                                                        .nameController,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Name is required";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: formDecoration(
                                                        "Name",
                                                        "Enter your name"),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 6),
                                                    child: Text(
                                                      "Category",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  DropdownButtonFormField(
                                                    value: controller
                                                        .selectedCategory.value,
                                                    items: pageTitleList
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                              child: Text(e),
                                                              value: e,
                                                            ))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      controller
                                                              .selectedCategory
                                                              .value =
                                                          value.toString();
                                                    },
                                                    decoration: formDecoration(
                                                        "Category",
                                                        "Select your category"),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 6),
                                                    child: Text(
                                                      "About Me",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    maxLines: 2,
                                                    controller: controller
                                                        .aboutMeController,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "About me is required";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: formDecoration(
                                                        "About Me",
                                                        "Add few lines about you..."),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 6),
                                                    child: Text(
                                                      "Per Minute Rate",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    controller: controller
                                                        .rateController,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Per Minute Rate is required";
                                                      }
                                                      return null;
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: formDecoration(
                                                        "Per Minute Rate", ""),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Center(
                                        child: Stack(
                                          fit: StackFit.loose,
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            controller.profileImage.value !=
                                                    null
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Get.theme.dividerColor,
                                                    radius: 54,
                                                    backgroundImage: FileImage(
                                                        File(controller
                                                            .profileImage
                                                            .value!
                                                            .path)),
                                                  )
                                                : CircleAvatar(
                                                    radius: 54,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                            controller
                                                                    .glocker
                                                                    .value
                                                                    ?.profilePhoto ??
                                                                ''),
                                                    backgroundColor:
                                                        Get.theme.dividerColor,
                                                  ),
                                            Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.pickProfileImage();
                                                },
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 14,
                                                    child: SvgPicture.asset(
                                                        MetaAssets.addPhoto)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CustomButton(
                              title: "Save Changes",
                              onPressed: () {
                                controller.updateGlockerData();
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    ));
  }
}
