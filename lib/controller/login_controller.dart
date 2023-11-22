import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool obscure = true.obs;
  final passwordTextController = TextEditingController();
  showPassword() {
    obscure.value = !obscure.value;
    update();
  }
}
