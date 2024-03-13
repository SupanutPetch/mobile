import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kitcal/view/auth/login_page.dart';
import 'package:kitcal/widget.dart';

class ResetPasswordController extends GetxController {
  final emailTextController = TextEditingController();
  final auth = FirebaseAuth.instance;
  sentMailReset() async {
    if (emailTextController.text.trim().isNotEmpty) {
      Get.dialog(WidgetAll.loading());
      try {
        await auth
            .sendPasswordResetEmail(email: emailTextController.text.trim())
            .then((value) {
          if (Get.isDialogOpen!) {
            Get.back();
            Get.close(0);
          }
          Get.to(() => LoginPage());
          Get.dialog(WidgetAll.dialog(
              FontAwesomeIcons.check, "Succeed", Colors.green));
        });
      } on FirebaseAuthException catch (error) {
        Get.isDialogOpen! ? Get.back() : null;
        switch (error.code) {
          case "invalid-email":
            Get.dialog(
                WidgetAll.dialogWithButton(FontAwesomeIcons.triangleExclamation,
                    "invalid email", () => Get.back(), "Close"),
                barrierDismissible: false);
            break;
          case "INVALID_LOGIN_CREDENTIALS":
            Get.dialog(
                WidgetAll.dialogWithButton(
                    FontAwesomeIcons.triangleExclamation,
                    "please check your email and password",
                    () => Get.back(),
                    "Close"),
                barrierDismissible: false);
            break;
          default:
            Get.dialog(
                WidgetAll.dialogWithButton(FontAwesomeIcons.triangleExclamation,
                    "can't signin", () => Get.back(), "Close"),
                barrierDismissible: false);
        }
      }
    } else {
      await Get.dialog(WidgetAll.dialogWithButton(
          FontAwesomeIcons.triangleExclamation,
          "Plase Enter your Email".tr,
          () => Get.back(),
          "Close"));
    }
  }
}
