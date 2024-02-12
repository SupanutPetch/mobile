import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/widget.dart';

class RegisterController extends GetxController {
  RxBool obscure = true.obs;
  RxInt selectedRadio = 0.obs;
  String gender = "";
  final auth = FirebaseAuth.instance;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final calendarTextController = TextEditingController();
  final repeatpassTextController = TextEditingController();
  final userNameTextController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());

  signUp() async {
    if (emailTextController.text.isNotEmpty &&
        checkPassword() == true &&
        selectedDate.value != DateTime.now()) {
      try {
        await auth
            .createUserWithEmailAndPassword(
                email: emailTextController.text,
                password: repeatpassTextController.text)
            .then((value) {
          if (value.user!.emailVerified) {
            Get.dialog(WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
                "Email is Verified", AppColor.orange));
          } else {
            firestore.collection("UserData").doc(value.user!.uid).set({
              "userBirthDay": DateFormat('MMddyyyy').format(selectedDate.value),
              "userEmail": emailTextController.text,
              "userGender": gender,
              "userID": value.user!.uid,
              "userImageURL": "",
              "userName": userNameTextController.text,
              "userType": "n"
            });
          }
        });
      } on FirebaseAuthException catch (error) {
        debugPrint(error.toString());
      }
    }
  }

  checkPassword() {
    if (passwordTextController.text.isNotEmpty &&
        repeatpassTextController.text.isNotEmpty &&
        passwordTextController.text == repeatpassTextController.text) {
      return true;
    }
    Get.dialog(WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
        "please check your Password", AppColor.orange));
    return false;
  }

  void setSelectedGender(int value) {
    selectedRadio.value = value;
    if (selectedRadio.value == 0) {
      gender = "man";
    } else {
      gender = "woman";
    }
  }

  showPassword() {
    obscure.value = !obscure.value;
    update();
  }

  void selectDate(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          decoration: const BoxDecoration(color: AppColor.platinum),
          child: Column(
            children: [
              Expanded(
                  child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate.value,
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate.value = newDate;
                },
              )),
              CupertinoButton(
                  child: const Text("Done"), onPressed: () => Get.back()),
            ],
          ),
        );
      },
    );
  }
}
