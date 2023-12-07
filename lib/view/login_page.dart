import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/widget.dart';
import '../controller/login_controller.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/view/register_page.dart';
import 'package:project_mobile/view/resetpass_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.background,
        body: SafeArea(
            key: loginController.formkey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          height: 630,
                          decoration: BoxDecoration(
                              color: AppColor.cream,
                              border:
                                  Border.all(color: AppColor.black, width: 2),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(FontAwesomeIcons.personRunning,
                                      size: 80, color: AppColor.darknavi),
                                  const SizedBox(height: 10),
                                  const Text("Sigin In", style: Font.base30B),
                                  const Text("Sign In to Continue",
                                      style: Font.base20B),
                                  const SizedBox(height: 20),
                                  Textformfields.fieldBlank(
                                      "Email",
                                      FontAwesomeIcons.userTie,
                                      loginController.emailTextController,
                                      false,
                                      AppColor.darknavi),
                                  const SizedBox(height: 10),
                                  GetX<LoginController>(
                                      init: LoginController(),
                                      initState: (_) {},
                                      builder: (_) {
                                        return Textformfields.fieldPassWord(
                                            "Password",
                                            FontAwesomeIcons.lock,
                                            _.obscure.value,
                                            () => _.showPassword(),
                                            loginController
                                                .passwordTextController);
                                      }),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 130),
                                      child: TextButton(
                                          onPressed: () =>
                                              Get.to(() => ResetPassPage()),
                                          child: Text(
                                            "forgot Password?",
                                            style: Font.red16,
                                          ))),
                                  const SizedBox(height: 5),
                                  Button.buttonLong("Sign In",
                                      () => loginController.signInWithEmail()),
                                  Row(children: [
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
                                  ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: socialButton(
                                                FontAwesomeIcons.google,
                                                () => loginController
                                                    .signInWithGoogle(),
                                                "g")),
                                        const SizedBox(width: 20),
                                        socialButton(FontAwesomeIcons.facebook,
                                            () {}, "F")
                                      ]),
                                  const Spacer(),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 30),
                                        const Text("Don't have an account?",
                                            style: Font.base16),
                                        TextButton(
                                            onPressed: () =>
                                                Get.to(() => RegisterPage()),
                                            child: Text("Sigup",
                                                style: Font.red16))
                                      ])
                                ]),
                          )))
                ])));
  }

  Widget socialButton(IconData icon, var function, String text) {
    return FloatingActionButton(
        heroTag: text,
        backgroundColor: AppColor.custard,
        onPressed: () => function(),
        child: Icon(
          icon,
          color: AppColor.white,
        ));
  }
}
