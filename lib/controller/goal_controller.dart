import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/widget.dart';

class GoalController extends GetxController {
  final hightController = TextEditingController();
  final weightController = TextEditingController();
  RxDouble height = 0.0.obs;
  RxDouble weight = 0.0.obs;
  var selectActivity = "sedentary".obs;
  final List<String> activityLevel = [
    "sedentary",
    "lightlyActive",
    "moderatelyActive",
    "veryActive",
    "extraActive"
  ];
  calculate() async {
    height.value = double.tryParse(hightController.text) ?? 0.0;
    weight.value = double.tryParse(weightController.text) ?? 0.0;
    if (height.value != 0.0 && weight.value != 0.0) {
      double heightInMeter = height / 100;
      double bmi = weight / (heightInMeter * heightInMeter);
      double bmr = await calculateBMR(weight.value, height.value);
      double tdee = calculateTDEE(bmr, selectActivity.value);
      debugPrint(bmi.toString());
      debugPrint(bmr.toString());
      debugPrint(tdee.toString());
    } else {
      Get.dialog(WidgetAll.dialogWithButton(
          FontAwesomeIcons.triangleExclamation,
          "Please provide accurate information.",
          () => Get.back(),
          "Close"));
    }
  }

  calculateBMR(double weight, double height) {
    String dateString = GetData.userData[0].userBirthDay!;
    DateTime birthDay = DateTime(
        int.parse(dateString.substring(4)),
        int.parse(dateString.substring(0, 2)),
        int.parse(dateString.substring(2, 4)));

    int age = DateTime.now().year - birthDay.year;
    if (DateTime.now().month < birthDay.month ||
        (DateTime.now().month == birthDay.month &&
            DateTime.now().day < birthDay.day)) {
      age--;
    }
    if (GetData.userData[0].userGender == "Male") {
      return 66.47 + (13.7 * weight) + (5 * height) - (6.8 * age);
    } else {
      return 655.1 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
    }
  }

  double calculateTDEE(double bmr, String activityLevel) {
    double activityLevelFactor = 0.0;
    switch (activityLevel) {
      case "sedentary":
        activityLevelFactor = 1.2;
        break;
      case "lightlyActive":
        activityLevelFactor = 1.375;
        break;
      case "moderatelyActive":
        activityLevelFactor = 1.55;
        break;
      case "veryActive":
        activityLevelFactor = 1.725;
        break;
      case "extraActive":
        activityLevelFactor = 1.9;
        break;
    }

    return bmr * activityLevelFactor;
  }

  changeActivity(String value) {
    selectActivity.value = value;
  }
}
