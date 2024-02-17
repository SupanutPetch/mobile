import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/model/exercise_mobel.dart';
import 'package:project_mobile/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ExerciseController extends GetxController with StateMixin {
  var exercideData = <ExerciseMobel>[].obs;
  RxList<ExerciseMobel> searchData = <ExerciseMobel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;
  final namecontroller = TextEditingController();
  final detailcontroller = TextEditingController();
  final caloriecontroller = TextEditingController();
  final benefitcontroller = TextEditingController();
  final setortimecontroller = TextEditingController();
  RxString imagesName = RxString("Upload Images");
  RxString videoName = RxString("Upload Video");
  String? imgUrl;
  String? vdoUrl;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getExerciseData();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void search(String query) {
    searchData.clear();
    for (var data in exercideData) {
      if (data.nameExercise!.toLowerCase().contains(query.toLowerCase()) ||
          data.benefitsExercise!.toLowerCase().contains(query.toLowerCase())) {
        searchData.add(data);
      }
    }
  }

  Future<void> getExerciseData() async {
    QuerySnapshot querySnapshot =
        await firestore.collection("ExerciseData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    exercideData.assignAll(docs.map((data) {
      return ExerciseMobel(
        nameExercise: data["nameExercise"],
        calExercise: data["calExercise"],
        detailExercise: data["detailExercise"],
        benefitsExercise: data["benefitsExercise"],
        setORtimeExercise: data["setORtimeExercise"],
        imgExercise: data["imgExercise"],
        vdoExercise: data["vdoExercise"],
      );
    }).toList());
  }

  addExercise() async {
    Get.dialog(WidgetAll.loading());
    if (namecontroller.text.isNotEmpty &&
        detailcontroller.text.isNotEmpty &&
        caloriecontroller.text.isNotEmpty &&
        benefitcontroller.text.isNotEmpty &&
        setortimecontroller.text.isNotEmpty &&
        imgUrl!.isNotEmpty &&
        vdoUrl!.isNotEmpty) {
      await firestore.collection("ExerciseData").doc().set({
        'nameExercise': namecontroller.text,
        'detailExercise': detailcontroller.text,
        'calExercise': caloriecontroller.text,
        'benefitsExercise': benefitcontroller.text,
        'setORtimeExercise': setortimecontroller.text,
        'imgExercise': imgUrl,
        'vdoExercise': vdoUrl
      });
      namecontroller.clear();
      detailcontroller.clear();
      caloriecontroller.clear();
      benefitcontroller.clear();
      setortimecontroller.clear();
      imagesName.value = "Upload Images";
      videoName.value = "Upload Video";
      await getExerciseData();
      Get.isDialogOpen! ? Get.back() : null;
      Get.dialog(WidgetAll.dialog(
          FontAwesomeIcons.check, "Add Exercise Succeed", AppColor.green));
    } else {
      Get.isDialogOpen! ? Get.back() : null;
      Get.dialog(
          WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
              "Data Not Empty", AppColor.orange),
          barrierDismissible: false);
    }
  }
}
