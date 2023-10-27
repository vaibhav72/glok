import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:glok/data/models/bidlist_model.dart';

import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller.dart';

class UserBiddingView extends GetView<UserBiddingController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Obx(
        () => Stack(
          children: [
            CachedNetworkImage(
              imageUrl: controller.glocker.value?.profilePhoto ?? '',
              fit: BoxFit.cover,
              height: double.maxFinite,
              width: double.maxFinite,
            ),
            Container(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        )
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
                        constraints:
                            BoxConstraints(maxHeight: Get.size.height * .6),
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
                                        controller.showQueue.value = false;
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
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              child: _BidWidgetTile(data: e),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                              Divider(),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "Increasing the per-minute call amount will put you at the top of the queue"),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.showPrice();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(44),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Get.theme.primaryColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 6),
                                          child: Text(
                                            "Change",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Get.theme.primaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
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
                          if (controller.bidList.value?.isNotEmpty ?? false)
                            InkWell(
                              onTap: () {
                                controller.showQueue.value =
                                    !controller.showQueue.value!;
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15)
                                        .copyWith(top: 0),
                                child: Text(
                                  "${controller.showQueue.value! ? "Hide" : "View"} Queue (${controller.bidList.value?.length})",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Get.theme.primaryColor),
                                ),
                              ),
                            ),
                          InkWell(
                            onTap: () {
                              Get.back();
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  color: MetaColors.transactionFailed),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(MetaAssets.endCall),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'End Video Call',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(48),
                                    color: Get.theme.primaryColor
                                        .withOpacity(0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  child: Text(
                                    '\u20b9 ${controller.glocker.value?.price ?? '0'}/min',
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "View Disclaimer",
                                style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
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
            child: Row(
              children: [
                Text(
                  '${data.userName ?? ''}',
                  style: TextStyle(fontSize: 15, color: MetaColors.primaryText),
                )
              ],
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: Get.theme.primaryColor.withOpacity(0.1)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Text(
                  "\u20b9 ${data.amount}/min",
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: MetaColors.secondaryPurple),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
