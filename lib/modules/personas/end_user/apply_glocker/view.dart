import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:video_player/video_player.dart';

import '../../../../utils/helpers.dart';
import '../../../../utils/meta_colors.dart';
import 'controller.dart';

class ApplyToGlockerView extends GetView<ApplyToGlockerController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        children: [
          if (controller.glocker.value?.panNumber == null) ...[
            _BasicDetailsWidget(),
            _TaxInfoWidget(),
          ],
          if (controller.glocker.value?.aadharFront == null)
            _AadhaarInfoWidget(),
          if (controller.glocker.value?.videoKyc == null) _VideoKYCWidget(),
          _CongratulationsView()
        ],
      ),
    );
  }
}

class _CongratulationsView extends StatelessWidget {
  const _CongratulationsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(MetaAssets.congratsBackground),
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(MetaAssets.congratsMobile),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            "Congratulations!",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Your Video KYC has been successfully completed, and your account has been approved.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                CustomButton(
                    title: "Continue",
                    onPressed: () {
                      AuthController.to.getGlockerDetails();
                      Get.back();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _VideoKYCWidget extends GetView<ApplyToGlockerController> {
  const _VideoKYCWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              if (controller.glocker.value?.aadharFront == null) {
                controller.pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              } else {
                Get.back();
              }
            },
          ),
          title: Text(
            "Video KYC",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MetaColors.primaryText),
          )),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: Loader(),
              )
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Please record a video by reading out the code displayed below",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "111-111",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 440,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Get.theme.dividerColor
                                              .withOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Get.theme.dividerColor
                                          .withOpacity(0.3)),
                                  child: controller.videoKyc.value != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: FutureBuilder(
                                              future: controller
                                                  .initializeVideoPlayerFuture,
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  // If the VideoPlayerController has finished initialization, use
                                                  // the data it provides to limit the aspect ratio of the video.
                                                  return InkWell(
                                                    onTap: () {
                                                      controller
                                                          .playPauseVideo();
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        VideoPlayer(
                                                          controller
                                                              .videoController,
                                                        ),
                                                        Obx(() => controller
                                                                .isVideoPlaying
                                                                .value!
                                                            ? Container()
                                                            : Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .play_arrow,
                                                                  size: 50,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  // If the VideoPlayerController is still initializing, show a
                                                  // loading spinner.
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            controller.pickVideoKyc();
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  MetaAssets.addCoverImage),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "Take a Video",
                                                style: TextStyle(
                                                    color: MetaColors
                                                        .tertiaryText),
                                              )
                                            ],
                                          ),
                                        ),
                                ),
                                if (controller.videoKyc.value != null)
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        controller.refreshVideo();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                        title: "Continue",
                        onPressed: () {
                          controller.updateVideoKYC();
                        })
                  ],
                ),
              ),
      ),
    ));
  }
}

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}

class _AadhaarInfoWidget extends GetView<ApplyToGlockerController> {
  const _AadhaarInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              if (controller.glocker.value?.panNumber == null) {
                controller.pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              } else {
                Get.back();
              }
            },
          ),
          title: Text(
            "Aadhaar Details",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MetaColors.primaryText),
          )),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: Loader(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Upload Aadhaar card front and back side for the verification purpose",
                              style: TextStyle(fontSize: 15),
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
                                    "Front Side",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 220,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Get.theme.dividerColor
                                                  .withOpacity(0.3)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Get.theme.dividerColor
                                              .withOpacity(0.3)),
                                      child: controller.adhaarFront.value !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(
                                                File(controller
                                                    .adhaarFront.value!.path),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                controller.pickAadharFront();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      MetaAssets.addCoverImage),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Upload or Take a Photo",
                                                    style: TextStyle(
                                                        color: MetaColors
                                                            .tertiaryText),
                                                  )
                                                ],
                                              ),
                                            ),
                                    ),
                                    if (controller.adhaarFront.value != null)
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            controller.adhaarFront.value = null;
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.red,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
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
                                    "Back Side",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 220,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Get.theme.dividerColor
                                                  .withOpacity(0.3)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Get.theme.dividerColor
                                              .withOpacity(0.3)),
                                      child: controller.adhaarBack.value != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(
                                                File(controller
                                                    .adhaarBack.value!.path),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                controller.pickAadharBack();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      MetaAssets.addCoverImage),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Upload or Take a Photo",
                                                    style: TextStyle(
                                                        color: MetaColors
                                                            .tertiaryText),
                                                  )
                                                ],
                                              ),
                                            ),
                                    ),
                                    if (controller.adhaarBack.value != null)
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            controller.adhaarBack.value = null;
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.red,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                        title: "Continue",
                        onPressed: () {
                          controller.addAadhaar();
                        })
                  ],
                ),
              ),
      ),
    ));
  }
}

class _TaxInfoWidget extends GetView<ApplyToGlockerController> {
  const _TaxInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              controller.pageController.previousPage(
                  duration: Duration(milliseconds: 100), curve: Curves.easeIn);
            },
          ),
          title: Text(
            "Tax Information",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MetaColors.primaryText),
          )),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: Loader(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: controller.taxDetailsFormKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "Payout subject to the tds deduction and GSTIN might be applicable",
                                style: TextStyle(fontSize: 15),
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
                                      "Name as per PAN",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: controller.panNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your name";
                                      }
                                      return null;
                                    },
                                    decoration: formDecoration(
                                        "Name as in PAN", "Enter your name"),
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
                                      "PAN Number",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                  TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    controller: controller.panController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      UpperCaseTextFormatter(),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your pan number";
                                      }
                                      if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$')
                                          .hasMatch(value)) {
                                        return "Please enter valid pan number";
                                      }
                                      return null;
                                    },
                                    decoration: formDecoration(
                                        "PAN Number", "Enter your pan number"),
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
                                    child: Row(
                                      children: [
                                        Text(
                                          "GSTIN",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "(optional)",
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    inputFormatters: [
                                      UpperCaseTextFormatter(),
                                    ],
                                    controller: controller.gstController,
                                    decoration: formDecoration(
                                        "GSTIN Number", "Enter GSTIN number"),
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
                      CustomButton(
                          title: "Continue",
                          onPressed: () {
                            controller.validateTaxDetailsAndApply();
                          })
                    ],
                  ),
                ),
              ),
      ),
    ));
  }
}

class _BasicDetailsWidget extends GetView<ApplyToGlockerController> {
  const _BasicDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(
              child: Loader(),
            )
          : Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: controller.coverImage.value != null
                                    ? FileImage(
                                        File(controller.coverImage.value!.path))
                                    : AssetImage(MetaAssets.coverPlaceHolder)
                                        as ImageProvider,
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
                  SafeArea(
                    child: Form(
                      key: controller.basicDetailsFormKey,
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
                                                  Colors.white,
                                                  BlendMode.srcIn),
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
                                                  topRight:
                                                      Radius.circular(24))),
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
                                                      validator: (value) {
                                                        if (value == null) {
                                                          return "Please select your category";
                                                        }
                                                        return null;
                                                      },
                                                      value: controller
                                                          .selectedCategory
                                                          .value,
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
                                                      decoration:
                                                          formDecoration(
                                                              "Per Minute Rate",
                                                              ""),
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
                                                      backgroundColor: Get
                                                          .theme.dividerColor,
                                                      radius: 54,
                                                      backgroundImage:
                                                          FileImage(File(
                                                              controller
                                                                  .profileImage
                                                                  .value!
                                                                  .path)),
                                                    )
                                                  : CircleAvatar(
                                                      radius: 54,
                                                      child: SvgPicture.asset(
                                                          MetaAssets
                                                              .placeHolderProfile),
                                                      backgroundColor: Get
                                                          .theme.dividerColor,
                                                    ),
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: InkWell(
                                                  onTap: () {
                                                    controller
                                                        .pickProfileImage();
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
                                title: "Continue",
                                onPressed: () {
                                  controller.validateAndProceedToTaxDetails();
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
