import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kitcal/constant/color.dart';

import 'package:kitcal/controller/basic_controller.dart';
import 'package:kitcal/model/user_model.dart';
import 'package:kitcal/view/auth/login_page.dart';
import 'package:kitcal/widget.dart';

class ProfileController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;
  final picker = ImagePicker();
  String gender = "man";
  final namecontroller = TextEditingController();
  final mailcontroller = TextEditingController();
  final weightcontroller = TextEditingController();
  final heightcontroller = TextEditingController();

  final RxString urlImg = ''.obs;
  RxInt selectedRadio = 0.obs;
  var selectActivity = "ทำงานแบบนั่งอยู่กับที่".obs;
  final List<String> activityLevel = [
    "ทำงานแบบนั่งอยู่กับที่",
    "ออกกำลังกาย 1-3 วันต่อสัปดาห์",
    "ออกกำลังกายปานกลาง 3-5 วันต่อสัปดาห์",
    "ออกกำลังกายหนัก 6-7 วันต่อสัปดาห์",
    "นักกีฬา"
  ];

  @override
  void onInit() async {
    await chackDataUser();
    namecontroller.text = GetData.userData[0].userName!;
    super.onInit();
  }

  changeActivity(String value) {
    selectActivity.value = value;
  }

  chackDataUser() async {
    if (GetData.userData.isEmpty) {
      await GetData.getdata();
      update();
    }
  }

  changeIMG() async {
    Get.dialog(WidgetAll.loading());
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    if (result != null) {
      final fileBytes = result.files.single.bytes!;
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      try {
        await storage
            .ref(
                '${auth.currentUser!.uid}/images/$imageName.${result.files.single.extension}')
            .putData(fileBytes);
        urlImg.value = await storage
            .ref(
                '${auth.currentUser!.uid}/images/$imageName.${result.files.single.extension}')
            .getDownloadURL();
        update();
        Get.isDialogOpen! ? Get.back() : null;
        Get.dialog(WidgetAll.dialog(
            FontAwesomeIcons.check, "Upload Image succeed", AppColor.green));
      } catch (e) {
        Get.isDialogOpen! ? Get.back() : null;
        Get.dialog(WidgetAll.dialog(FontAwesomeIcons.xmark, "$e", Colors.red));
      }
    } else {
      Get.back();
    }
  }

  editProfile() async {
    if (namecontroller.text.isNotEmpty && mailcontroller.text.isNotEmpty) {
      await firestore.collection("UserData").doc(auth.currentUser!.uid).update({
        "userName": namecontroller.text,
        "userEmail": mailcontroller.text,
        "userImageURL": urlImg.value
      });
      await auth.currentUser!.updateDisplayName(namecontroller.text);
      firestore
          .collection("UserData")
          .doc(auth.currentUser!.uid)
          .snapshots()
          .listen((DocumentSnapshot snapshot) {
        Map<String, dynamic> newData = snapshot.data() as Map<String, dynamic>;
        List<UserModel> updatedData = [
          UserModel(
              userID: newData['userID'],
              userEmail: newData["userEmail"],
              userName: newData["userName"],
              userBirthDay: newData["userBirthDay"],
              userGender: newData["userGender"],
              userImageURL: newData["userImageURL"],
              userType: newData["userType"],
              userHigh: newData["userHigh"],
              userWeight: newData["userWeight"],
              userActivity: newData["userActivity"])
        ];
        GetData().updateUserData(updatedData);
        update();
      });
    }
    Get.back();
  }

  siginout() async {
    await auth.signOut();
    Get.off(() => LoginPage());
  }

  void setSelectedGender(int value) {
    selectedRadio.value = value;
    if (selectedRadio.value == 0) {
      gender = "male";
    } else {
      gender = "female";
    }
  }
}
