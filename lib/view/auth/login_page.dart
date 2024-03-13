import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kitcal/widget.dart';
import 'package:sizer/sizer.dart';
import '../../controller/auth/login_controller.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/view/auth/register_page.dart';
import 'package:kitcal/view/auth/resetpass_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.black,
        body: SafeArea(
            key: loginController.formkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset("lib/asset/iconapp.jpg", scale: 0.15.h),
              const Text("ลงชื่อเข้าใช้งานบัญชีของคุณ", style: Font.white30B),
              SizedBox(height: 2.h),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textformfields.fieldBlank(
                            "อีเมล",
                            FontAwesomeIcons.envelope,
                            loginController.emailTextController,
                            AppColor.orange)
                      ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                GetX<LoginController>(
                    init: LoginController(),
                    initState: (_) {},
                    builder: (_) {
                      return Textformfields.fieldPassWord(
                          "รหัสผ่าน",
                          FontAwesomeIcons.lock,
                          _.obscure.value,
                          () => _.showPassword(),
                          loginController.passwordTextController,
                          true);
                    }),
                TextButton(
                    onPressed: () => Get.to(() => ResetPassPage()),
                    child: const Text("ลืมรหัสผ่าน?",
                        style: TextStyle(
                            color: AppColor.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)))
              ]),
              const SizedBox(height: 5),
              Button.buttonLong(
                  "เข้าสู่ระบบ", () => loginController.signInWithEmail()),
              Row(children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 50.0, right: 10.0),
                        child: const Divider(
                            color: AppColor.orange, height: 36, thickness: 2))),
                const Text("หรือ", style: Font.white18B),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 50.0),
                        child: const Divider(
                            color: AppColor.orange, height: 36, thickness: 2)))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Center(
                    child: SizedBox(
                        width: 15.w,
                        child: socialButton(FontAwesomeIcons.google,
                            () => loginController.signInWithGoogle(), "g"))),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("ยังไม่มีบัญชี?", style: Font.white18),
                TextButton(
                    onPressed: () => Get.to(() => RegisterPage()),
                    child: const Text("ลงทะเบียน",
                        style: TextStyle(
                            color: AppColor.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)))
              ])
            ])));
  }

  Widget socialButton(IconData icon, var function, String text) {
    return FloatingActionButton(
        heroTag: text,
        backgroundColor: AppColor.orange,
        onPressed: () => function(),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: AppColor.black),
        ]));
  }
}
