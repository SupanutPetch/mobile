import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  String? email;
  String? password;
  RxBool obscure = true.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatpassTextController = TextEditingController();

  showPassword() {
    obscure.value = !obscure.value;
    update();
  }

  signInwithEmail() async {
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty) {
      {
        await auth
            .signInWithEmailAndPassword(
                email: emailTextController.text.trim(),
                password: passwordTextController.text.trim())
            .then((value) {
          if (value.user!.emailVerified) {}
        });
      }
    }
  }

  signInWithGoogle() async {}
}
