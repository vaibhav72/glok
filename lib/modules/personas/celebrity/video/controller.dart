import 'dart:developer';

import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/utils/meta_strings.dart';

import 'package:permission_handler/permission_handler.dart';

class GlockerVideoCallController extends GetxController {
  String channel;
  String token;
  GlockerVideoCallController({required this.channel, required this.token});
  late RtcEngine engine;
  Rxn<int> remoteUid = Rxn<int>(null);
  Rxn<bool> loading = Rxn<bool>(false);
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
    joinChannel();
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
        },
        onUserOffline: (RtcConnection connection, int remoteId,
            UserOfflineReasonType reason) {
          remoteUid.value = null;
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
    await engine.startPreview();

    await engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 3,
      options: const ChannelMediaOptions(),
    );
  }
}
