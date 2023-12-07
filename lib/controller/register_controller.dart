import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxInt selectedRadio = 0.obs;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatpassTextController = TextEditingController();
  final calendarTextController = TextEditingController();

  void setSelectedRadio(int value) {
    selectedRadio.value = value;
  }
}
