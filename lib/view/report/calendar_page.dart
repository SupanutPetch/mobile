import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: Column(children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(FontAwesomeIcons.chevronLeft,
                  color: AppColor.orange)),
          Container(
              height: 48.h,
              decoration: BoxDecoration(
                  color: AppColor.platinum,
                  borderRadius: BorderRadius.circular(15)),
              child: TableCalendar(
                  currentDay: DateTime.now(),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now())),
          SizedBox(height: 2.h),
          Container(
            height: 20.h,
            decoration: BoxDecoration(
                color: AppColor.platinum,
                borderRadius: BorderRadius.circular(15)),
          )
        ])));
  }
}
