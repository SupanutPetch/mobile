import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class RegisterController extends GetxController {
  RxInt selectedRadio = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatpassTextController = TextEditingController();
  final calendarTextController = TextEditingController();

  void setSelectedRadio(int value) {
    selectedRadio.value = value;
  }

  void pickDate() async {
    DateTime? selectedDate = await showRoundedDatePicker(
      context: Get.overlayContext!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      borderRadius: 16,
      theme: ThemeData.dark(),
      styleDatePicker: MaterialRoundedDatePickerStyle(),
      barrierDismissible: false,
    );
  }
}
