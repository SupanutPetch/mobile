import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/widget.dart';
import '../controller/login_controller.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_mobile/controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: WidgetAll.appbar(),
        backgroundColor: AppColor.background,
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      height: 600,
                      decoration: BoxDecoration(
                          color: AppColor.cream,
                          border: Border.all(color: AppColor.black, width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView(children: [
                              const Icon(FontAwesomeIcons.personRunning,
                                  size: 80, color: AppColor.darknavi),
                              const SizedBox(height: 20),
                              const Center(
                                  child: Text("Sign Up", style: Font.base30B)),
                              const Center(
                                  child: Text("Sign Up to Continue",
                                      style: Font.base20B)),
                              Textformfields.fieldBlank(
                                  "Email",
                                  Icons.account_circle,
                                  controller.emailTextController,
                                  false,
                                  AppColor.darknavi),
                              const SizedBox(height: 20),
                              GetX<LoginController>(
                                  init: LoginController(),
                                  initState: (_) {},
                                  builder: (_) {
                                    return Textformfields.fieldPassWord(
                                        "Password",
                                        FontAwesomeIcons.key,
                                        _.obscure.value,
                                        () => _.showPassword(),
                                        controller.passwordTextController);
                                  }),
                              const SizedBox(height: 20),
                              Textformfields.fieldBlank(
                                  "Repeat Password",
                                  FontAwesomeIcons.key,
                                  controller.repeatpassTextController,
                                  true,
                                  AppColor.custard),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Text("birthday :  ",
                                      style: Font.base20B),
                                  WidgetAll.boxDateForPick(),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(children: [
                                const Text("Gender", style: Font.base20B),
                                Obx(() => radioButton())
                              ]),
                              const SizedBox(height: 20),
                              Button.buttonLong("Sign Up", () {}),
                            ])),
                      ))),
            ])));
  }

  Widget radioButton() {
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Radio(
          value: 0,
          groupValue: controller.selectedRadio.value,
          onChanged: (value) => controller.setSelectedRadio(value!)),
      const Text('man', style: Font.base16B),
      Radio(
          value: 1,
          groupValue: controller.selectedRadio.value,
          onChanged: (value) => controller.setSelectedRadio(value!)),
      const Text('woman', style: Font.base16B)
    ]));
  }
}
