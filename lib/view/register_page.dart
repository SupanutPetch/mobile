import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/widget.dart';
import '../controller/login_controller.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final loginController = Get.put(LoginController());
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
                height: 700,
                decoration: BoxDecoration(
                    color: AppColor.cream,
                    border: Border.all(color: AppColor.black, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.personRunning,
                        size: 80,
                        color: AppColor.darknavi,
                      ),
                      const SizedBox(height: 20),
                      const Text("Sign Up", style: Font.base30B),
                      const Text("Sign Up to Continue", style: Font.base20B),
                      Textformfields.fieldBlank("Email", Icons.account_circle,
                          loginController.emailTextController),
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
                                loginController.passwordTextController);
                          }),
                      const SizedBox(height: 20),
                      GetX<LoginController>(
                          init: LoginController(),
                          initState: (_) {},
                          builder: (_) {
                            return Textformfields.fieldPassWord(
                                "Repeat Password",
                                FontAwesomeIcons.key,
                                _.obscure.value,
                                () => _.showPassword(),
                                loginController.repeatpassTextController);
                          }),
                      const SizedBox(height: 20),
                      const Text("AGE", style: Font.base20B),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Gender", style: Font.base20B),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Button.buttonSave("Sign Up", () {}),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
