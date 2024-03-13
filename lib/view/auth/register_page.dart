import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitcal/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/constant/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitcal/controller/auth/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: WidgetAll.appbar(),
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: ListView(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("lib/asset/iconapp.jpg", scale: 0.15.h),
                    const Center(
                        child: Text("สมัครการใช้งาน", style: Font.white30B)),
                    Textformfields.fieldBlank(
                        "ชื่อผู้ใช้งาน",
                        FontAwesomeIcons.user,
                        controller.userNameTextController,
                        AppColor.orange),
                    Textformfields.fieldBlank(
                        "อีเมล",
                        FontAwesomeIcons.envelope,
                        controller.emailTextController,
                        AppColor.orange),
                    GetX<RegisterController>(
                        init: RegisterController(),
                        initState: (_) {},
                        builder: (_) {
                          return Textformfields.fieldPassWord(
                              "รหัสผ่าน",
                              FontAwesomeIcons.lock,
                              _.obscure.value,
                              () => _.showPassword(),
                              controller.passwordTextController,
                              true);
                        }),
                    Textformfields.fieldPassWord(
                        "ยืนยันรหัสผ่าน",
                        FontAwesomeIcons.lock,
                        true,
                        () => controller.showPassword(),
                        controller.repeatpassTextController,
                        false),
                    SizedBox(height: 2.h),
                    Row(children: [
                      const Text("วันเกิด :  ", style: Font.white20B),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.platinum),
                          label: Obx(() => Text(
                              DateFormat.yMd()
                                  .format(controller.selectedDate.value),
                              style: Font.black18B)),
                          icon: const Icon(FontAwesomeIcons.calendarDays,
                              color: AppColor.orange),
                          onPressed: () {
                            controller.selectDate(context);
                          })
                    ]),
                    Row(children: [
                      const Text("เพศ :", style: Font.white18B),
                      Obx(() => selectGender())
                    ]),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                        onPressed: () => controller.signUp(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.orange),
                        child: const Text("สมัครสมาชิก",
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)))
                  ]))
        ])));
  }

  Widget selectGender() {
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Radio(
          activeColor: AppColor.orange,
          value: 0,
          groupValue: controller.selectedRadio.value,
          onChanged: (value) => controller.setSelectedGender(value!)),
      const Text('ชาย', style: Font.white18B),
      Radio(
          activeColor: AppColor.orange,
          value: 1,
          groupValue: controller.selectedRadio.value,
          onChanged: (value) => controller.setSelectedGender(value!)),
      const Text('หญิง', style: Font.white18B)
    ]));
  }
}
