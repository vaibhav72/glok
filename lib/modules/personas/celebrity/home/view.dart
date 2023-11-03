import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/personas/celebrity/bid/binding.dart';
import 'package:glok/modules/personas/celebrity/bid/view.dart';
import 'package:glok/modules/personas/celebrity/home/chart.dart';
import 'package:glok/modules/personas/celebrity/home/controller.dart';
import 'package:glok/modules/personas/celebrity/more/view.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/modules/personas/end_user/glocker_profile/binding.dart';
import 'package:glok/modules/personas/end_user/browse/view.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/modules/personas/end_user/home/controller.dart';
import 'package:glok/modules/personas/end_user/more/view.dart';
import 'package:glok/modules/wallet/view.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:glok/utils/meta_strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/bottom_navigation_controller.dart';
import '../../end_user/glocker_profile/view.dart';
import '../my_glocker_profile/view.dart';
import '../video/binding.dart';
import '../video/view.dart';

class GlockerHomeView extends GetView<GlockerHomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
            height: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                MetaAssets.background,
              ),
              fit: BoxFit.cover,
            )),
            child: Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                    onTap: (value) {
                      controller.bottomNav.changePage(value);
                    },
                    type: BottomNavigationBarType.fixed,
                    currentIndex: controller.bottomNav.currentIndex.value,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    selectedItemColor: MetaColors.primary,
                    unselectedItemColor: Colors.grey,
                    selectedLabelStyle: const TextStyle(
                        color: MetaColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    items: [
                      BottomNavigationBarItem(
                          icon: SizedBox(
                            height: 24,
                            width: 24,
                            child: SvgPicture.asset(
                              MetaAssets.homeIcon,
                            ),
                          ),
                          activeIcon: SizedBox(
                            height: 24,
                            width: 24,
                            child: SvgPicture.asset(
                              MetaAssets.homeIcon,
                              colorFilter: const ColorFilter.mode(
                                  MetaColors.primary, BlendMode.srcIn),
                            ),
                          ),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: SizedBox(
                            height: 24,
                            width: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                MetaAssets.walletIcon,
                              ),
                            ),
                          ),
                          activeIcon: SizedBox(
                            height: 24,
                            width: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                MetaAssets.walletIcon,
                                colorFilter: const ColorFilter.mode(
                                    MetaColors.primary, BlendMode.srcIn),
                              ),
                            ),
                          ),
                          label: "Wallet"),
                      BottomNavigationBarItem(
                          icon: SizedBox(
                            height: 24,
                            width: 24,
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    AuthController
                                        .to.glocker.value!.profilePhoto!),
                              ),
                            ),
                          ),
                          activeIcon: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    AuthController
                                        .to.glocker.value!.profilePhoto!),
                              )),
                          label: "Gloker"),
                      BottomNavigationBarItem(
                          icon: SizedBox(
                            height: 24,
                            width: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                MetaAssets.moreIcon,
                                height: 20,
                                width: 14.5,
                              ),
                            ),
                          ),
                          activeIcon: SizedBox(
                            height: 24,
                            width: 24,
                            child: Center(
                              child: SvgPicture.asset(
                                MetaAssets.moreIcon,
                                height: 20,
                                width: 14.5,
                                colorFilter: const ColorFilter.mode(
                                    MetaColors.primary, BlendMode.srcIn),
                              ),
                            ),
                          ),
                          label: "More"),
                    ]),
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: Get.height,
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: Get.height * .55,
                              color: Colors.transparent,
                              child: const Text(""),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                width: double.maxFinite,
                                color: Colors.white,
                                child: const Text(""),
                              ))
                        ],
                      ),
                    ),
                    controller.bottomNav.currentIndex.value != 0
                        ? controller.bottomNav.currentIndex.value != 1
                            ? controller.bottomNav.currentIndex.value != 2
                                ? GlockerMoreView()
                                : MyGlockerProfileView()
                            : WalletView()
                        : Obx(
                            () => Padding(
                              padding: MediaQuery.of(context).padding,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0)
                                        .copyWith(bottom: 0),
                                    child: const CustomAppBar(),
                                  ),
                                  Expanded(
                                      child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          width: double.maxFinite,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Container(
                                                    height: 6,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        color: Get
                                                            .theme.dividerColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40)),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16.0)
                                                          .copyWith(bottom: 8),
                                                  child: const Text(
                                                    "Weekly Dashboard",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: _EarningsTile(
                                                      value: (controller
                                                                  .glockerStats
                                                                  .value
                                                                  ?.totalAmount ??
                                                              0)
                                                          .toString(),
                                                      percentage: (controller
                                                                  .glockerStats
                                                                  .value
                                                                  ?.percentageAmountChange ??
                                                              0)
                                                          .toDouble(),
                                                    )),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                        child:
                                                            _TotalMinutesTile(
                                                      value: (controller
                                                                  .glockerStats
                                                                  .value
                                                                  ?.totalDuration ??
                                                              0)
                                                          .toString(),
                                                      percentage: (controller
                                                                  .glockerStats
                                                                  .value
                                                                  ?.percentageDurationChange ??
                                                              0)
                                                          .toDouble(),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: _TotalUsersTile(
                                                      value: (controller
                                                                  .glockerStats
                                                                  .value
                                                                  ?.totalUser ??
                                                              0)
                                                          .toString(),
                                                      percentage: (controller
                                                                  .glockerStats
                                                                  .value
                                                                  ?.percentageUserChange ??
                                                              0)
                                                          .toDouble(),
                                                    )),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                        child:
                                                            _TotalMinutesTile(
                                                      value: (controller
                                                                  .glockerStats
                                                                  .value
                                                                  ?.totalDuration ??
                                                              0)
                                                          .toString(),
                                                      percentage: (controller
                                                                  .glockerStats
                                                                  .value
                                                                  ?.percentageDurationChange ??
                                                              0)
                                                          .toDouble(),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              if (controller
                                                      .glockerStats.value !=
                                                  null)
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Container(
                                                    height: 293,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Get.theme
                                                                .dividerColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 8),
                                                          child: Text(
                                                            "Weekly Earning Trend",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Chart(
                                                              stats: controller
                                                                  .glockerStats
                                                                  .value!,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                  height: 2,
                                                                  width: 12,
                                                                  color: Colors
                                                                      .orange),
                                                              const SizedBox(
                                                                width: 4,
                                                              ),
                                                              const Text(
                                                                  "Earning"),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                  ],
                )));
      },
    );
  }
}

class _EarningsTile extends StatelessWidget {
  const _EarningsTile({
    super.key,
    required this.value,
    required this.percentage,
  });
  final String value;
  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Get.theme.dividerColor)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Earnings",
              style: TextStyle(fontSize: 15, color: MetaColors.secondaryText),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                getCurrency(double.parse(value.trim())),
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
            getPercentageDifference(percentage)
          ],
        ),
      ),
    );
  }
}

class _TotalUsersTile extends StatelessWidget {
  const _TotalUsersTile({
    super.key,
    required this.value,
    required this.percentage,
  });
  final String value;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Get.theme.dividerColor)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Users",
              style: TextStyle(fontSize: 15, color: MetaColors.secondaryText),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "$value",
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
            getPercentageDifference(percentage)
          ],
        ),
      ),
    );
  }
}

class _TotalMinutesTile extends StatelessWidget {
  const _TotalMinutesTile({
    super.key,
    required this.value,
    required this.percentage,
  });
  final String value;
  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Get.theme.dividerColor)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Minutes",
              style: TextStyle(fontSize: 15, color: MetaColors.secondaryText),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "$value",
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
            getPercentageDifference(percentage)
          ],
        ),
      ),
    );
  }
}

class PageSelectorTile extends StatelessWidget {
  PageSelectorTile(
      {super.key,
      required this.ontap,
      required this.selected,
      required this.title});
  String title;
  bool selected;
  void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: selected ? Colors.white : Colors.transparent),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends GetView<GlockerHomeController> {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  BottomNavigationController.to.changePage(3);
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(
                      controller.currentGlocker.value!.profilePhoto!),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Text(
                    "Online",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: InkWell(
                        onTap: () {
                          PersonaController.to.changeStatus();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 42,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18)),
                          child: Align(
                            alignment: PersonaController.to.online.value!
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundColor:
                                      PersonaController.to.online.value!
                                          ? Colors.green
                                          : Get.theme.dividerColor,
                                )),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
