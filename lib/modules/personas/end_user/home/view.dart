import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/controllers/bottom_navigation_controller.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/personas/end_user/glocker_profile/binding.dart';
import 'package:glok/modules/personas/end_user/browse/view.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/modules/personas/end_user/home/controller.dart';
import 'package:glok/modules/personas/end_user/more/view.dart';
import 'package:glok/modules/personas/end_user/video/view.dart';
import 'package:glok/modules/wallet/view.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/meta_strings.dart';
import '../browse/celeb_by_category/binding.dart';
import '../browse/celeb_by_category/view.dart';
import '../glocker_profile/view.dart';
import '../trending_glockers/binding.dart';
import '../trending_glockers/view.dart';
import '../video/binding.dart';

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
                              ? EndUserMoreView()
                              : BrowseView()
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
                                    Obx(
                                      () => Container(
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
                                                          BorderRadius.circular(
                                                              40)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0)
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
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                          () =>
                                                              TrendingGlockersView(),
                                                          binding:
                                                              TrendingGlockersBinding());
                                                    },
                                                    child: Text(
                                                      "View All",
                                                      style: Get.theme.textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Get.theme
                                                                  .primaryColor),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0)
                                                      .copyWith(
                                                          right: 0, top: 0),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: List.generate(
                                                      GlockerListController
                                                          .to
                                                          .trendingGlockers
                                                          .value!
                                                          .length,
                                                      (index) => GlockerTile(
                                                            data: GlockerListController
                                                                .to
                                                                .trendingGlockers
                                                                .value![index],
                                                            resfreshEnum:
                                                                RefreshEnum
                                                                    .refreshTrendingGlockers,
                                                          )),
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
                                              padding:
                                                  const EdgeInsets.all(16.0)
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
                                            Obx(
                                              () => Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0)
                                                        .copyWith(
                                                            right: 0, top: 0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: List.generate(
                                                        GlockerListController
                                                            .to
                                                            .favoriteGlockers
                                                            .value!
                                                            .length,
                                                        (index) => GlockerTile(
                                                              data: GlockerListController
                                                                  .to
                                                                  .favoriteGlockers
                                                                  .value![index],
                                                              resfreshEnum:
                                                                  RefreshEnum
                                                                      .refreshFavoriteGlockers,
                                                            )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                      child: CachedNetworkImage(
                        imageUrl: glockerModel.value?.profilePhoto ?? '',
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
                      Flexible(
                        child: Text(
                          "${data.name}",
                          style: Get.theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Get.theme.colorScheme.secondary),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      if (glockerModel.value?.isOnline ?? false)
                        CircleAvatar(
                          radius: 5.6,
                          backgroundColor: MetaColors.transactionSuccess,
                        )
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
              InkWell(
                onTap: () {
                  BottomNavigationController.to.changePage(3);
                },
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      AuthController.to.user.value?.photo ?? ''),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Welcome Back",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
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
                      pageTitleList.length,
                      (index) => PageSelectorTile(
                          ontap: () {
                            // controller.changePage(index);
                            GlockerListController.to
                                .changeCategory(pageTitleList[index]);
                            Get.to(CelebByCategoryView(),
                                binding: CelebByCategoryBinding());
                          },
                          selected: pageTitleList[index] ==
                              GlockerListController.to.currentCategory.value,
                          title: pageTitleList[index])),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
