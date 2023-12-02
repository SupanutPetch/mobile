import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/view/bottombar.dart';
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.personRunning,
                        size: 80,
                        color: AppColor.darknavi,
                      ),
                      const SizedBox(height: 10),
                      const Text("Sigin In", style: Font.base30B),
                      const Text("Sign In to Continue", style: Font.base20B),
                      const SizedBox(height: 20),
                      Textformfields.fieldBlank("Email", Icons.account_circle,
                          loginController.emailTextController),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 30),
                      Button.buttonLong(
                          "Sign In", () => Get.to(() => BottomBar())),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 50.0, right: 10.0),
                                  child: const Divider(
                                      color: Colors.red,
                                      height: 36,
                                      thickness: 2))),
                          const Text("OR", style: Font.base16B),
                          Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 50.0),
                                  child: const Divider(
                                      color: Colors.red,
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
                                  "g")),
                          const SizedBox(width: 20),
                          socialButton(FontAwesomeIcons.facebook, () {}, "F"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }

  Widget socialButton(IconData icon, var function, String text) {
    return FloatingActionButton(
      heroTag: text,
      backgroundColor: AppColor.custard,
      onPressed: () => function(),
      child: Icon(
        icon,
        color: AppColor.white,
      ),
    );
  }
}
