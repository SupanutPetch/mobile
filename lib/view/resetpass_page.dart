import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/resetpass_controller.dart';
import 'package:project_mobile/view/login_page.dart';
import 'package:project_mobile/widget.dart';

class ResetPassPage extends StatelessWidget {
  ResetPassPage({super.key});
  final contrller = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetAll.appbar(),
        backgroundColor: AppColor.background,
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: Container(
                  height: 400,
                  width: 350,
                  decoration: BoxDecoration(
                      color: AppColor.cream,
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.key,
                            size: 70,
                            color: AppColor.custard,
                            shadows: [
                              Shadow(
                                  color: AppColor.black, offset: Offset(1, 1))
                            ]),
                        const SizedBox(height: 30),
                        const Text("Reset Password", style: Font.base20B),
                        Textformfields.fieldBlank(
                            "Email",
                            FontAwesomeIcons.envelope,
                            contrller.emailTextController,
                            AppColor.darknavi),
                        const SizedBox(height: 10),
                        Button.button("Sent to mail", () => Get.back())
                      ])))
        ])));
  }
}
