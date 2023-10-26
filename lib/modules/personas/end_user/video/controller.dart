import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/utils/meta_strings.dart';

import 'package:permission_handler/permission_handler.dart';

class UserVideoCallController extends GetxController {
  String channel;
  String token;
  UserVideoCallController({required this.channel, required this.token});
  RtcEngine? engine;
  Rxn<int> remoteUid = Rxn<int>(null);
  Rxn<bool> loading = Rxn<bool>(false);
  @override
  void onClose() {
    super.onClose();

    _dispose();
  }

  @override
  void onInit() {
    super.onInit();
    initAgora();
    registerHandlers();
    joinChannel();
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
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {},
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
    await engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine?.enableVideo();
    await engine?.startPreview();

    await engine?.joinChannel(
      token: token,
      channelId: channel,
      uid: PersonaController.to.glockerMode.value! ? 1 : 0,
      options: const ChannelMediaOptions(),
    );
  }
}
