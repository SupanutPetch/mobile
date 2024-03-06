import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/model/goal_model.dart';
import 'package:project_mobile/widget.dart';
import 'package:sizer/sizer.dart';

class GoalController extends GetxController with StateMixin {
  static RxList<GoalModel> goalData = <GoalModel>[].obs;
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
  RxDouble burnCal = 0.0.obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getdata();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  textBMI(double? bmi) {
    if (bmi != null && bmi != 0.0) {
      switch (bmi) {
        case < 18.5:
          return "ผอมเกินไป";
        case < 25:
          return "น้ำหนักปกติ";
        case < 30:
          return "น้ำหนักเกิน";
        case < 35:
          return "อ้วน";
        case > 35:
          return "อ้วนมาก";
      }
    } else {
      return "";
    }
  }

  differenceDate() {
    if (goalData[0].goalEndDate!.isNotEmpty &&
        goalData[0].goalEndDate != null) {
      DateFormat format = DateFormat("MM/dd/yyyy");
      var endDateString = goalData[0].goalEndDate;
      DateTime endDate = format.parse(endDateString!);
      int remainingDays = endDate
          .difference(DateTime.now().subtract(const Duration(days: 1)))
          .inDays;
      return remainingDays.toString();
    } else {
      return "";
    }
  }

  changeColorBMI(double? bmi) {
    if (bmi != null && bmi != 0.0) {
      switch (bmi) {
        case < 18.5:
          return Colors.blue;
        case < 25:
          return AppColor.green;
        case < 30:
          return Colors.yellow;
        case < 35:
          return Colors.orange;
        case > 35:
          return Colors.red;
      }
    } else {
      return AppColor.orange;
    }
  }

  getdata() async {
    WidgetAll.loading();
    QuerySnapshot querySnapshot =
        await GetData.firestore.collection("goalData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    for (var list in docs) {
      var docid = list.id.split('-');
      if (docid[0] == GetData.userData[0].userID &&
          docid[1].compareTo(DateFormat("yyyyMMdd").format(DateTime.now())) <=
              0) {
        goalData.assignAll(docs.map((data) {
          return GoalModel(
              goalBMI: double.tryParse(data["goalBMI"]),
              goalBMR: double.tryParse(data["goalBMR"]),
              goalTDEE: double.tryParse(data["goalTDEE"]),
              goalCal: double.tryParse(data["goalCal"]),
              goalBurn: double.tryParse(data["goalBurn"]),
              goalWeight: double.tryParse(data["goalWeight"]),
              goalDay: double.tryParse(data["goalDay"].toString()),
              goalStartDate: data["goalStartDate"],
              goalEndDate: data["goalEndDate"]);
        }).toList());
        if (goalData[0].goalCal! < 0.0) {
          goalData[0].goalCal = goalData[0].goalCal! * -1;
        }
        if (Get.isDialogOpen!) {
          Get.back();
        }
        update();
      } else {
        return GoalModel(
            goalBMI: 0,
            goalBMR: 0,
            goalTDEE: 0,
            goalCal: 0,
            goalBurn: 0,
            goalWeight: 0,
            goalDay: 0,
            goalStartDate: "",
            goalEndDate: "");
      }
      update();
    }
  }

  var selectActivity = "sedentary".obs;
  final List<String> activityLevel = [
    "sedentary",
    "lightlyActive",
    "moderatelyActive",
    "veryActive",
  ];

  calculate() async {
    if (GetData.userData[0].userBirthDay!.isNotEmpty) {
      height.value = double.tryParse(hightController.text) ?? 0.0;
      weight.value = double.tryParse(weightController.text) ?? 0.0;
      targetWeight.value = int.tryParse(targetWeightController.text) ?? 0;
      goalDay.value = int.tryParse(goalDayController.text) ?? 0;
      var date = DateTime.now();
      var dateformat = DateFormat("yyyyMMdd").format(date);
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
            tdee, weightDifference, bmr, goalDay.value, selectActivity.value);
        await firestore
            .collection("goalData")
            .doc("${auth.currentUser!.uid}-$dateformat")
            .set({
          "goalBMI": bmi.toStringAsFixed(2),
          "goalBMR": bmr.toStringAsFixed(2),
          "goalTDEE": tdee.toStringAsFixed(2),
          "goalCal": dailyCalories.toStringAsFixed(2),
          "goalBurn": burnCal.value.toStringAsFixed(2),
          "goalWeight": targetWeight.value.toStringAsFixed(2),
          "goalDay": goalDay.value.toString(),
          'goalStartDate': DateFormat.yMd().format(DateTime.now()),
          'goalEndDate': DateFormat.yMd()
              .format(DateTime.now().add(Duration(days: goalDay.value)))
        });
        await firestore
            .collection("UserData")
            .doc(auth.currentUser!.uid)
            .update({
          "userWeight": weight.value.toString(),
          "userHigh": height.value.toString(),
          "userActivity": selectActivity.value
        });
        debugPrint("dailyCalories : $dailyCalories");
        debugPrint("weightDifference : $weightDifference");
        debugPrint("BMI : ${bmi.toStringAsFixed(2)}");
        debugPrint("BMR : ${bmr.toStringAsFixed(2)}");
        debugPrint("TDEE : ${tdee.toStringAsFixed(2)}");
        debugPrint("burnCal : ${burnCal.toStringAsFixed(2)}");
        hightController.clear();
        weightController.clear();
        targetWeightController.clear();
        goalDayController.clear();
        await getdata();
        update();
      } else {
        Get.dialog(WidgetAll.dialogWithButton(
            FontAwesomeIcons.triangleExclamation,
            "Please provide accurate information.",
            () => Get.back(),
            "Close"));
      }
    } else {
      debugPrint("ยังไม่มีวันเกิด");
    }
  }

  calculateDailyCalories(double tdee, double weightDifference, double bmr,
      int goalDay, String activityLevel) async {
    burnCal.value = 0;
    if (weightDifference < 0) {
      weightDifference = weightDifference * -1;
      var dailyCal = weightDifference * 7700 / double.parse(goalDay.toString());
      if (activityLevel != "extraActive") {
        var teddActivity = bmr * 1.725;
        burnCal.value = teddActivity - bmr;
        var check = dailyCal - burnCal.value;
        if (check < (tdee - 500)) {
          burnCal.value = burnCal.value + ((tdee - 500) - check);
          return dailyCal - burnCal.value;
        } else {
          return check;
        }
      }
    } else if (weightDifference > 0) {
      bool exercise = await Get.dialog(AlertDialog(
          content: SizedBox(
              height: 20.h,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.dumbbell,
                        color: AppColor.orange, size: 25.sp),
                    const Text("ต้องการออกกำลังกายไหม?", style: Font.black18),
                    SizedBox(height: 2.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.platinum),
                              onPressed: () => Get.back(result: true),
                              child: Icon(FontAwesomeIcons.check,
                                  color: AppColor.green, size: 25.sp)),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.platinum),
                              onPressed: () => Get.back(result: false),
                              child: Icon(FontAwesomeIcons.xmark,
                                  color: Colors.red, size: 25.sp))
                        ])
                  ]))));
      if (exercise) {
        if (activityLevel != "extraActive") {
          var teddActivity = bmr * 1.725;
          burnCal.value = teddActivity - tdee;
          return teddActivity +
              (weightDifference * 7700 / double.parse(goalDay.toString()));
        } else {
          burnCal.value = tdee - bmr;
          return tdee +
              (weightDifference * 7700 / double.parse(goalDay.toString()));
        }
      } else {
        return tdee +
            (weightDifference * 7700 / double.parse(goalDay.toString()));
      }
    }
    bool exercise = await Get.dialog(AlertDialog(
        content: SizedBox(
            height: 20.h,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.dumbbell,
                      color: AppColor.orange, size: 25.sp),
                  const Text("ต้องการออกกำลังกายไหม?", style: Font.black18),
                  SizedBox(height: 2.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.platinum),
                            onPressed: () => Get.back(result: true),
                            child: Icon(FontAwesomeIcons.check,
                                color: AppColor.green, size: 25.sp)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.platinum),
                            onPressed: () => Get.back(result: false),
                            child: Icon(FontAwesomeIcons.xmark,
                                color: Colors.red, size: 25.sp))
                      ])
                ]))));
    if (exercise) {
      if (activityLevel != "extraActive") {
        var teddActivity = bmr * 1.725;
        burnCal.value = teddActivity - tdee;
        return teddActivity + (weightDifference * 7700 / goalDay);
      } else {
        return tdee;
      }
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
