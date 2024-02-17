import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/model/goal_mobel.dart';
import 'package:project_mobile/widget.dart';

class GoalController extends GetxController {
  RxList<GoalModel> goalData = <GoalModel>[].obs;
  final hightController = TextEditingController();
  final weightController = TextEditingController();
  final targetWeightController = TextEditingController();
  final goalDayController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  RxDouble height = 0.0.obs;
  RxDouble weight = 0.0.obs;
  RxInt targetWeight = 0.obs;
  RxInt goalDay = 0.obs;
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
    targetWeight.value = int.tryParse(targetWeightController.text) ?? 0;
    goalDay.value = int.tryParse(goalDayController.text) ?? 0;
    if (height.value != 0.0 &&
        weight.value != 0.0 &&
        targetWeight.value != 0 &&
        goalDay.value != 0) {
      double heightInMeter = height / 100;
      double bmi = weight / (heightInMeter * heightInMeter);
      double bmr = await calculateBMR(weight.value, height.value);
      double tdee = calculateTDEE(bmr, selectActivity.value);
      double weightDifference = targetWeight.value - weight.value;
      double dailyCalories = await calculateDailyCalories(
          tdee, weightDifference, bmr, goalDay.value);
      await firestore.collection("goalData").doc(auth.currentUser!.uid).set({
        "goalBMI": bmi.toStringAsFixed(2),
        "goalBMR": bmr.toStringAsFixed(2),
        "goalTDEE": tdee.toStringAsFixed(2),
        "goalCal": dailyCalories,
        // "goalBurn": goalBurn,
        // "goalDietPlanning": goalDietPlanning,
        "goalWeight": targetWeight.value,
        "goalDay": goalDay.value,
      });
      debugPrint("dailyCalories : $dailyCalories");
      debugPrint("weightDifference : $weightDifference");
      debugPrint("BMI : ${bmi.toString()}");
      debugPrint("BMR : ${bmr.toStringAsFixed(2)}");
      debugPrint("TDEE : ${tdee.toStringAsFixed(2)}");
      // hightController.clear();
      // weightController.clear();
      // targetWeightController.clear();
      // goalDayController.clear();
    } else {
      Get.dialog(WidgetAll.dialogWithButton(
          FontAwesomeIcons.triangleExclamation,
          "Please provide accurate information.",
          () => Get.back(),
          "Close"));
    }
  }

  calculateDailyCalories(
      double tdee, double weightDifference, double bmr, int goalDay) {
    if (weightDifference < 0) {
      var dailyCal = 0.0;
      dailyCal = (weightDifference * 7700 / goalDay);
      if (dailyCal > bmr) {
        return bmr - dailyCal;
      } else {
        return dailyCal;
      }
    } else if (weightDifference > 0) {
      return tdee + (weightDifference * 7700 / goalDay);
    }
    return tdee;
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
