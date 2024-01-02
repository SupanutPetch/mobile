import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class RegisterController extends GetxController {
  RxInt selectedRadio = 0.obs;
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatpassTextController = TextEditingController();
  final calendarTextController = TextEditingController();

  void setSelectedRadio(int value) {
    selectedRadio.value = value;
  }

  void selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate(picked);
    }
  }

  showCupertinoModalPopup(BuildContext context) {
    Get.defaultDialog(
      
      title: 'Cupertino Modal Popup',
      content: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newDate) {},
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('OK'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          // Handle cancel action
          Get.back(); // Close the modal
        },
        child: const Text('Cancel'),
      ),
    );
  }
}
