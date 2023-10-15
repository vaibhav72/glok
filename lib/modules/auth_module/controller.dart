import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/user_model.dart';
import 'package:glok/data/repositories/user_repository.dart';
import 'package:glok/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../controllers/hive_controller.dart';
import '../../data/models/wallet_model.dart';
import '../../data/repositories/auth_repository.dart';

class AuthController extends GetxController with CodeAutoFill {
  Rxn<bool> authLoading = Rxn<bool>(false);
  Rxn<bool> loading = Rxn<bool>(false);
  static AuthController get to => Get.find<AuthController>();
  AuthRepository authRepository = AuthRepository();
  UserRepository userRepository = UserRepository();
  final hiveController = HiveController.to;
  final formKey = GlobalKey<FormState>();
  Rxn<UserModel> user = Rxn<UserModel>();
  Rxn<WalletModel> wallet = Rxn<WalletModel>();
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  PageController pageController = PageController();
  Rxn<bool> showWalkthrough = Rxn<bool>(false);
  Rxn<String> phoneNumber = Rxn<String>();
  Rxn<bool> get walkthroughDone =>
      Rxn((getWalkthroughStatus() ?? false) || showWalkthrough.value!);
  Rxn<bool> get isLoggedIn => Rxn((getToken() != null));
  getWalkthroughStatus() {
    return hiveController.readData('walkthrough');
  }

  getToken() {
    return hiveController.readData('token');
  }

  setWalkthroughStatus(bool value) async {
    showWalkthrough.value = value;
    await hiveController.writeData('walkthrough', value);
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
          pageController.animateToPage(2,
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        } else {
          showSnackBar(message: e.toString());
        }
        authLoading.value = false;
      }
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
        getUserDetails();
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
      user.value = response;
      WalletModel walletResponse = await userRepository.getMyWallet();
      wallet.value = walletResponse;
      loading.value = false;
    } catch (e) {
      loading.value = false;
      showSnackBar(message: e.toString());
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
    if (isLoggedIn.value!) getUserDetails();
  }
}
