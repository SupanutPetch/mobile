import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/controller/goal_controller.dart';
import 'package:project_mobile/widget.dart';

import 'package:sizer/sizer.dart';

class GoalPage extends StatelessWidget {
  GoalPage({super.key});

  final controller = Get.put(GoalController());
  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Scaffold(
            backgroundColor: AppColor.black,
            body: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  GoalController.goalData.isNotEmpty
                      ? containerGoal()
                      : const SizedBox(),
                  SizedBox(height: 2.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          containerIcon(
                              "BMI : ${GoalController.goalData[0].goalBMI ?? ""}",
                              FontAwesomeIcons.person,
                              controller.changeColorBMI(
                                  GoalController.goalData[0].goalBMI)),
                          SizedBox(height: 0.5.h),
                          Text(
                              controller
                                  .textBMI(GoalController.goalData[0].goalBMI),
                              style: Font.white16)
                        ]),
                        Column(children: [
                          containerIcon(
                              "BMR : ${GoalController.goalData[0].goalBMR ?? ""}",
                              FontAwesomeIcons.fireFlameSimple,
                              Colors.redAccent),
                          SizedBox(height: 0.5.h),
                          const Text("การเผาผลาญขั้นพื้นฐาน",
                              style: Font.white16)
                        ])
                      ]),
                  SizedBox(height: 2.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          containerIcon(
                              "TDEE : ${GoalController.goalData[0].goalTDEE ?? ""}",
                              FontAwesomeIcons.personWalking,
                              AppColor.green),
                          SizedBox(height: 0.5.h),
                          const Text("การเผาผลาญต่อวัน", style: Font.white16)
                        ]),
                        Column(children: [
                          containerIcon(
                              "เหลือ : ${controller.differenceDate()} วัน",
                              FontAwesomeIcons.hourglass,
                              Colors.pink),
                          SizedBox(height: 0.5.h),
                          const Text("ระยะเวลา", style: Font.white16)
                        ])
                      ]),
                  const Spacer(),
                  Center(
                      child: Button.button(
                          "คำนวนเป้าหมาย",
                          () => Get.dialog(WidgetAll.calculateGoal(
                              controller.hightController,
                              controller.weightController,
                              Obx(() => dropdown()),
                              controller.targetWeightController,
                              controller.goalDayController,
                              controller.calculate)))),
                  SizedBox(height: 3.h)
                ]))),
        onLoading: Scaffold(
            backgroundColor: AppColor.black,
            body: Center(
                child: LoadingAnimationWidget.threeRotatingDots(
              color: AppColor.orange,
              size: 100,
            ))));
  }

  Widget containerGoal() {
    return Obx(() => GoalController.goalData.isNotEmpty
        ? Container(
            height: 20.h,
            width: 90.w,
            decoration: BoxDecoration(
                color: AppColor.platinum,
                borderRadius: BorderRadius.circular(30)),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            "น้ำหนักปัจจุบัน : ${GetData.userData[0].userWeight ?? controller.weight.value} กก.",
                            style: Font.black16),
                        Text(
                            "น้ำหนักที่ต้องการ : ${GoalController.goalData[0].goalWeight!} กก.",
                            style: Font.black16),
                        Text(
                            "วันที่เริ่ม : ${GoalController.goalData[0].goalStartDate!}",
                            style: Font.black16),
                        Text(
                            "วันสิ้นสุด : ${GoalController.goalData[0].goalEndDate!}",
                            style: Font.black16)
                      ])),
              const Spacer(),
              Icon(Icons.emoji_flags, color: AppColor.orange, size: 15.h)
            ]))
        : const SizedBox());
  }

  Widget containerIcon(String titel, IconData icon, Color iconcolor) {
    return Container(
        height: 20.h,
        width: 40.w,
        decoration: BoxDecoration(
            color: AppColor.platinum, borderRadius: BorderRadius.circular(30)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 8.h, color: iconcolor),
          SizedBox(height: 2.h),
          Text(titel, style: Font.black18)
        ]));
  }

  Widget dropdown() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Text("Activity", style: Font.white16),
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.platinum)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                  isExpanded: true,
                  dropdownColor: AppColor.black,
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(20),
                  value: controller.selectActivity.value,
                  items: controller.activityLevel.map((option) {
                    return DropdownMenuItem(
                        value: option, child: Text(option, style: Font.white));
                  }).toList(),
                  onChanged: (value) {
                    controller.changeActivity(value!);
                  })))
    ]);
  }
}
