import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_strings.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../../../data/repositories/glocker_repository.dart';
import '../../../wallet/controller.dart';
import '../../end_user/apply_glocker/view.dart';
import '../../end_user/glocker_list_controller.dart';

class GlockerVideoCallController extends GetxController {
  String channel;
  String token;
  int userId;
  GlockerVideoCallController(
      {required this.channel, required this.token, required this.userId});
  RtcEngine? engine;
  Rxn<int> remoteUid = Rxn<int>(null);
  Rxn<bool> loading = Rxn<bool>(false);
  Rxn<bool> isMuted = Rxn<bool>(false);
  Rxn<bool> swapCamera = Rxn<bool>(false);
  GlockerRepository glockerRepository = GlockerRepository();
  TextEditingController commentController = TextEditingController();
  Rxn<int> callRating = Rxn<int>(0);
  Rxn<int> userRating = Rxn<int>(0);
  Rxn<bool> isLoading = Rxn<bool>(false);
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
    if (engine != null) {
      await engine?.leaveChannel();
      await engine?.release();
      engine = null;
    }
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
          // endCall();
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
    await engine?.enableAudio();
    await engine?.startPreview();
    log("$channel $token $userId");
    await engine?.joinChannel(
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
    isMuted.value = !isMuted.value!;
    engine?.muteLocalAudioStream(isMuted.value!);
  }

  void acceptCallTrack() async {
    try {
      await glockerRepository.startCallTrack(userId);
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void endCall() async {
    try {
      await glockerRepository.endCallTrack();
      _dispose();
      WalletController.to.getTransactions();
      PersonaController.to.getGlockerStats();
      await Get.bottomSheet(_RatingWidget());
      Get.back(closeOverlays: true);
      Get.back();
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  submitRating() async {
    try {
      isLoading.value = true;
      await glockerRepository.updateGlockerRating(
        userRating: userRating.value!,
        comment: commentController.text,
        callRate: callRating.value!,
        fanUserId: userId,
      );
      isLoading.value = false;
      Get.back();
      // showSnackBar(message: "Rating Submitted", isError: false);
    } catch (e) {
      isLoading.value = false;
      showSnackBar(message: e.toString());
    }
  }
}

class _RatingWidget extends GetView<GlockerVideoCallController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Form(
        // key: controller.bankDetailsFormKey,
        child: Container(
          height: 500,
          child: Obx(
            () => controller.isLoading.value!
                ? Center(child: Loader())
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  height: 6,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Get.theme.dividerColor,
                                      borderRadius: BorderRadius.circular(40)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.all(16.0).copyWith(bottom: 24),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Rate your Call",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                Divider(),
                                SizedBox(
                                  height: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        "Rate User",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Obx(() => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: List.generate(
                                              5,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        controller.userRating
                                                            .value = index + 1;
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SvgPicture.asset(
                                                          controller.userRating
                                                                      .value! >
                                                                  index
                                                              ? MetaAssets
                                                                  .starFilled
                                                              : MetaAssets
                                                                  .starUnfilled,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        "Rate Quality of your call",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Obx(() => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: List.generate(
                                              5,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        controller.callRating
                                                            .value = index + 1;
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SvgPicture.asset(
                                                          controller.callRating
                                                                      .value! >
                                                                  index
                                                              ? MetaAssets
                                                                  .starFilled
                                                              : MetaAssets
                                                                  .starUnfilled,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        "Comment",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: controller.commentController,
                                      validator: (value) {},
                                      maxLines: 3,
                                      decoration: formDecoration(
                                          "Comment", "Enter comment"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Get.theme.primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(80)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Not Now",
                                                  style: TextStyle(
                                                      color: Get
                                                          .theme.primaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          controller.submitRating();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Get.theme.primaryColor,
                                                border: Border.all(
                                                    color:
                                                        Get.theme.primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(80)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
