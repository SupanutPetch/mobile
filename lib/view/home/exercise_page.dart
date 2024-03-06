import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/view/exercise/listposes_page.dart';
import 'package:project_mobile/widget.dart';
import 'package:sizer/sizer.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Center(child: goalData()),
              const Spacer(),
              Button.buttonwithicon(
                  "Add Exercise",
                  () => Get.to(() => const ListPosesPage()),
                  FontAwesomeIcons.plus)
            ])));
  }

  Widget goalData() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
          height: 25.h,
          width: 85.w,
          decoration: BoxDecoration(
              color: AppColor.platinum,
              borderRadius: BorderRadius.circular(20))),
    );
  }
}
