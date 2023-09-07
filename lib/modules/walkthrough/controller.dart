import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/utils/meta_assets.dart';

class WalkthroughController extends GetxController {
  static WalkthroughController get to => Get.find<WalkthroughController>();
  final AuthController authController = AuthController.to;
  PageController pageController=PageController();
  nextPage()
  {
    pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  skip(){
    authController.setWalkthroughStatus(true);
 
  }

  List<_WalkThroughObject> pages = [
    _WalkThroughObject(
        title: "Welcome to Glockers",
        description:
            "The ultimate app that brings you closer to your favorite celebrities. Book personalized video calls and connect with them like never before.",
        image: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(MetaAssets.splashOverlay),
            Image.asset(MetaAssets.logoPurple)
          ],
        )),
    _WalkThroughObject(
        title: "Your Favorite Celebrity",
        description:
            "Discover a wide range of celebrity categories such as Music, Film & TV, Sports, Comedy, Influencers, and more. Find the perfect celebrity to book your video call.",
        image: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(MetaAssets.splashOverlay),
            Image.asset(MetaAssets.logoPurple)
          ],
        )),
    _WalkThroughObject(
        title: "Book a Video Call",
        description:
            "Choose a convenient date and time from the celebrity's availability. Confirm your booking and get ready for an exclusive one-on-one video call experience.",
        image: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(MetaAssets.splashOverlay),
            Image.asset(MetaAssets.logoPurple)
          ],
        )),
    _WalkThroughObject(
        title: "Cherish the Moment",
        description:
            "Capture the magic of your video call by opting to receive a recording. Rate the celebrity and leave a review to share your experience with others.",
        image: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(MetaAssets.splashOverlay),
            Image.asset(MetaAssets.logoPurple)
          ],
        ))
  ];
}

class _WalkThroughObject {
  String title;
  String description;
  Widget image;
  Function? onPressed;

  _WalkThroughObject(
      {required this.title,
      required this.description,
      required this.image,
      this.onPressed});
}
