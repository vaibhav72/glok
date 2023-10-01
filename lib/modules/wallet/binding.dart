import 'package:get/get.dart';
import 'package:glok/modules/wallet/controller.dart';

class WalletBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(WalletController());
  }
}