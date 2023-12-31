import 'dart:developer';

import 'package:get/get.dart';
import 'package:glok/data/models/agora_data_model.dart';
import 'package:glok/data/models/bidlist_model.dart';
import 'package:glok/data/models/stats_model.dart';
import 'package:glok/data/repositories/glocker_repository.dart';
import 'package:glok/data/repositories/user_repository.dart';
import 'package:glok/modules/auth_module/controller.dart';

import 'package:glok/utils/helpers.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../data/models/user_model.dart';
import 'celebrity/bid/binding.dart';
import 'celebrity/bid/view.dart';
import 'celebrity/video/binding.dart';
import 'celebrity/video/view.dart';
import 'end_user/video/binding.dart';
import 'end_user/video/view.dart';

class PersonaController extends GetxController {
  static PersonaController get to => Get.find<PersonaController>();
  UserRepository userRepository = UserRepository();
  GlockerRepository glockerRepository = GlockerRepository();
  Rxn<GlockerStatsModel> glockerStats = Rxn();
  IO.Socket? socket;
  Rxn<List<BidListModel>> bidList = Rxn([]);
  Rxn<AgoraResponseModel> agoraResponse = Rxn();
  UserModel get user => AuthController.to.user.value!;

  init() async {
    socket = await userRepository.getSocket();
    socket!.connect();
    socket!.onConnect((data) {
      log("Connected");
      showSnackBar(message: "connected", isError: false);
    });
    socket!.onAny((event, data) {
      log("onAny $event $data");
    });
    socket!.onDisconnect((_) {
      log("disconnected");
    });
    socket!.on('agora_token', (data) {
      agoraResponse.value = AgoraResponseModel.fromJson(data);
      if (glockerMode.value!) {
        Get.to(() => GlockerVideoView(),
            binding: GlockerVideoCallBinding(
              channel: agoraResponse.value!.channelName!,
              token: agoraResponse.value!.token!,
              userId: agoraResponse.value!.userId!,
            ));
      } else {
        if (agoraResponse.value!.userId == AuthController.to.user.value!.id) {
          Get.to(() => UserVideoView(),
              binding: UserVideoCallBinding(
                channel: agoraResponse.value!.channelName!,
                token: agoraResponse.value!.token!,
                userId: agoraResponse.value!.userId!,
              ));
        } else {
          bidList.value = [];
          Get.back();
          Get.back();
          showSnackBar(message: "Sorry Your bid was not accepted");
        }
      }
    });
    socket!.on('rejected', (data) {
      if (!glockerMode.value! && data == AuthController.to.user.value!.id) {
        bidList.value = [];
        Get.back();
        Get.back();
        showSnackBar(message: "Sorry Your bid was not accepted");
      }
    });
    socket!.on('rejected_all', (data) {
      if (!glockerMode.value!) {
        bidList.value = [];
        Get.back();
        Get.back();
        showSnackBar(message: data.toString());
      }
    });
    socket!.on('bid_list', (data) {
      if (glockerMode.value! &&
          online.value! &&
          (data as List)
              .map((e) => BidListModel.fromJson(e))
              .toList()
              .isEmpty &&
          (bidList.value?.isNotEmpty ?? false)) {
        bidList.value = [];
        Get.back();
        return;
      }
      if (!glockerMode.value! &&
          ((data as List)
                  .map((e) => BidListModel.fromJson(e))
                  .toList()
                  .isEmpty &&
              ((bidList.value?.isNotEmpty ?? false)))) {
        bidList.value = [];
        Get.back();
        Get.back();
        return;
      }

      bidList.value =
          (data as List).map((e) => BidListModel.fromJson(e)).toList();
      if (glockerMode.value! && online.value! && bidList.value!.isNotEmpty) {
        Get.to(() => GlockerBiddingView(), binding: GlockerBiddingBinding());
      } else {
        if ((bidList.value?.isNotEmpty ?? false) &&
            bidList.value?.firstWhereOrNull(
                    (element) => element.userId == user.id) ==
                null) {
          bidList.value = [];
          Get.back();
        }
        // Get.to(() => UserBiddingView(), binding: UserBiddingBinding());
      }
    });
  }

  disconnect() async {
    if (socket != null) {
      socket?.io.disconnect();
      socket?.clearListeners();
      socket?.close();
      socket = null;
    }
  }

  Rxn<bool> glockerMode = Rxn(false);
  updateGlockerMode(bool value) async {
    try {
      await userRepository.updateGlockerMode(value);
      bidList.value = [];
      await getGlockerStats();
      glockerMode.value = value;
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  getGlockerStats() async {
    try {
      glockerStats.value = await glockerRepository.getStats();
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  glockerLogout() async {
    disconnect();
    // changeStatus();
    await updateGlockerMode(false);
    AuthController.to.handleLogout();
  }

  Rxn<bool> online = Rxn<bool>(false);
  changeStatus() async {
    try {
      online.value = !online.value!;
      online.value = await glockerRepository.updateonline();
    } catch (e) {
      showSnackBar(message: e.toString());
    }
    await disconnect();

    if (online.value!) {
      await init();
      joinStream(AuthController.to.glocker.value!.id!);
    } else {}
    // await userRepository.updateGlockerMode(online.value!);
  }

  joinStream(int glockerId) {
    socket!.emit('join_stream', glockerId.toString());
  }
}
