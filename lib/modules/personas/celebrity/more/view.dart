import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/personas/end_user/apply_glocker/view.dart';
import 'package:glok/modules/personas/end_user/more/view.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';

import '../../../../utils/helpers.dart';
import 'controller.dart';

class GlockerMoreView extends GetView<GlockerMoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: [
        Padding(
          padding: MediaQuery.of(context).padding,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(
              () => Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    PersonaSwapWidget(),
                    SizedBox(
                      height: 16,
                    ),
                    CircleAvatar(
                      radius: 44,
                      backgroundImage: controller.user.value!.photo != null
                          ? CachedNetworkImageProvider(
                              controller.user.value!.photo!)
                          : AssetImage(MetaAssets.dummyProfile)
                              as ImageProvider,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      controller.user.value!.name!,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      controller.user.value!.mobileNumber!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        height: 6,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Get.theme.dividerColor,
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                    child: Row(
                      children: [
                        Text(
                          "ACCOUNT",
                          style: TextStyle(
                            color: MetaColors.tertiaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _MoreTile(
                    title: "My Profile",
                    icon: MetaAssets.profileIconNew,
                    onTap: () {
                      controller.initProfileDetails();
                      Get.to(_MyProfile());
                    },
                  ),
                  Divider(),
                  _MoreTile(
                    title: "Bank Account",
                    icon: MetaAssets.bankIcon,
                    onTap: () {
                      controller.initBankDetails();
                      Get.bottomSheet(_BankAccountWidget(),
                          isScrollControlled: true);
                    },
                  ),
                  Divider(),
                  _MoreTile(
                    title: "Tax Information",
                    icon: MetaAssets.taxIcon,
                    onTap: () {
                      Get.bottomSheet(_TaxInfoWidget(),
                          isScrollControlled: true);
                    },
                  ),
                  Divider(),
                  _MoreTile(
                    title: "Notification Preference",
                    icon: MetaAssets.notificationIconNew,
                    onTap: () {
                      Get.bottomSheet(_NotificationPreference(),
                          isScrollControlled: true);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                    child: Row(
                      children: [
                        Text(
                          "OTHER",
                          style: TextStyle(
                            color: MetaColors.tertiaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _MoreTile(
                    title: "Invite to Glockers",
                    icon: MetaAssets.inviteIcon,
                    onTap: () {},
                  ),
                  Divider(),
                  _MoreTile(
                    title: "Terms and Conditions",
                    icon: MetaAssets.documentIcon,
                    onTap: () {
                      Get.bottomSheet(_TermsAndConditions(),
                          isScrollControlled: true);
                    },
                  ),
                  Divider(),
                  _MoreTile(
                    title: "Privacy Policy",
                    icon: MetaAssets.documentIcon,
                    onTap: () {},
                  ),
                  Divider(),
                  _MoreTile(
                    title: "Log Out",
                    icon: MetaAssets.logout,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _MoreTile extends StatelessWidget {
  _MoreTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  String title;
  String icon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: Row(
                    children: [
                      SvgPicture.asset(icon),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              SvgPicture.asset(MetaAssets.moreProceed)
            ],
          ),
        ),
      ),
    );
  }
}

class _MyProfile extends GetView<GlockerMoreController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(
            "My Profile",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          width: double.maxFinite,
          height: Get.height,
          child: Obx(
            () => controller.isLoading.value!
                ? Center(
                    child: Loader(),
                  )
                : Form(
                    key: controller.profileFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: MetaColors.secondaryPurple
                                        .withOpacity(0.2),
                                    radius: 60,
                                    child: CircleAvatar(
                                      radius: 56,
                                      backgroundImage: controller
                                                  .profileImage.value !=
                                              null
                                          ? FileImage(File(controller
                                              .profileImage.value!.path))
                                          : controller.user.value!.photo != null
                                              ? CachedNetworkImageProvider(
                                                  controller.user.value!.photo!)
                                              : AssetImage(
                                                      MetaAssets.dummyCeleb)
                                                  as ImageProvider,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.pickProfileImage();
                                    },
                                    child: Text(
                                      "Change Photo",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Get.theme.primaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
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
                                              controller.gender.value =
                                                  "female";
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          "Mobile Number",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: controller.phoneController,
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
                                        keyboardType: const TextInputType
                                                .numberWithOptions(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
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
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                                title: "Save Changes",
                                onPressed: () {
                                  controller.updateProfileData();
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _BankAccountWidget extends GetView<GlockerMoreController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Form(
        key: controller.bankDetailsFormKey,
        child: Container(
          height: 500,
          child: Obx(
            () => controller.isLoading.value!
                ? Center(child: Loader())
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  height: 6,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Get.theme.dividerColor,
                                      borderRadius: BorderRadius.circular(40)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.all(16.0).copyWith(bottom: 24),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Bank Account Details",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                Divider(),
                                Text(
                                  "Please enter the bank account details where you want to withdraw funds from your Glock wallet.",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MetaColors.tertiaryText),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        "Account Holder Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: controller
                                          .accountHolderNameController,
                                      validator: (value) {
                                        if (value!.trim().length < 3) {
                                          return "Enter a valid name";
                                        }
                                        return null;
                                      },
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
                                        "Account Number",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    TextFormField(
                                      controller:
                                          controller.accountNumberController,
                                      validator: (value) {
                                        if (value!.trim().length < 6) {
                                          return "Enter a valid account number";
                                        }
                                        return null;
                                      },
                                      inputFormatters: [
                                        // LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      decoration: formDecoration(
                                          "Account Number",
                                          "Enter Account Number"),
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
                                        "Re-enter Account Number",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: controller
                                          .reenterAccountNumberController,
                                      validator: (value) {
                                        if (value!.trim() !=
                                            controller
                                                .accountNumberController.text
                                                .trim()) {
                                          return "Account number does not match";
                                        }
                                        return null;
                                      },
                                      inputFormatters: [
                                        // LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      decoration: formDecoration(
                                          "Account Number",
                                          "Enter Account Number"),
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
                                        "IFSC Code",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: controller.ifscController,
                                      validator: (value) {
                                        if (RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$')
                                                .hasMatch(value!) ==
                                            false) {
                                          return "Enter a valid IFSC Code";
                                        }
                                        return null;
                                      },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(11),
                                      ],
                                      decoration: formDecoration(
                                          "IFSC Code", "Enter IFSC Code"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                    title: "Submit",
                                    onPressed: () {
                                      controller.addBankDetais();
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _TaxInfoWidget extends GetView<GlockerMoreController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Container(
        height: 500,
        child: Obx(
          () => controller.isLoading.value!
              ? Center(child: Loader())
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Container(
                                height: 6,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Get.theme.dividerColor,
                                    borderRadius: BorderRadius.circular(40)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(16.0).copyWith(bottom: 24),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Tax Information",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 24,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      "Name as per PAN",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue: controller
                                            .glocker.value?.nameAsPerPan ??
                                        '',
                                    validator: (value) {
                                      if (value!.trim().length < 3) {
                                        return "Enter a valid name";
                                      }
                                      return null;
                                    },
                                    decoration: formDecoration(
                                            "Name", "Enter your name")
                                        .copyWith(
                                            fillColor: Get.theme.dividerColor),
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
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        controller.glocker.value?.panNumber ??
                                            '',
                                    decoration: formDecoration("Pan Number",
                                            "Enter your Pan Number")
                                        .copyWith(
                                            fillColor: Get.theme.dividerColor),
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
                                    readOnly: true,
                                    initialValue:
                                        controller.glocker.value?.panNumber ??
                                            '',
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
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _NotificationPreference extends GetView<GlockerMoreController> {
  @override
  Widget build(BuildContext context) {
    return Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 6,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Get.theme.dividerColor,
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 34),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Notification Preference",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                _NotificationPreferenceTile(
                  title: "Special Offers and Promotions",
                  subtitle:
                      "Receive notifications about special offers, discounts, and promotions.",
                ),
                SizedBox(
                  height: 20,
                ),
                _NotificationPreferenceTile(
                  title: "New Celebrities",
                  subtitle:
                      "Stay informed about the latest celebrity additions to the app.",
                ),
                SizedBox(
                  height: 20,
                ),
                _NotificationPreferenceTile(
                  title: "Online Status",
                  subtitle:
                      "Get notifications when your favourite celebrity online.",
                ),
                SizedBox(
                  height: 20,
                ),
                _NotificationPreferenceTile(
                  title: "Recommendations",
                  subtitle:
                      "Receive notifications suggesting celebrities you may be interested in based on your preferences",
                ),
                SizedBox(
                  height: 20,
                ),
              ]))
        ])));
  }
}

class _NotificationPreferenceTile extends StatelessWidget {
  _NotificationPreferenceTile({
    super.key,
    required this.title,
    required this.subtitle,
  });
  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style:
                      TextStyle(fontSize: 12, color: MetaColors.tertiaryText),
                ),
              ],
            ),
          ),
          CupertinoSwitch(value: true, onChanged: (value) {})
        ],
      ),
    );
  }
}

class _TermsAndConditions extends GetView<GlockerMoreController> {
  @override
  Widget build(BuildContext context) {
    return Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 6,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Get.theme.dividerColor,
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 34),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Terms and Conditions",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "These terms and conditions outline the rules and regulations for the use of Glockers's Website, located at www.glockers.com.By accessing this website, we assume you accept these terms and conditions. Do not continue to use Glockers.com if you do not agree to take all of the terms and conditions stated on this page.\nCookies:The website uses cookies to help personalize your online experience. By accessing Glockers.com, you agreed to use the required cookies.A cookie is a text file that is placed on your hard disk by a web page server. Cookies cannot be used to run programs or deliver viruses to your computer. Cookies are uniquely assigned to you and can only be read by a web server in the domain that issued the cookie to you.",
                  style:
                      TextStyle(fontSize: 15, color: MetaColors.tertiaryText),
                ),
                SizedBox(
                  height: 20,
                ),
              ]))
        ])));
  }
}
