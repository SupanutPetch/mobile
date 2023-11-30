import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  RxBool obscure = true.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final passwordTextController = TextEditingController();
  String email = "";
  String password = "";

  showPassword() {
    obscure.value = !obscure.value;
    update();
  }

  signInwithEmail() {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((date) => () {});
  }

  signInWithGoogle() async {}
}
