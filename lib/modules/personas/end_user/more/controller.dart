import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/user_model.dart';
import 'package:glok/data/repositories/bank_repository.dart';
import 'package:glok/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/repositories/user_repository.dart';
import '../../../auth_module/controller.dart';

class EndUserMoreController extends GetxController {
  Rxn<UserModel> get user => AuthController.to.user;
  UserRepository userRepository = UserRepository();
  Rxn<bool> showAccountNumber = Rxn(false);

  /// User Profile
  ///
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Rxn<XFile?> profileImage = Rxn();
  final profileFormKey = GlobalKey<FormState>();
  Rxn<String> gender = Rxn();
  ImagePicker picker = ImagePicker();
  bool get isChanged {
    return isDataChanged || profileImage.value != null;
  }

  bool get isDataChanged =>
      nameController.text != user()!.name ||
      emailController.text != user()!.email! ||
      phoneController.text != user()!.mobileNumber! ||
      gender.value != user()!.gender!;

  bool get isBankDataChanged =>
      accountHolderNameController.text != user()!.accountHolderName ||
      accountNumberController.text != user()!.accountNumber ||
      ifscController.text != user()!.ifscCode;

  //bank
  BankRepository bankRepository = BankRepository();
  final bankDetailsFormKey = GlobalKey<FormState>();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController reenterAccountNumberController =
      TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  Rxn<bool> isLoading = Rxn(false);

  initProfileDetails() {
    nameController.text = user()!.name!;
    emailController.text = user()!.email!;
    phoneController.text = user()!.mobileNumber!;
    gender.value = user()!.gender!;
  }

  initBankDetails() {
    accountNumberController.text = user()!.accountNumber ?? '';
    reenterAccountNumberController.text = user()!.accountNumber ?? '';
    ifscController.text = user()!.ifscCode ?? '';
    accountHolderNameController.text = user()!.accountHolderName ?? '';
  }

  updateProfileData() async {
    try {
      if (!isChanged) {
        return;
      }
      if (profileFormKey.currentState!.validate()) {
        isLoading.value = true;
        if (isDataChanged)
          await userRepository.updateUserDetails(user.value!.copyWith(
            name: nameController.text,
            email: emailController.text,
            gender: gender.value,
            mobileNumber: phoneController.text,
          ));
        if (profileImage.value != null) {
          await userRepository.updateUserPhoto(profileImage.value!);
          isLoading.value = false;
          profileImage.value = null;
        }
        await AuthController.to.getUserDetails();
        isLoading.value = false;
        showSnackBar(message: "User Details updated", isError: false);
        return;
      }
    } catch (e) {
      isLoading.value = false;
      showSnackBar(message: "$e");
    }
  }

  pickProfileImage() async {
    try {
      ImageSource? source = await showImageSourceSelector();
      if (source != null) {
        profileImage.value = await picker.pickImage(source: source);
        update();
      }
    } catch (e) {
      showSnackBar(message: "$e");
    }
  }

  addBankDetais() async {
    try {
      if (bankDetailsFormKey.currentState!.validate()) {
        isLoading.value = true;
        await bankRepository.addBank({
          "account_number": accountNumberController.text,
          "reenter_account_number": accountNumberController.text,
          "ifsc_code": ifscController.text,
          "account_holder_name": accountHolderNameController.text
        });
        await AuthController.to.getUserDetails();
        isLoading.value = false;
        Get.back();
        showSnackBar(
            message: "Bank details added successfully", isError: false);
      }
      return;
    } catch (e) {
      isLoading.value = false;
      showSnackBar(message: "$e");
    }
  }
}
