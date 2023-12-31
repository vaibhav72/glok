import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/controllers/bottom_navigation_controller.dart';
import 'package:glok/data/models/user_model.dart';
import 'package:glok/data/repositories/glocker_repository.dart';
import 'package:glok/data/repositories/user_repository.dart';
import 'package:glok/modules/personas/end_user/glocker_list_controller.dart';
import 'package:glok/modules/personas/end_user/home/binding.dart';
import 'package:glok/modules/wallet/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../controllers/hive_controller.dart';
import '../../data/models/glocker_model.dart';
import '../../data/models/wallet_model.dart';
import '../../data/repositories/auth_repository.dart';

class AuthController extends GetxController with CodeAutoFill {
  Rxn<bool> authLoading = Rxn<bool>(false);
  Rxn<bool> resendOTp = Rxn<bool>(true);
  Rxn<bool> loading = Rxn<bool>(false);
  static AuthController get to => Get.find<AuthController>();
  AuthRepository authRepository = AuthRepository();
  UserRepository userRepository = UserRepository();
  GlockerRepository glockerRepository = GlockerRepository();
  final hiveController = HiveController.to;
  final formKey = GlobalKey<FormState>();
  Rxn<UserModel> user = Rxn<UserModel>();
  Rxn<WalletModel> wallet = Rxn<WalletModel>();
  Rxn<GlockerModel> glocker = Rxn<GlockerModel>();
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  PageController pageController = PageController();
  Rxn<bool> showWalkthrough = Rxn<bool>(false);
  Rxn<String> phoneNumber = Rxn<String>();
  Rxn<Duration> timeLeft = Rxn<Duration>(Duration(seconds: 30));
  Rxn<bool> get walkthroughDone =>
      Rxn((getWalkthroughStatus() ?? false) || showWalkthrough.value!);
  Rxn<bool> get isLoggedIn => Rxn((getToken() != null));
  getWalkthroughStatus() {
    return hiveController.readData('walkthrough');
  }

  startTimer() {
    timeLeft.value = Duration(seconds: 30);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value!.inSeconds == 0) {
        resendOTp.value = true;
        timer.cancel();
      } else {
        timeLeft.value = Duration(seconds: timeLeft.value!.inSeconds - 1);
      }
    });
  }

  getToken() {
    return hiveController.readData('token');
  }

  setWalkthroughStatus(bool value) async {
    showWalkthrough.value = value;
    await hiveController.writeData('walkthrough', value);
  }

  handleLogout() async {
    loading.value = true;
    BottomNavigationController.to.changePage(0);
    hiveController.logoutData();
    otpController.text = "";
    numberController.text = "";
    user.value = null;
    wallet.value = null;
    glocker.value = null;
    loading.value = false;
  }

  handleLoginOTP() async {
    if (formKey.currentState!.validate()) {
      try {
        authLoading.value = true;
        phoneNumber.value = numberController.text;
        bool response = await authRepository.login(numberController.text);
        if (response) {
          pageController.animateToPage(1,
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        } else {
          showSnackBar(message: "Something went wrong");
        }
        authLoading.value = false;
      } catch (e) {
        if (e == 400) {
          pageController.jumpToPage(
            2,
          );
        } else {
          showSnackBar(message: e.toString());
        }
        authLoading.value = false;
      }
    }
  }

  resendOTP() async {
    try {
      authLoading.value = true;
      phoneNumber.value = numberController.text;
      bool response = await authRepository.login(numberController.text);
      if (response) {
        pageController.animateToPage(1,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        showSnackBar(message: "Something went wrong");
      }
      authLoading.value = false;
    } catch (e) {
      if (e == 400) {
        pageController.animateToPage(2,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        showSnackBar(message: e.toString());
      }
      authLoading.value = false;
    }
  }

  handleRegister(Map<String, String> params, XFile file) async {
    try {
      authLoading.value = true;
      bool response = await authRepository.registerUser(params, file);
      if (response) {
        pageController.animateToPage(1,
            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        showSnackBar(message: "Something went wrong");
      }
      authLoading.value = false;
    } catch (e) {
      showSnackBar(message: e.toString());
      authLoading.value = false;
    }
  }

  handleVerifyOTP() async {
    if (otpController.text.length == 5) {
      try {
        authLoading.value = true;
        UserModel response = await authRepository.verifyOtp(
            phoneNumber.value!, otpController.text);

        await getUserDetails();
        authLoading.value = false;
      } catch (e) {
        authLoading.value = false;
        showSnackBar(message: e.toString());
      }
    }
  }

  getUserDetails() async {
    try {
      loading.value = true;
      UserModel response = await userRepository.getUserDetails();

      await getWalletDetails();
      await getGlockerDetails();
      GlockerListController.to.initData();
      WalletController.to.getTransactions();
      user.value = response;
      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (e == 401) {
        handleLogout();
      } else {
        showSnackBar(message: e.toString());
      }
    }
  }

  getGlockerDetails() async {
    try {
      // loading.value = true;
      GlockerModel response = await glockerRepository.getGlockerDetails();
      glocker.value = response;
      // loading.value = false;
    } catch (e) {
      // loading.value = false;
      showSnackBar(message: e.toString());
    }
  }

  getWalletDetails() async {
    try {
      WalletModel walletResponse = await userRepository.getMyWallet();
      wallet.value = walletResponse;
    } catch (e) {
      // showSnackBar(message: e.toString());
    }
  }

  @override
  void dispose() {
    numberController.dispose();
    otpController.dispose();
    pageController.dispose();
    cancel();
    unregisterListener();
    super.dispose();
  }

  @override
  void codeUpdated() {
    otpController.text = code!;
  }

  @override
  void onInit() {
    super.onInit();
    listenForCode();
    if (isLoggedIn.value!) {
      getUserDetails();
    }
  }

  void handleResendOTP() {
    resendOTp.value = false;
    startTimer();
    resendOTP();
  }
}
