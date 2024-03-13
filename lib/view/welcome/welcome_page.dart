import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/controller/welcome_controller.dart';
import 'package:kitcal/view/auth/login_page.dart';
import 'package:kitcal/view/auth/register_page.dart';
import 'package:kitcal/widget.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  final controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: Stack(children: [
          CarouselSlider(
              items: controller.imgList
                  .map((item) =>
                      Column(mainAxisSize: MainAxisSize.max, children: [
                        Image.network(item, fit: BoxFit.cover, height: 100.h)
                      ]))
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  height: 100.h,
                  viewportFraction: Platform.isIOS ? 2 : 1.3)),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("ยินดีต้อนรับ",
                    style: TextStyle(
                        fontSize: 5.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Padding(
                  padding: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                  child: const Text(
                      'ไม่มีคำว่าเร็วหรือสายเกินไปที่จะพยายามมีสุขภาพดีที่สุด',
                      style: Font.white18B),
                ),
                SizedBox(height: 0.5.h),
                Button.button("เข้าสู่ระบบ", () => Get.off(() => LoginPage())),
                Button.button(
                    "สมัครสมาชิก", () => Get.to(() => RegisterPage())),
                SizedBox(height: 3.h)
              ]),
        ]));
  }
}
