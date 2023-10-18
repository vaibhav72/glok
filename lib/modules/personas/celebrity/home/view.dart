import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/personas/celebrity/home/chart.dart';
import 'package:glok/modules/personas/celebrity/home/controller.dart';
import 'package:glok/modules/personas/celebrity/more/view.dart';
import 'package:glok/modules/personas/end_user/glocker_profile/binding.dart';
import 'package:glok/modules/personas/end_user/browse/view.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/modules/personas/end_user/home/controller.dart';
import 'package:glok/modules/personas/end_user/more/view.dart';
import 'package:glok/modules/wallet/view.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../end_user/glocker_profile/view.dart';
import '../my_glocker_profile/view.dart';

class GlockerHomeView extends GetView<EndUserHomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
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
                  selectedLabelStyle: TextStyle(
                      color: MetaColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  unselectedLabelStyle: TextStyle(
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
                            colorFilter: ColorFilter.mode(
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
                              colorFilter: ColorFilter.mode(
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
                        label: "Glok"),
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
                              colorFilter: ColorFilter.mode(
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
                            child: Text(""),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              width: double.maxFinite,
                              color: Colors.white,
                              child: Text(""),
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
                      : Padding(
                          padding: MediaQuery.of(context).padding,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0)
                                    .copyWith(bottom: 0),
                                child: CustomAppBar(),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      width: double.maxFinite,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Container(
                                                height: 6,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Get.theme.dividerColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0)
                                                .copyWith(bottom: 8),
                                            child: Text(
                                              "Weekly Dashboard",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: _EarningsTile()),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                    child: _TotalMinutesTile())
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: _TotalUsersTile()),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                    child: _TotalMinutesTile())
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Container(
                                              height: 293,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                    child: Text(
                                                      "Weekly Earning Trend",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Chart(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            height: 2,
                                                            width: 12,
                                                            color:
                                                                Colors.orange),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text("Earning"),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Get
                                                          .theme.dividerColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
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
                ],
              ))),
    );
  }
}

class _EarningsTile extends StatelessWidget {
  const _EarningsTile({
    super.key,
  });

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
            Text(
              "Total Earnings",
              style: TextStyle(fontSize: 15, color: MetaColors.secondaryText),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                getCurrency(18500),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
            getPercentageDifference(11)
          ],
        ),
      ),
    );
  }
}

class _TotalUsersTile extends StatelessWidget {
  const _TotalUsersTile({
    super.key,
  });

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
            Text(
              "Total Users",
              style: TextStyle(fontSize: 15, color: MetaColors.secondaryText),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "100",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
            getPercentageDifference(-21)
          ],
        ),
      ),
    );
  }
}

class _TotalMinutesTile extends StatelessWidget {
  const _TotalMinutesTile({
    super.key,
  });

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
            Text(
              "Total Minutes",
              style: TextStyle(fontSize: 15, color: MetaColors.secondaryText),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "108",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
            getPercentageDifference(-9)
          ],
        ),
      ),
    );
  }
}

class GlockerTile extends GetView<GlockerListController> {
  GlockerTile({super.key, required this.data, required this.resfreshEnum})
      : glockerModel = Rxn(data);
  GlockerModel data;
  RefreshEnum resfreshEnum;
  void Function()? handler;
  Rxn<GlockerModel> glockerModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handler ??
          () {
            GlockerListController.to.viewGlocker(data);
          },
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 160,
            height: 234,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        MetaAssets.dummyCeleb,
                        fit: BoxFit.fill,
                        width: double.maxFinite,
                        height: double.maxFinite,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          if (glockerModel.value?.isFavourite ?? false) {
                            glockerModel.value!.isFavourite = false;
                          } else {
                            glockerModel.value!.isFavourite = true;
                          }
                          glockerModel.refresh();
                          GlockerListController.to
                              .handleFavourite(data, resfreshEnum);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.black12,
                            child: (glockerModel.value?.isFavourite ?? false)
                                ? SvgPicture.asset(
                                    MetaAssets.likeOutlineIcon,
                                    colorFilter: ColorFilter.mode(
                                        Colors.green, BlendMode.srcIn),
                                  )
                                : SvgPicture.asset(MetaAssets.likeOutlineIcon),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(48),
                              color: Colors.black.withOpacity(0.6)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: RichText(
                              text: TextSpan(
                                  text: "\u20b9",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                        text: " ${data.price}/min",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500))
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${data.name}",
                        style: Get.theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Get.theme.colorScheme.secondary),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text("${data.category}",
                      style: GoogleFonts.newsreader(
                          color: MetaColors.secondaryText,
                          fontStyle: FontStyle.italic)),
                ],
              ))
            ]),
          ),
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
                style: TextStyle(fontSize: 16, color: Colors.white),
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
              CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                    controller.currentGlocker.value!.profilePhoto!),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    "Online",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: InkWell(
                        onTap: () {
                          controller.changeStatus();
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 42,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18)),
                          child: Align(
                            alignment: controller.online.value!
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundColor: controller.online.value!
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
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
