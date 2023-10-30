import 'dart:developer';

import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:glok/data/repositories/glocker_repository.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_strings.dart';

import 'package:permission_handler/permission_handler.dart';

class UserVideoCallController extends GetxController {
  String channel;
  String token;
  int? userId;
  UserVideoCallController(
      {required this.channel, required this.token, this.userId = 0});
  RtcEngine? engine;
  Rxn<int> remoteUid = Rxn<int>(null);
  Rxn<bool> loading = Rxn<bool>(false);
  Rxn<bool> isMuted = Rxn<bool>(false);
  Rxn<bool> swapCamera = Rxn<bool>(false);
  GlockerRepository glockerRepository = GlockerRepository();
  @override
  void onClose() {
    super.onClose();

    _dispose();
  }

  @override
  void onInit() {
    super.onInit();
    initAgora();
  }

  Future<void> _dispose() async {
    await engine?.leaveChannel();
    await engine?.release();
  }

  void initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    loading.value = true;
    //create the engine
    engine = createAgoraRtcEngine();
    await engine?.initialize(const RtcEngineContext(
      appId: MetaStrings.agoraAppid,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    await registerHandlers();
    await joinChannel();
    loading.value = false;
  }

  registerHandlers() {
    engine?.registerEventHandler(
      RtcEngineEventHandler(
        onError: (err, msg) {
          showSnackBar(message: "$err $msg");
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("joined local");
        },
        onUserJoined: (RtcConnection connection, int remoteId, int elapsed) {
          remoteUid.value = remoteId;
          showSnackBar(message: "User Joined", isError: false);
        },
        onUserOffline: (RtcConnection connection, int remoteId,
            UserOfflineReasonType reason) {
          remoteUid.value = null;
          // endCall();
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
    await engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine!.setupLocalVideo(VideoCanvas(uid: 0));
    await engine?.enableAudio();
    await engine?.enableVideo();
    await engine?.startPreview();

    try {
      await engine?.joinChannel(
        token: token,
        channelId: channel,
        uid: 0,
        options: const ChannelMediaOptions(),
      );
    } catch (e) {
      log("error $e");
    }
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
}
