import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/controller/exercise/exercise_controller.dart';
import 'package:kitcal/controller/food/listfood_controller.dart';
import 'package:kitcal/controller/goal_controller.dart';
import 'package:kitcal/controller/report/calendar_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});
  final controller = Get.put(CalenderController());
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th', null);

    return Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: Column(children: [
          headTitle(),
          SizedBox(height: 2.h),
          calander(),
          SizedBox(height: 2.h),
          Obx(() => datadaily())
        ])));
  }

  Widget calander() {
    return Container(
        height: 40.h,
        decoration: BoxDecoration(
            color: AppColor.platinum, borderRadius: BorderRadius.circular(15)),
        child: Obx(() => TableCalendar(
              rowHeight: 5.h,
              locale: 'th_TH',
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              calendarStyle: const CalendarStyle(
                  selectedTextStyle: Font.white16B,
                  todayTextStyle: Font.white16B,
                  markerDecoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(
                      color: AppColor.orange, shape: BoxShape.circle),
                  todayDecoration: BoxDecoration(
                      color: AppColor.green, shape: BoxShape.circle)),
              currentDay: DateTime.now(),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: controller.selectedDate.value,
              selectedDayPredicate: (day) => controller.selected(day),
              onDaySelected: (selectedDay, focusedDay) {
                controller.selectedDate.value = selectedDay;
                controller.getdata();
              },
              eventLoader: (day) {
                return controller.eventsForDay(day);
              },
            )));
  }

  Widget datadaily() {
    return Container(
        height: 25.h,
        width: 90.w,
        decoration: BoxDecoration(
            color: AppColor.platinum, borderRadius: BorderRadius.circular(15)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                      child: Text("เป้าหมายในวันนี้", style: Font.black18B)),
                  SizedBox(height: 3.h),
                  Text(
                      "เป้าหมายการรับประทาน : ${GoalController.goalData[0].goalCal.toString()} แคลอรี่",
                      style: Font.black16),
                  Text("รับประทานไป : ${controller.totelCalEat} แคลอรี่",
                      style: Font.black16),
                  Text(
                      "เป้าหมายการออกกำลังกาย : ${GoalController.goalData[0].goalBurn.toString()} แคลอรี่",
                      style: Font.black16),
                  Text("ออกกำลังกายไป ${controller.totelCalExecise} แคลอรี่",
                      style: Font.black16)
                ])));
  }

  Widget headTitle() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            height: 2.h,
            width: 5.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColor.green)),
        const Text("สำเร็จตามเป้าหมาย", style: Font.white16),
        Container(
            height: 2.h,
            width: 5.w,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
        const Text("น้อยกว่าเป้าหมาย", style: Font.white16)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            height: 2.h,
            width: 5.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColor.orange)),
        SizedBox(width: 1.w),
        const Text("มากกว่าเป้าหมาย", style: Font.white16)
      ])
    ]);
  }
}
