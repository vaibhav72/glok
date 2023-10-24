import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/agora_data_model.dart';
import 'package:glok/data/models/bidlist_model.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/glocker_repository.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/modules/personas/end_user/apply_glocker/view.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/utils/helpers.dart';

class UserBiddingController extends GetxController {
  static UserBiddingController get to => Get.find<UserBiddingController>();
  Rxn<GlockerModel> get glocker => GlockerListController.to.selectedGlocker;
  Rxn<List<BidListModel>> get bidList => PersonaController.to.bidList;
  Rxn<bool> showQueue = Rxn(false);
  TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  GlockerRepository glockerRepository = GlockerRepository();
  PersonaController get personaController => PersonaController.to;
  Rxn<bool> loading = Rxn(false);

  showPrice() {
    Get.dialog(Center(
      child: Material(
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: loading.value!
                ? Center(
                    child: Loader(),
                  )
                : Center(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Enter per-minute calling rate",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a price";
                                }
                                if (double.parse(value) <
                                    (glocker.value?.price ?? 499).toDouble()) {
                                  return "Price should be greater than ${(glocker.value?.price ?? 499)}";
                                }
                                return null;
                              },
                              decoration: formDecoration(
                                  "", "\u20b9 ${glocker.value?.price ?? '0'}"),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Highest: \u20b9 1500/min",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Default: \u20b9 ${glocker.value?.price ?? '0'}/min",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                                title: "Submit",
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    return;
                                  }
                                  loading.value = true;
                                  try {
                                    await glockerRepository.createBid(
                                        int.parse(priceController.text.trim()),
                                        glocker.value!.id!);
                                    loading.value = false;
                                    Get.back();
                                  } catch (e) {
                                    loading.value = false;
                                    Get.back();
                                    showSnackBar(message: e.toString());
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    ));
  }
}
