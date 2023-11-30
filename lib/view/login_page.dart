import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/widget.dart';
import '../controller/login_controller.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 30,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(left: 2),
              child: const Icon(FontAwesomeIcons.chevronLeft,
                  size: 20, color: Colors.amber),
            ),
            onTap: () => Get.back(),
          ),
        ),
        backgroundColor: AppColor.lightnavi,
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sign In",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      Textformfields.fieldBlank("Email", Icons.account_circle),
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
                          const Icon(Icons.login,
                              color: AppColor.black, weight: 2),
                          () => loginController.signInwithEmail()),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 50.0, right: 20.0),
                                  child: const Divider(
                                      color: AppColor.lightred,
                                      height: 36,
                                      thickness: 2))),
                          const Text("OR", style: Font.white16),
                          Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 50.0),
                                  child: const Divider(
                                      color: AppColor.lightred,
                                      height: 36,
                                      thickness: 2)))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: socialButton(
                            FontAwesomeIcons.google,
                            () => loginController.signInWithGoogle(),
                            "g",
                          )),
                          const SizedBox(width: 20),
                          socialButton(FontAwesomeIcons.facebookF, () {}, "F"),
                        ],
                      )
                    ],
                  ),
                ))));
  }

  Widget socialButton(IconData icon, var function, String text) {
    return FloatingActionButton(
      heroTag: text,
      backgroundColor: Colors.amber,
      onPressed: () => function(),
      child: Icon(
        icon,
        color: AppColor.lightnavi,
      ),
    );
  }
}
