import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/utils/meta_assets.dart';

import '../../../../utils/helpers.dart';
import '../../../../utils/meta_colors.dart';
import 'controller.dart';

class ApplyToGlockerView extends GetView<ApplyToGlockerController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        children: [
          _BasicDetailsWidget(),
          _TaxInfoWidget(),
          _AadhaarInfoWidget(),
          _VideoKYCWidget(),
          Container(
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
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
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
                      CustomButton(title: "Continue", onPressed: () {})
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _VideoKYCWidget extends StatelessWidget {
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
            onPressed: () {},
          ),
          title: Text(
            "Video KYC",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MetaColors.primaryText),
          )),
      body: Padding(
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 440,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Get.theme.dividerColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.dividerColor.withOpacity(0.3)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(MetaAssets.addCoverImage),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Take a Video",
                                style:
                                    TextStyle(color: MetaColors.tertiaryText),
                              )
                            ],
                          ),
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
            CustomButton(title: "Continue", onPressed: () {})
          ],
        ),
      ),
    ));
  }
}

class _AadhaarInfoWidget extends StatelessWidget {
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
            onPressed: () {},
          ),
          title: Text(
            "Aadhaar Details",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MetaColors.primaryText),
          )),
      body: Padding(
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
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Container(
                          height: 220,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Get.theme.dividerColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.dividerColor.withOpacity(0.3)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(MetaAssets.addCoverImage),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Upload or Take a Photo",
                                style:
                                    TextStyle(color: MetaColors.tertiaryText),
                              )
                            ],
                          ),
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
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Container(
                          height: 220,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Get.theme.dividerColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(8),
                              color: Get.theme.dividerColor.withOpacity(0.3)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(MetaAssets.addCoverImage),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Upload or Take a Photo",
                                style:
                                    TextStyle(color: MetaColors.tertiaryText),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(title: "Continue", onPressed: () {})
          ],
        ),
      ),
    ));
  }
}

class _TaxInfoWidget extends StatelessWidget {
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
            onPressed: () {},
          ),
          title: Text(
            "Tax Information",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MetaColors.primaryText),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        TextFormField(
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
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        TextFormField(
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
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                "(optional)",
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
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
            CustomButton(title: "Continue", onPressed: () {})
          ],
        ),
      ),
    ));
  }
}

class _BasicDetailsWidget extends StatelessWidget {
  const _BasicDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(MetaAssets.coverPlaceHolder),
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
                              CircleAvatar(
                                backgroundColor: Colors.black38,
                                child: SvgPicture.asset(
                                  MetaAssets.addCoverImage,
                                  colorFilter: ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
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
                                        topRight: Radius.circular(24))),
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
                                            padding: const EdgeInsets.only(
                                                bottom: 6),
                                            child: Text(
                                              "Name",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          TextFormField(
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
                                            padding: const EdgeInsets.only(
                                                bottom: 6),
                                            child: Text(
                                              "Category",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          DropdownButtonFormField(
                                            value: "influencer",
                                            items: ["influencer", "movie star"]
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e),
                                                      value: e,
                                                    ))
                                                .toList(),
                                            onChanged: (value) {},
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
                                            padding: const EdgeInsets.only(
                                                bottom: 6),
                                            child: Text(
                                              "About Me",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          TextFormField(
                                            maxLines: 2,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 6),
                                            child: Text(
                                              "Per Minute Rate",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          TextFormField(
                                            decoration: formDecoration(
                                                "Per Minute Rate", ""),
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
                                    CircleAvatar(
                                      radius: 54,
                                      child: SvgPicture.asset(
                                          MetaAssets.placeHolderProfile),
                                      backgroundColor: Get.theme.dividerColor,
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 14,
                                          child: SvgPicture.asset(
                                              MetaAssets.addPhoto)),
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
                  child: CustomButton(title: "Continue", onPressed: () {}),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
