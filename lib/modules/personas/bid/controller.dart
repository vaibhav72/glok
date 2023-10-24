import 'package:get/get.dart';
import 'package:glok/data/models/agora_data_model.dart';
import 'package:glok/data/models/bidlist_model.dart';
import 'package:glok/data/models/glocker_model.dart';
import 'package:glok/data/repositories/glocker_repository.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/utils/helpers.dart';

class GlockerBiddingController extends GetxController {
  static GlockerBiddingController get to =>
      Get.find<GlockerBiddingController>();
  Rxn<GlockerModel> get glocker => AuthController.to.glocker;
  Rxn<List<BidListModel>> get bidList => PersonaController.to.bidList;
  Rxn<bool> showQueue = Rxn(false);

  GlockerRepository glockerRepository = GlockerRepository();

  acceptCall(BidListModel data) async {
    try {
      await glockerRepository.acceptCall(data.id!);
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }
}
