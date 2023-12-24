// ignore: file_names
import 'package:flutter/material.dart';

import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/widget.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const Center(
                child: Text("Goal", style: Font.white30B),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
                  child: Container(
                      height: 500,
                      width: 380,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: AppColor.cream,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Calories", style: Font.base20B),
                              const Spacer(),
                              Center(
                                child: WidgetAll.dataTarget(
                                    "Goal / Day", "data", "เป้าหมายต่อวัน"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  WidgetAll.dataTarget(
                                      "BMR(kcal)", "data", "เผาผลาญในแต่ละวัน"),
                                  WidgetAll.dataTarget(
                                      "BMI", "data", "ดัชนีมวลกาย")
                                ],
                              ),
                            ],
                          ))))
            ])));
  }
}
