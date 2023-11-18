import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/data/repositories/bank_repository.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';

import '../../data/models/transaction_model.dart';

class WalletController extends GetxController {
  static WalletController get to => Get.find<WalletController>();
  ScrollController scrollController = ScrollController();
  List<double> prefilledTransactions = [500, 1000, 1500, 2000];
  AuthController authController = AuthController.to;
  TextEditingController addFundController = TextEditingController();
  TextEditingController withDrawFundController = TextEditingController();
  BankRepository bankRepository = BankRepository();
  final addFundFormKey = GlobalKey<FormState>();
  final withDrawFundFormKey = GlobalKey<FormState>();
  double get balance =>
      double.parse(AuthController.to.wallet.value?.balance ?? "0");
  Rxn<List<TransactionModel>> transactions = Rxn([]);
  Rxn<bool> isLoading = Rxn(false);
  Rxn<bool> isFetchingNext = Rxn(false);
  Rxn<bool> lastPage = Rxn(false);

  Rxn<int> page = Rxn(0);

  @override
  void onInit() {
    super.onInit();
    getTransactions();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 30) {
        if (!isFetchingNext.value!) getNextTransactions();
      }
    });
  }

  getTransactions() async {
    try {
      AuthController.to.getWalletDetails();
      page.value = 1;
      lastPage.value = false;
      isLoading.value = true;
      transactions.value = await bankRepository.getAlltransactions(page: 1);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  getNextTransactions() async {
    try {
      if (lastPage.value!) return;
      isFetchingNext.value = true;
      page.value = page.value! + 1;
      List<TransactionModel> newTransactions =
          await bankRepository.getAlltransactions(page: page.value!);
      if (newTransactions.isNotEmpty) {
        transactions.value!.addAll(newTransactions);
      } else {
        lastPage.value = true;
      }
      isFetchingNext.value = false;
    } catch (e) {
      isFetchingNext.value = false;
    }
  }

  addFund() async {
    try {
      if (!addFundFormKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      await bankRepository
          .addFunds(double.parse(addFundController.text.trim()));
      await authController.getWalletDetails();
      await getTransactions();
      isLoading.value = false;
      Get.back();
      showSnackBar(message: "Fund added successfully", isError: false);
      // successDialog();
    } catch (e) {
      isLoading.value = false;
      showSnackBar(message: e.toString());
    }
  }

  withDrawFunds() async {
    try {
      if (withDrawFundController.text.isEmpty) {
        return;
      }
      isLoading.value = true;
      await bankRepository
          .withdrawFunds(double.parse(withDrawFundController.text.trim()));
      await authController.getWalletDetails();
      await getTransactions();
      isLoading.value = false;
      Get.back();
      successDialog();
    } catch (e) {
      isLoading.value = false;
      showSnackBar(message: e.toString());
    }
  }

  successDialog() {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Material(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 42, vertical: 24),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Your request for the fund withdrawal has been placed. We will be process it next 48 hours.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: MetaColors.primaryText.withOpacity(0.7)),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
        ),
      ),
    ));
  }
}
