import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/view/login_page.dart';
import 'package:project_mobile/widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
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
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Sign Up",
                style: Font.white20B,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Have a Account ?",
                  style: Font.white16,
                ),
                TextButton(
                    onPressed: () => Get.to(() => LoginPage()),
                    child: const Text(
                      "Sign In",
                      style: Font.white16B,
                    ))
              ],
            ),
            Textformfields.fieldBlank("Email", (FontAwesomeIcons.user)),
            Textformfields.fieldPassWord("PassWord", Icons.key, true, () {})
          ],
        ),
      )),
    );
  }
}
