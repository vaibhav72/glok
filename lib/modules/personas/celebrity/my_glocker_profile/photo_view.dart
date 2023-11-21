import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:glok/modules/personas/end_user/apply_glocker/view.dart';
import 'package:glok/utils/helpers.dart';

import 'controller.dart';

class PhotoView extends GetView<MyGlockerProfileController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.handlePhotoBackButton();
        return Future.value(false);
      },
      child: Scaffold(
        body: Obx(
          () => controller.loading.value!
              ? Center(
                  child: Loader(),
                )
              : Stack(
                  children: [
                    Column(
                      children: [
                        if (controller.selectedGalleryItem.value != null ||
                            controller.selectedFile.value != null)
                          Expanded(
                            child: controller.isUploadPreview.value!
                                ? Image.file(
                                    File(
                                      controller.selectedFile.value!.path,
                                    ),
                                    fit: BoxFit.fill,
                                  )
                                : CachedNetworkImage(
                                    width: double.maxFinite,
                                    imageUrl: controller
                                        .selectedGalleryItem.value!.file!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        if (controller.isUploadPreview.value!)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                                title: "Upload",
                                onPressed: () {
                                  controller.uploadPhoto();
                                }),
                          )
                      ],
                    ),
                    Padding(
                      padding: MediaQuery.of(context).padding,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.handlePhotoBackButton();
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
                            if (controller.isCurrentGlocker &&
                                !controller.isUploadPreview.value!)
                              InkWell(
                                  onTap: () {
                                    controller.deleteGalleryItem();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
