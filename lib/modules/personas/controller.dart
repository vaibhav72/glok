import 'package:get/get.dart';

class PersonaController extends GetxController {
  static PersonaController get to => Get.find<PersonaController>();
  Rxn<bool> glockerMode = Rxn(false);

  @override
  void onInit() {}
}
