import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/bid/view.dart';
import 'package:glok/modules/personas/end_user/glocker_profile/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';

import '../bid/binding.dart';

class GlockerProfileView extends GetView<GlockerProfileController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  child: Stack(
                    children: [
                      Obx(
                        () => Container(
                          height: Get.height * .35,
                          child: controller.glocker?.value?.coverPhoto != null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      controller.glocker?.value?.coverPhoto ??
                                          '',
                                  fit: BoxFit.fill,
                                  width: double.maxFinite,
                                )
                              : SizedBox(),
                        ),
                      ),
                      Padding(
                        padding: MediaQuery.of(context).padding,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                controller.isCurrentGlocker
                                    ? InkWell(
                                        onTap: () {
                                          controller.addGalleryItem();
                                        },
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black12,
                                            child: SvgPicture.asset(
                                                MetaAssets.addGallery)),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        child: SvgPicture.asset(
                                            MetaAssets.likeOutlineIcon),
                                      )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: Get.height * .15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24)),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 96,
                                              height: 96,
                                              child: Stack(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 48,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                            controller
                                                                    .glocker
                                                                    ?.value
                                                                    ?.profilePhoto ??
                                                                ''),
                                                  ),
                                                  if (controller.glocker?.value
                                                          ?.isOnline ??
                                                      false)
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(8.0)
                                                                .copyWith(
                                                                    bottom: 5),
                                                        child: CircleAvatar(
                                                          radius: 7.35,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: CircleAvatar(
                                                            radius: 5.6,
                                                            backgroundColor:
                                                                MetaColors
                                                                    .transactionSuccess,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                                child: Container(
                                                    child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      controller.glocker?.value
                                                              ?.name ??
                                                          '',
                                                      style: Get.theme.textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 24,
                                                              color: Get
                                                                  .theme
                                                                  .colorScheme
                                                                  .secondary),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                    controller.glocker?.value
                                                            ?.category ??
                                                        '',
                                                    style:
                                                        GoogleFonts.newsreader(
                                                            color: MetaColors
                                                                .secondaryText,
                                                            fontSize: 16,
                                                            fontStyle: FontStyle
                                                                .italic)),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFCCE2A),
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      "4.7 (63)",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF737373)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20)
                                          .copyWith(top: 0),
                                      child: CustomButtonWithChild(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  MetaAssets.videoCallIcon),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Video Call @",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                        text: "\u20b9",
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  " ${controller.glocker?.value?.price ?? "0"}/min",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))
                                                        ]),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          onPressed: () {
                                            if (!controller.isCurrentGlocker)
                                              controller.gotoVideo();
                                          }),
                                    ),
                                    Container(
                                      child: TabBar(
                                          isScrollable: true,
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          labelStyle: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          unselectedLabelStyle:
                                              GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                          tabs: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                        MetaAssets.profileIcon),
                                                  ),
                                                  Text(
                                                    "About",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                        MetaAssets.photosIcon),
                                                  ),
                                                  Text("Photos")
                                                ],
                                              ),
                                            ),
                                            Container(
                                                child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset(
                                                      MetaAssets.videoIcon),
                                                ),
                                                Text("Videos")
                                              ],
                                            )),
                                          ]),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: TabBarView(children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(controller.glocker?.value?.aboutMe ?? '')),
                    SizedBox(
                      height: 10,
                    ),
                    // RichText(
                    //     textScaleFactor:
                    //         MediaQuery.of(context).textScaleFactor,
                    //     text: TextSpan(
                    //         text: "Born: ",
                    //         style: GoogleFonts.poppins(
                    //             fontWeight: FontWeight.w600,
                    //             color: MetaColors.primaryText),
                    //         children: [
                    //           TextSpan(
                    //               text:
                    //                   "6 February 1992 (age 31 years), Toronto",
                    //               style: GoogleFonts.poppins(
                    //                   fontWeight: FontWeight.w400))
                    //         ])),
                    // RichText(
                    //     textScaleFactor:
                    //         MediaQuery.of(context).textScaleFactor,
                    //     text: TextSpan(
                    //         text: "Nationality: ",
                    //         style: GoogleFonts.poppins(
                    //             fontWeight: FontWeight.w600,
                    //             color: MetaColors.primaryText),
                    //         children: [
                    //           TextSpan(
                    //               text: "Canadian",
                    //               style: GoogleFonts.poppins(
                    //                   fontWeight: FontWeight.w400))
                    //         ])),
                    // RichText(
                    //     textScaleFactor:
                    //         MediaQuery.of(context).textScaleFactor,
                    //     text: TextSpan(
                    //         text: "Siblings: ",
                    //         style: GoogleFonts.poppins(
                    //             fontWeight: FontWeight.w600,
                    //             color: MetaColors.primaryText),
                    //         children: [
                    //           TextSpan(
                    //               text: "Omar Fatehi",
                    //               style: GoogleFonts.poppins(
                    //                   fontWeight: FontWeight.w400))
                    //         ]))
                  ],
                ),
              ),
            ),
            Container(
              child: Obx(
                () => GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(
                      controller.galleryPhotos.value!.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                              onTap: () {
                                controller.viewGalleryItem(
                                    controller.galleryPhotos.value![index]!);
                              },
                              child: CachedNetworkImage(
                                imageUrl: controller
                                        .galleryPhotos.value![index]!.file ??
                                    '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                ),
              ),
            ),
            Obx(
              () => Container(
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: EdgeInsets.all(3),
                  children: List.generate(
                      controller.galleryVideos.value!.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                                onTap: () {
                                  controller.viewGalleryItem(
                                      controller.galleryVideos.value![index]!);
                                },
                                child: VTImageView(
                                  fit: BoxFit.cover,
                                  assetPlaceHolder: MetaAssets.dummyCeleb,
                                  videoUrl: controller
                                          .galleryVideos.value![index]!.file ??
                                      '',
                                  errorBuilder: (context, error, stack) {
                                    return Container(
                                      color: Colors.green,
                                      child: const Center(
                                        child: Text("error loading Image"),
                                      ),
                                    );
                                  },
                                )),
                          )),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
