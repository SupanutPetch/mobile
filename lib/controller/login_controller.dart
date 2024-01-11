import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_mobile/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_mobile/view/home/bottombar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_mobile/model/user_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginController extends GetxController {
  RxList<UserModel> userData = <UserModel>[].obs;
  RxBool obscure = true.obs;
  final auth = FirebaseAuth.instance;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatpassTextController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  GoogleSignInAccount? googleUser;
  GoogleSignInAuthentication? googleAuth;
  final GoogleSignIn googleSigIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  showPassword() {
    obscure.value = !obscure.value;
    update();
  }

  signInWithEmail() async {
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty) {
      Get.dialog(WidgetAll.loading());
      try {
        await auth
            .signInWithEmailAndPassword(
                email: emailTextController.text.trim(),
                password: passwordTextController.text.trim())
            .then((user) {
          if (Get.isDialogOpen!) {
            Get.back();
            Get.close(0);
          }
          getAccountData();
          Get.to(() => const BottomBar());
          Get.dialog(WidgetAll.dialog(FontAwesomeIcons.check,
              "Welcome ${auth.currentUser!.email}", Colors.green));
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
      Get.dialog(
          WidgetAll.dialogWithButton(FontAwesomeIcons.triangleExclamation,
              "Please Enter Email&Password", () => Get.back(), "Close"),
          barrierDismissible: false);
    }
  }

  signInWithGoogle() async {
    googleUser = await GoogleSignIn().signIn();
    googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);

    Get.to(const BottomBar());
  }

  getAccountData() async {
    DocumentSnapshot userExists =
        await firestore.collection('UserData').doc(auth.currentUser!.uid).get();
    if (userExists.exists) {
      Map<String, dynamic> data = userExists.data() as Map<String, dynamic>;
      userData.add(UserModel(
          userID: data['userID'],
          userEmail: data["userEmail"],
          userName: data["userName"],
          userBirthDay: data["userBirthDay"],
          userGender: data["userGender"],
          userImageURL: data["userImageURL"]));
    } else {
      await firestore.collection("UserData").doc(auth.currentUser!.uid).set({
        'userID': auth.currentUser!.uid,
        'userEmail': auth.currentUser!.email,
        'userName': auth.currentUser!.displayName,
        'userBirthDay': "",
        'userGender': "",
        'userImageURL': auth.currentUser!.photoURL
      });
    }
  }
}
