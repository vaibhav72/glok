import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glok/data/models/bidlist_model.dart';
import 'package:glok/modules/personas/celebrity/bid/controller.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GlockerBiddingView extends GetView<GlockerBiddingController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => (controller.bidList.value?.isEmpty ?? false)
          ? Center(
              child: Text(""),
            )
          : Stack(
              children: [
                CachedNetworkImage(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    imageUrl:
                        controller.bidList.value?.first.profilePhoto ?? ''),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Container(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 90,
                                  backgroundImage: CachedNetworkImageProvider(
                                      controller.bidList.value?.first
                                              .profilePhoto ??
                                          ''),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "${controller.bidList.value?.first.userName ?? ''}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      MetaAssets.starFilled,
                                      height: 22,
                                      width: 22,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "${controller.bidList.value?.first.rating ?? ''}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.showQueue.value ?? false,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16))),
                                constraints: BoxConstraints(
                                    maxHeight: Get.size.height * .5),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${controller.bidList.value?.length} are in queue",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                controller.showQueue.value =
                                                    false;
                                              },
                                              child: SvgPicture.asset(
                                                  MetaAssets.closeQueue))
                                        ],
                                      ),
                                      Divider(),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: controller.bidList.value!
                                                .map((e) =>
                                                    _BidWidgetTile(data: e))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              child: Column(
                                children: [
                                  if (controller.bidList.value?.isNotEmpty ??
                                      false)
                                    InkWell(
                                      onTap: () {
                                        controller.showQueue.value = true;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                                vertical: 15)
                                            .copyWith(top: 0),
                                        child: Text(
                                          "View Queue (${controller.bidList.value?.length})",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Get.theme.primaryColor),
                                        ),
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            controller.rejectAllCall();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                color: MetaColors
                                                    .transactionFailed),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        MetaAssets.endCall),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Reject',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            controller.acceptCall(controller
                                                .bidList.value!.first);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                color: MetaColors.primary),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        MetaAssets.acceptCall),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Accept',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _BidWidgetTile extends StatelessWidget {
  _BidWidgetTile({
    super.key,
    required this.data,
  });

  BidListModel data;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage:
                  CachedNetworkImageProvider(data.profilePhoto ?? ''),
            ),
          ),
          Expanded(
            child: Text(
              data.userName ?? '',
              style: TextStyle(fontSize: 15, color: MetaColors.primaryText),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: Get.theme.primaryColor.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              child: Text(
                "\u20b9 ${data.amount}/min",
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: MetaColors.secondaryPurple),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  GlockerBiddingController.to.rejectCall(data.userId!);
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: MetaColors.transactionFailed,
                  child: SvgPicture.asset(
                    MetaAssets.endCall,
                    height: 18,
                    width: 18,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  GlockerBiddingController.to.acceptCall(data);
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Get.theme.primaryColor,
                  child: SvgPicture.asset(
                    MetaAssets.acceptCall,
                    height: 18,
                    width: 18,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
