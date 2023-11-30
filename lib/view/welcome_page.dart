import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/view/login_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_mobile/view/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Text(
                'It’s never too early or too late to work towards being the healthiest you',
                style: Font.white18,
              ),
              const SizedBox(height: 5),
              button(
                "Sign In",
                () => Get.to(() => LoginPage()),
              ),
              button("Sign Up", () => Get.to(() => RegisterPage())),
            ],
          ),
        )),
      ),
    );
  }

  Widget button(String buttonName, dynamic function) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: () => function(),
          child: Text(
            buttonName,
            style: Font.white18,
          )),
    );
  }
}
