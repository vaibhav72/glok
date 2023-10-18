import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:glok/modules/personas/celebrity/home/view.dart';
import 'package:glok/modules/personas/controller.dart';
import 'package:glok/modules/personas/end_user/home/view.dart';

class PersonaView extends GetView<PersonaController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        controller.glockerMode.value! ? GlockerHomeView() : EndUserHomeView());
  }
}
