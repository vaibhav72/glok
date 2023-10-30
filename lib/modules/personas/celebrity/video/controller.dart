import 'dart:developer';

import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_strings.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../../../data/repositories/glocker_repository.dart';

class GlockerVideoCallController extends GetxController {
  String channel;
  String token;
  int userId;
  GlockerVideoCallController(
      {required this.channel, required this.token, required this.userId});
  late RtcEngine engine;
  Rxn<int> remoteUid = Rxn<int>(null);
  Rxn<bool> loading = Rxn<bool>(false);
  Rxn<bool> isMuted = Rxn<bool>(false);
  Rxn<bool> swapCamera = Rxn<bool>(false);
  GlockerRepository glockerRepository = GlockerRepository();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initAgora();
  }

  @override
  void onClose() {
    super.onClose();

    _dispose();
  }

  Future<void> _dispose() async {
    await engine.leaveChannel();
    await engine.release();
  }

  void initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    loading.value = true;
    //create the engine
    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: MetaStrings.agoraAppid,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    await registerHandlers();
    await joinChannel();
    loading.value = false;
  }

  registerHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("joined local");
        },
        onError: (err, msg) {
          log("error $err $msg");
        },
        onUserJoined: (RtcConnection connection, int remoteId, int elapsed) {
          remoteUid.value = remoteId;
          acceptCallTrack();
        },
        onUserOffline: (RtcConnection connection, int remoteId,
            UserOfflineReasonType reason) {
          remoteUid.value = null;
          endCall();
        },
        onLeaveChannel: (connection, stats) {
          endCall();
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          // _engine.renewToken(token);
        },
      ),
    );
  }

  joinChannel() async {
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.enableAudio();
    await engine.startPreview();
    log("$channel $token $userId");
    await engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
          clientRoleType: ClientRoleType.clientRoleBroadcaster),
    );
  }

  void switchCamera() {
    engine?.switchCamera();
    swapCamera.value = !swapCamera.value!;
  }

  void muteAudio() {
    engine?.muteLocalAudioStream(isMuted.value!);
    isMuted.value = !isMuted.value!;
  }

  void endCall() async {
    try {
      await glockerRepository.endCallTrack();
      Get.back();
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void acceptCallTrack() async {
    try {
      await glockerRepository.startCallTrack(userId);
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }
}
