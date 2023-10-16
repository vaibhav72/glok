import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/end_user/apply_glocker/view.dart';
import 'package:glok/modules/wallet/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';

class AddFundView extends GetView<WalletController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(MetaAssets.transactionHelp),
          )
        ],
        title: Text(
          "Add Money",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value!
            ? Center(
                child: Loader(),
              )
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: controller.addFundFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: Get.width * .8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add funds to your wallet for seamless calls and transactions.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        TextFormField(
                          controller: controller.addFundController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter amount";
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: formDecoration("", "Enter amount"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.prefilledTransactions
                                .map((e) => InkWell(
                                      onTap: () {
                                        controller.addFundController.text =
                                            e.toString();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          width: 76,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: MetaColors.secondaryPurple
                                                .withOpacity(0.2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "\u20b9 $e",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            title: "Proceed",
                            onPressed: () {
                              controller.addFund();
                            })
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
