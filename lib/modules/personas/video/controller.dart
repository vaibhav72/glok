import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/utils/meta_strings.dart';

import 'package:permission_handler/permission_handler.dart';

class VideoCallController extends GetxController {
  String channel;
  String token;
  VideoCallController({required this.channel, required this.token});
  late RtcEngine engine;
  Rxn<int> remoteUid = Rxn<int>(null);

  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    await engine.leaveChannel();
    await engine.release();
  }

  void initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: MetaStrings.agoraAppid,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
  }

  registerHandlers() {
    engine.registerEventHandler(
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
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.startPreview();

    await engine.joinChannel(
      token: token,
      channelId: channel,
      uid: PersonaController.to.glockerMode.value! ? 1 : 0,
      options: const ChannelMediaOptions(),
    );
  }
}
