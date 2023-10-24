import 'dart:developer';

import 'package:get/get.dart';
import 'package:glok/data/models/agora_data_model.dart';
import 'package:glok/data/models/bidlist_model.dart';
import 'package:glok/data/repositories/user_repository.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/personas/celebrity/bid/view.dart';
import 'package:glok/modules/personas/video/binding.dart';
import 'package:glok/modules/personas/video/view.dart';
import 'package:glok/utils/helpers.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'celebrity/bid/binding.dart';

class PersonaController extends GetxController {
  static PersonaController get to => Get.find<PersonaController>();
  UserRepository userRepository = UserRepository();
  IO.Socket? socket;
  Rxn<List<BidListModel>> bidList = Rxn([]);
  Rxn<AgoraResponseModel> agoraResponse = Rxn();

  init() async {
    socket = await userRepository.getSocket();
    socket!.connect();
    socket!.onConnect((data) {
      log("Connected");
      showSnackBar(message: "connected", isError: false);
    });
    socket!.onDisconnect((_) {
      log("disconnected");
      showSnackBar(message: "disconnected", isError: true);
    });
    socket!.on('agora_token', (data) {
      agoraResponse.value = AgoraResponseModel.fromJson(data);
      Get.to(VideoControllerView(),
          binding: VideoCallBinding(
            channel: agoraResponse.value!.channelName!,
            token: agoraResponse.value!.token!,
          ));
    });
    socket!.on('bid_list', (data) {
      bidList.value = bidListModelFromJson(data);
      Get.to(() => GlockerBiddingView(), binding: GlockerBiddingBinding());
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
    glockerMode.value = value;
    if (online.value!) await userRepository.updateGlockerMode(value);
  }

  Rxn<bool> online = Rxn<bool>(false);
  changeStatus() async {
    online.value = !online.value!;
    await disconnect();

    if (online.value!) {
      await init();
      joinStream(AuthController.to.glocker.value!.id!);
    } else {}
    // await userRepository.updateGlockerMode(online.value!);
  }

  joinStream(int glockerId) {
    socket!.emit('join_stream', glockerId);
  }
}
