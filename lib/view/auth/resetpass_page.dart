import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/resetpass_controller.dart';
import 'package:project_mobile/widget.dart';
import 'package:sizer/sizer.dart';

class ResetPassPage extends StatelessWidget {
  ResetPassPage({super.key});
  final contrller = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetAll.appbar(),
        backgroundColor: AppColor.black,
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("lib/asset/iconapp.jpg", scale: 0.15.h),
          SizedBox(height: 5.h),
          const Text("Reset Password", style: Font.white30B),
          Textformfields.fieldBlank("Email", FontAwesomeIcons.envelope,
              contrller.emailTextController, AppColor.green),
          SizedBox(height: 3.h),
          Button.buttonLong("Sent mail!", () => contrller.sentMailReset())
        ])));
  }
}
