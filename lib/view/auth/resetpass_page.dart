import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/controller/auth/resetpass_controller.dart';
import 'package:kitcal/widget.dart';
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
          const Text("เปลี่ยนรหัสผ่านใหม่", style: Font.white30B),
          Textformfields.fieldBlank("อีเมล", FontAwesomeIcons.envelope,
              contrller.emailTextController, AppColor.orange),
          SizedBox(height: 3.h),
          Button.button("ส่งเมล!", () => contrller.sentMailReset())
        ])));
  }
}
