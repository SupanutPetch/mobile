import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/view/eating/breakfast_page.dart';
import 'package:project_mobile/widget.dart';
import 'package:sizer/sizer.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
          child: Column(),
        ));
  }

  Widget meals(IconData iconData, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 10.h,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColor.black),
            borderRadius: BorderRadius.circular(20),
            color: AppColor.green),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData,
                color: AppColor.orange,
                shadows: const [Shadow(blurRadius: 3, color: AppColor.black)]),
            Text(title, style: Font.white18B),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColor.orange),
                onPressed: () {
                  WidgetAll.loading();
                  Get.to(() => const BreakfastPage());
                  if (Get.isDialogOpen!) {}
                },
                child: const Text('Edit', style: Font.black16B)),
          ],
        ),
      ),
    );
  }
}
