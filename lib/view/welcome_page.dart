import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/welcome_controller.dart';
import 'package:project_mobile/view/login_page.dart';
import 'package:project_mobile/view/register_page.dart';
import 'package:project_mobile/widget.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  final controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        body: Stack(children: [
          CarouselSlider(
              items: controller.imgList
                  .map((item) => Column(
                      children: [Image.network(item, fit: BoxFit.fitHeight)]))
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true, height: 2000, viewportFraction: 2)),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Welcome Back",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const Text(
                    'It’s never too early or too late to work towards being the healthiest you',
                    style: Font.white18B),
                const SizedBox(height: 5),
                Button.button("Sign In", () => Get.to(() => LoginPage())),
                Button.button("Sign Up", () => Get.to(() => RegisterPage())),
              ]),
        ]));
  }
}
