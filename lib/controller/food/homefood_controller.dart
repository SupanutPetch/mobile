import 'dart:async';

import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/food/listfood_controller.dart';
import 'package:project_mobile/controller/goal_controller.dart';
import 'package:project_mobile/view/eating/navigationbar.dart';

class HomeFoodController extends GetxController with StateMixin {
  var data = <CircularStackEntry>[].obs;
  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getdata();
    change(null, status: RxStatus.success());
    super.onInit();
    Timer.periodic(const Duration(seconds: 5), (_) => getdata());
  }

  Future onrefresh() async {
    await getdata();
    Get.forceAppUpdate();
  }

  calculateCelRemain() {
    if (ListFoodController.totelCalEat.value != 0 &&
        GoalController.goalData[0].goalCal != 0.0) {
      var totelCal =
          double.parse(ListFoodController.totelCalEat.value.toString());
      var goal = GoalController.goalData[0].goalCal!;
      var result = goal - totelCal;
      if (result <= 0) {
        var totel = result * -1;
        return "ปริมาณที่เกิน\n   ${totel.toStringAsFixed(2)}\n   แคลอรี่";
      } else {
        return "   คงเหลือ\n   ${result.toStringAsFixed(2)}\n   แคลอรี่";
      }
    } else {
      return "  คงเหลือ\n ${GoalController.goalData[0].goalCal}\n   แคลอรี่";
    }
  }

  Color checkcolor() {
    if (ListFoodController.totelCalEat.value == 0.0) {
      return AppColor.platinum;
    } else if ((100 - ListFoodController.totelCalEat.value.toDouble()) *
            360 /
            100 >
        GoalController.goalData[0].goalCal! * 360 / 100) {
      return Colors.redAccent;
    } else {
      return AppColor.green;
    }
  }

  getdata() async {
    if (GoalController.goalData.isNotEmpty) {
      data.value = <CircularStackEntry>[
        CircularStackEntry([
          CircularSegmentEntry(
              (100 - ListFoodController.totelCalEat.value.toDouble()) *
                  360 /
                  100,
              checkcolor()),
          CircularSegmentEntry(GoalController.goalData[0].goalCal! * 360 / 100,
              AppColor.platinum)
        ]),
      ].obs;
      Get.forceAppUpdate();
    }
  }

  gotolistfood() {
    Get.to(() => const NavigationBarPage())!.then((value) {
      if (value == true) {
        Get.forceAppUpdate();
        update();
      }
    });
  }
}
