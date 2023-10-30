import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/modules/personas/end_user/apply_glocker/view.dart';
import 'package:glok/modules/wallet/add_fund_view.dart';
import 'package:glok/modules/wallet/controller.dart';
import 'package:glok/modules/wallet/withdraw_fund_view.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/models/transaction_model.dart';

class WalletView extends GetView<WalletController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getTransactions();
        },
        child: Obx(
          () => Column(children: [
            Padding(
              padding: MediaQuery.of(context).padding,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Available Balance",
                        style: TextStyle(color: Colors.white),
                      ),
                      RichText(
                        text: TextSpan(
                            text: "₹",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                  text: NumberFormat.currency(
                                    locale: "en_IN",
                                    symbol: "",
                                  ).format(controller.balance),
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w600))
                            ]),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!PersonaController.to.glockerMode.value!) ...[
                              _FundActionButton(
                                action: "Add Fund",
                                handler: () {
                                  Get.to(AddFundView());
                                },
                              ),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                            _FundActionButton(
                              action: "Withdraw",
                              handler: () {
                                if (controller.balance < 100) {
                                  showSnackBar(
                                    message:
                                        "You need to have atleast ₹100 in your wallet to withdraw",
                                    title: "Insufficient Balance",
                                  );
                                  return;
                                }
                                Get.to(WithdrawFundView());
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                width: double.maxFinite,
                child: controller.isLoading.value!
                    ? Center(
                        child: Loader(),
                      )
                    : SingleChildScrollView(
                        controller: controller.scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  height: 6,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Get.theme.dividerColor,
                                      borderRadius: BorderRadius.circular(40)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0)
                                  .copyWith(bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "All Activity",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Get.theme.colorScheme.secondary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: controller.transactions.value!
                                  .map((e) => e.type == "add"
                                      ? CreditTile(
                                          transaction: e,
                                        )
                                      : DebitTile(
                                          transaction: e,
                                        ))
                                  .toList(),
                            ),
                            if (controller.isFetchingNext.value! &&
                                controller.transactions.value!.length == 0)
                              Loader(),
                          ],
                        ),
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _FundActionButton extends StatelessWidget {
  _FundActionButton({super.key, required this.action, required this.handler});
  String action;
  void Function()? handler;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handler,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.25),
            borderRadius: BorderRadius.circular(40)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            "$action",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CreditTile extends StatelessWidget {
  CreditTile({
    super.key,
    required this.transaction,
  });
  TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: MetaColors.secondaryPurple,
                  child: SvgPicture.asset(MetaAssets.transactionReceived),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${transaction.description}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              "+ " +
                                  NumberFormat.currency(
                                    locale: "en_IN",
                                    symbol: "",
                                  ).format(double.parse(transaction.amount!)),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: MetaColors.transactionSuccess,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                DateFormat('MMM dd,yyyy hh:mm a')
                                    .format(transaction.createdAt!),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: MetaColors.subTextColor),
                              ),
                            ),
                            Text(
                              DateFormat('hh:mm a')
                                  .format(transaction.createdAt!),
                              style: TextStyle(
                                  fontSize: 12, color: MetaColors.subTextColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}

class DebitTile extends StatelessWidget {
  DebitTile({super.key, required this.transaction});
  TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: MetaColors.secondaryPurple,
                  child: SvgPicture.asset(MetaAssets.transactionSent),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${transaction.description}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              "- " +
                                  NumberFormat.currency(
                                    locale: "en_IN",
                                    symbol: "",
                                  ).format(double.parse(transaction.amount!)),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: MetaColors.transactionFailed,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                DateFormat('MMM dd,yyyy hh:mm a')
                                    .format(transaction.createdAt!),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: MetaColors.subTextColor),
                              ),
                            ),
                            Text(
                              DateFormat('hh:mm a')
                                  .format(transaction.createdAt!),
                              style: TextStyle(
                                  fontSize: 12, color: MetaColors.subTextColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
