import 'dart:async';

import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/controller/goal_controller.dart';
import 'package:project_mobile/model/calexecise_model.dart';
import 'package:project_mobile/model/exercise_model.dart';
import 'package:project_mobile/view/exercise/listposes_page.dart';
import 'package:project_mobile/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sizer/sizer.dart';

class ExerciseController extends GetxController with StateMixin {
  var data = <CircularStackEntry>[].obs;
  RxList<ExerciseModel> exercideData = <ExerciseModel>[].obs;
  RxList<ExerciseModel> searchData = <ExerciseModel>[].obs;
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
  static RxInt totelCalBurn = 0.obs;
  final RxInt currentPage = 0.obs;
  late Timer pageTimer;
  final Duration pageChangeDuration = const Duration(seconds: 5);
  final PageController pageController = PageController(viewportFraction: 1);
  static RxList<CalExeciseModel> calExecise = <CalExeciseModel>[].obs;
  RxList<CalExeciseModel> recommend = <CalExeciseModel>[].obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getExerciseData();
    await getdata();
    await getExerciseDaily();
    startAutoPageChange();
    change(null, status: RxStatus.success());
    super.onInit();
    Timer.periodic(const Duration(seconds: 5), (_) => getdata());
    update();
  }

  @override
  void dispose() {
    pageTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  addExerciseDaily(int index, ExerciseModel data) async {
    if (calExecise.isNotEmpty) {
      calExecise[0].date != DateFormat('MMddyyyy').format(DateTime.now())
          ? calExecise.clear()
          : null;
    }
    calExecise.add(CalExeciseModel(
        poses: data.nameExercise,
        burn: data.calExercise,
        date: DateFormat('MMddyyyy').format(DateTime.now())));
    totelCalBurn.value = calExecise
        .map((e) => int.parse(e.burn!))
        .reduce((value, element) => value + element);
    await GetData.firestore
        .collection("UserData")
        .doc(GetData.auth.currentUser!.uid)
        .collection("ExerciseDaily")
        .doc()
        .set({
      "poses": data.nameExercise,
      "burn": data.calExercise,
      "date": DateFormat('MMddyyyy').format(DateTime.now())
    });
    update();
    Get.back(result: true);
  }

  getExerciseDaily() async {
    QuerySnapshot querySnapshot = await GetData.firestore
        .collection("UserData")
        .doc(GetData.auth.currentUser!.uid)
        .collection("ExerciseDaily")
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    calExecise.assignAll(docs.map((data) {
      if (data["date"] == DateFormat('MMddyyyy').format(DateTime.now())) {
        return CalExeciseModel(
            poses: data['poses'], burn: data['burn'], date: data['date']);
      } else {
        return null;
      }
    }).whereType<CalExeciseModel>());
    if (calExecise.isNotEmpty) {
      totelCalBurn.value = calExecise
          .map((e) => int.parse(e.burn!))
          .reduce((value, element) => value + element);
      update();
    }
  }

  void startAutoPageChange() {
    pageTimer = Timer.periodic(pageChangeDuration, (_) {
      if (pageController.page == null) return;
      final nextPage = (pageController.page!.toInt() + 1) % 2;
      pageController.animateToPage(nextPage,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
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
      return ExerciseModel(
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

  viewDetail() {
    return AlertDialog(
        backgroundColor: AppColor.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: 50.h,
            width: 60.w,
            child: const Column(
              children: [],
            )));
  }

  calculateCelRemain() {
    if (ExerciseController.totelCalBurn.value != 0 &&
        GoalController.goalData[0].goalBurn != 0.0) {
      var totelCal =
          double.parse(ExerciseController.totelCalBurn.value.toString());
      var goal = GoalController.goalData[0].goalBurn!;
      var result = goal - totelCal;
      if (result <= 0) {
        var totel = result * -1;
        return "ปริมาณที่เกิน\n   ${totel.toStringAsFixed(2)}\n   แคลอรี่";
      } else {
        return "   คงเหลือ\n   ${result.toStringAsFixed(2)}\n   แคลอรี่";
      }
    } else {
      return "  คงเหลือ\n ${GoalController.goalData[0].goalBurn}\n   แคลอรี่";
    }
  }

  getdata() async {
    if (GoalController.goalData.isNotEmpty) {
      data.value = <CircularStackEntry>[
        CircularStackEntry([
          CircularSegmentEntry(
              (100 - ExerciseController.totelCalBurn.value.toDouble()) *
                  360 /
                  100,
              checkcolor()),
          CircularSegmentEntry(GoalController.goalData[0].goalBurn! * 360 / 100,
              AppColor.platinum)
        ]),
      ].obs;
      Get.forceAppUpdate();
    }
  }

  Color checkcolor() {
    if (ExerciseController.totelCalBurn.value == 0.0) {
      return AppColor.platinum;
    } else if ((100 - ExerciseController.totelCalBurn.value.toDouble()) *
            360 /
            100 >
        GoalController.goalData[0].goalBurn! * 360 / 100) {
      return Colors.redAccent;
    } else {
      return AppColor.green;
    }
  }

  gotolistExecise() {
    Get.to(() => ListPosesPage())!.then((value) {
      if (value == true) {
        Get.forceAppUpdate();
        update();
      }
    });
  }
}
