import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailsController extends GetxController {
  static UserDetailsController get to => Get.find<UserDetailsController>();
  final AuthController authController = AuthController.to;
  Rxn<XFile?> image = Rxn<XFile?>();
  ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  Rxn<String> gender = Rxn("male");
  Rxn<bool> agreement = Rxn(false);

  @override
  void onInit() {}

  pickImage() async {
    ImageSource? source = await showImageSourceSelector();
    if (source == null) return;
    image.value = await picker.pickImage(source: source);
  }

  register() {
    if (!formKey.currentState!.validate())
      return;
    else {
      authController.phoneNumber.value = numberController.text;
      authController.handleRegister({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "gender": gender.value,
        "mobile_number": numberController.text.trim(),
      }, image.value!);
    }
  }
}
