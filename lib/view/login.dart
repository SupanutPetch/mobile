import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_mobile/widget.dart';

import '../controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 30,
          backgroundColor: AppColor.lightnavi,
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(left: 2),
              child: const Icon(
                FontAwesomeIcons.chevronLeft,
                size: 20,
                color: Colors.amber,
              ),
            ),
            onTap: () => Get.back(),
          ),
        ),
        backgroundColor: AppColor.lightnavi,
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Sign In",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                Textformfields.fieldBlank(
                    "Username or Email", Icons.account_circle),
                const SizedBox(height: 10),
                GetX<LoginController>(
                    init: LoginController(),
                    initState: (_) {},
                    builder: (_) {
                      return Textformfields.fieldPassWord(
                          "Password",
                          FontAwesomeIcons.key,
                          _.obscure.value,
                          () => _.showPassword());
                    }),
                const SizedBox(height: 30),
                Button.buttonSave(
                    "Sign In",
                    const Icon(Icons.login, color: AppColor.black, weight: 2),
                    () {}),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            margin:
                                const EdgeInsets.only(left: 50.0, right: 20.0),
                            child: const Divider(
                                color: AppColor.lightred,
                                height: 36,
                                thickness: 2))),
                    const Text(
                      "OR",
                      style: Font.white16,
                    ),
                    Expanded(
                        child: Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 50.0),
                            child: const Divider(
                                color: AppColor.lightred,
                                height: 36,
                                thickness: 2))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: socialButton(FontAwesomeIcons.google)),
                    const SizedBox(width: 20),
                    socialButton(FontAwesomeIcons.facebookF),
                  ],
                )
              ],
            ),
          ),
        )));
  }

  Widget socialButton(IconData icon) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      onPressed: () {},
      child: Icon(
        icon,
        color: AppColor.lightnavi,
      ),
    );
  }
}
