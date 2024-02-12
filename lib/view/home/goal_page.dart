// ignore: file_names
import 'package:flutter/material.dart';

import 'package:project_mobile/constant/color.dart';
import 'package:sizer/sizer.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 70.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color: AppColor.platinum,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ));
  }
}
