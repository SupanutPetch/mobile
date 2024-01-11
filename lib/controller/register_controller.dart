import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:sizer/sizer.dart';

class RegisterController extends GetxController {
  RxInt selectedRadio = 0.obs;
  RxBool obscure = true.obs;
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatpassTextController = TextEditingController();
  final calendarTextController = TextEditingController();

  void setSelectedGender(int value) {
    selectedRadio.value = value;
  }

  showPassword() {
    obscure.value = !obscure.value;
    update();
  }

  void selectDate(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          decoration: const BoxDecoration(color: AppColor.platinum),
          child: Column(
            children: [
              Expanded(
                  child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate.value,
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate.value = newDate;
                },
              )),
              CupertinoButton(
                  child: const Text("Done"), onPressed: () => Get.back()),
            ],
          ),
        );
      },
    );
  }
}
