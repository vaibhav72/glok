import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';

class WalletController extends GetxController {
  static WalletController get to => Get.find<WalletController>();
  List<double> prefilledTransactions = [500, 1000, 1500, 200];
  TextEditingController addFundController = TextEditingController();
  TextEditingController withDrawFundController = TextEditingController();
  successDialog() {
    Get.dialog(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Material(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(MetaAssets.transactionSuccess),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Request submitted",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Your request for the fund withdrawal has been placed. We will be process it next 48 hours.",textAlign: TextAlign.center,
                    style:
                        TextStyle(color: MetaColors.primaryText.withOpacity(0.7)),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                      title: "Okay",
                      onPressed: () {
                        Get.back();
                      })
                ],
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      ),
    ));
  }
}
