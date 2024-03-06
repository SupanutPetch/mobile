import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_mobile/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_mobile/controller/auth/register_controller.dart';

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
                        child:
                            Text("Sign Up to Continue", style: Font.white30B)),
                    Textformfields.fieldBlank("UserName", FontAwesomeIcons.user,
                        controller.userNameTextController, AppColor.orange),
                    Textformfields.fieldBlank(
                        "Email",
                        FontAwesomeIcons.envelope,
                        controller.emailTextController,
                        AppColor.orange),
                    GetX<RegisterController>(
                        init: RegisterController(),
                        initState: (_) {},
                        builder: (_) {
                          return Textformfields.fieldPassWord(
                              "Password",
                              FontAwesomeIcons.lock,
                              _.obscure.value,
                              () => _.showPassword(),
                              controller.passwordTextController,
                              true);
                        }),
                    Textformfields.fieldPassWord(
                        "Re-Password",
                        FontAwesomeIcons.lock,
                        true,
                        () => controller.showPassword(),
                        controller.repeatpassTextController,
                        false),
                    SizedBox(height: 2.h),
                    Row(children: [
                      const Text("birthday :  ", style: Font.white20B),
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
                      const Text("Gender :", style: Font.white18B),
                      Obx(() => selectGender())
                    ]),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                        onPressed: () => controller.signUp(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.green),
                        child: const Text("Sign up",
                            style: TextStyle(
                                color: AppColor.black,
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
      const Text('man', style: Font.white18B),
      Radio(
          activeColor: AppColor.orange,
          value: 1,
          groupValue: controller.selectedRadio.value,
          onChanged: (value) => controller.setSelectedGender(value!)),
      const Text('woman', style: Font.white18B)
    ]));
  }
}
