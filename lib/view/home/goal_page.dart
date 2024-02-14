import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/goal_controller.dart';
import 'package:project_mobile/widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:sizer/sizer.dart';

class GoalPage extends StatelessWidget {
  GoalPage({super.key});

  final controller = Get.put(GoalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: Container(
                  height: 70.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color: AppColor.platinum,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      chartBMI(),
                      const Spacer(),
                      Button.button(
                          "Calculate Goal",
                          () => Get.dialog(WidgetAll.calculateGoal(
                              controller.hightController,
                              controller.weightController,
                              dropdown(),
                              controller.calculate))),
                      SizedBox(height: 2.h)
                    ],
                  )))
        ])));
  }

  Widget chartBMI() {
    return SizedBox(
        height: 20.h,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: true,
              showAxisLine: false,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 30, color: Colors.green),
                GaugeRange(startValue: 30, endValue: 70, color: Colors.orange),
                GaugeRange(startValue: 70, endValue: 100, color: Colors.red)
              ],
              pointers: const <GaugePointer>[
                NeedlePointer(value: 60)
              ])
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
