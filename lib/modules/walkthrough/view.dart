import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller.dart';

class WalkthroughView extends GetView<WalkthroughController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: PageView(
        controller: controller.pageController,
        children: List.generate(
            controller.pages.length,
            (index) => Scaffold(
                  body: Container(
                    child: Column(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: controller.pages[index].image,
                        )),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(
                                controller.pages[index].title,
                                style: GoogleFonts.newsreader(
                                    color: Get.theme.primaryColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.all(24).copyWith(top: 0),
                              child: Text(
                                controller.pages[index].description,
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.skip();
                                },
                                child: Text(
                                  "Skip",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF999999)),
                                ),
                              ),
                              Row(
                                children: List.generate(
                                    controller.pages.length,
                                    (i) => Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: CircleAvatar(
                                            radius: 5,
                                            backgroundColor: index == i
                                                ? Get.theme.primaryColor
                                                : Color(0xFFDCDDDD),
                                          ),
                                        )),
                              ),
                              InkWell(
                                onTap: () {
                                  if (index == controller.pages.length - 1)
                                    controller.skip();
                                  else
                                    controller.nextPage();
                                },
                                child: Text(
                                  index == controller.pages.length - 1
                                      ? "Finish"
                                      : "Next",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Get.theme.primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
      )),
    );
  }
}
