import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/celebrity/celeb_profile/binding.dart';
import 'package:glok/modules/personas/end_user/browse/view.dart';
import 'package:glok/modules/personas/end_user/home/controller.dart';
import 'package:glok/modules/wallet/view.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../celebrity/celeb_profile/view.dart';

class EndUserHomeView extends GetView<EndUserHomeController> {
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
                            child: SvgPicture.asset(
                              MetaAssets.browseIcon,
                              height: 18,
                              width: 18,
                            ),
                          ),
                        ),
                        activeIcon: SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            MetaAssets.browseIcon,
                            height: 18,
                            width: 18,
                            colorFilter: ColorFilter.mode(
                                MetaColors.primary, BlendMode.srcIn),
                          ),
                        ),
                        label: "Browse"),
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
                        Container(
                          height: Get.height * .55,
                          color: Colors.transparent,
                          child: Text(""),
                        ),
                        Expanded(
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
                          ? BrowseView()
                          : WalletView()
                      : Padding(
                          padding: MediaQuery.of(context).padding,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CustomAppBar(),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        CarouselSlider(
                                            items: controller.carouselItems,
                                            options: CarouselOptions(
                                              height: 180,
                                              // aspectRatio: 16 / 9,
                                              viewportFraction: 1,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              reverse: false,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  Duration(seconds: 3),
                                              autoPlayAnimationDuration:
                                                  Duration(milliseconds: 800),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              enlargeCenterPage: true,
                                              onPageChanged: (index, reason) {
                                                controller.currentCarousel
                                                    .value = index;
                                              },
                                              enlargeFactor: 0.3,
                                              scrollDirection: Axis.horizontal,
                                            )),
                                        Obx(
                                          () => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                                controller.carouselItems.length,
                                                (index) {
                                              return GestureDetector(
                                                onTap: () => controller
                                                    .carouselController
                                                    .animateToPage(index),
                                                child: AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  width: 20.0,
                                                  height: 4,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 2.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: Colors.white
                                                          .withOpacity(controller
                                                                      .currentCarousel ==
                                                                  index
                                                              ? 1
                                                              : 0.4)),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
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
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Trending",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Get
                                                          .theme
                                                          .colorScheme
                                                          .secondary,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "View All",
                                                  style: Get.theme.textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Get.theme
                                                              .primaryColor),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0)
                                                .copyWith(right: 0, top: 0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(10,
                                                    (index) => CelebrityTile()),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.maxFinite,
                                            child: CustomPaint(
                                              painter: DashedLinePainter(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0)
                                                .copyWith(bottom: 8),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "My Favorites",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Get
                                                          .theme
                                                          .colorScheme
                                                          .secondary,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "View All",
                                                  style: Get.theme.textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Get.theme
                                                              .primaryColor),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0)
                                                .copyWith(right: 0, top: 0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(10,
                                                    (index) => CelebrityTile()),
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
                ],
              ))),
    );
  }
}

class CelebrityTile extends StatelessWidget {
  const CelebrityTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CelebrityProfileView(),
            binding: CelebrityProfileBinding());
      },
      child: Padding(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.black12,
                        child: SvgPicture.asset(MetaAssets.likeOutlineIcon),
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
                                      text: " 499/min",
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
                      "Nora Fatehi",
                      style: Get.theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Get.theme.colorScheme.secondary),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text("Movie Star",
                    style: GoogleFonts.newsreader(
                        color: MetaColors.secondaryText,
                        fontStyle: FontStyle.italic)),
              ],
            ))
          ]),
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

class CustomAppBar extends GetView<EndUserHomeController> {
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
                backgroundImage: AssetImage(MetaAssets.dummyProfile),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    SvgPicture.asset(MetaAssets.notificationIcon)
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Obx(
            () => Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      controller.pageTitleList.length,
                      (index) => PageSelectorTile(
                          ontap: () {
                            controller.changePage(index);
                          },
                          selected: controller.selectedPage == index,
                          title: controller.pageTitleList[index])),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
