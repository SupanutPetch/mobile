import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/controller/food/listfood_controller.dart';
import 'package:project_mobile/model/caleat_model.dart';
import 'package:project_mobile/model/food_model.dart';
import 'package:project_mobile/widget.dart';

class MyMenuController extends GetxController with StateMixin {
  RxList<FoodModel> myfood = <FoodModel>[].obs;
  RxList<FoodModel> searchData = <FoodModel>[].obs;
  final textSearch = TextEditingController();
  final foodCal = TextEditingController();
  final foodName = TextEditingController();
  final foodBarcode = TextEditingController();
  final foodQuantity = TextEditingController();
  final foodMash0 = TextEditingController();
  final foodMash1 = TextEditingController();
  final foodMash2 = TextEditingController();
  final foodMash3 = TextEditingController();
  final foodMash4 = TextEditingController();
  final foodMash5 = TextEditingController();
  final foodMash6 = TextEditingController();
  final foodMash7 = TextEditingController();
  final foodMash8 = TextEditingController();
  final foodMash9 = TextEditingController();
  RxBool material = false.obs;
  final List<String> foodCategory = [
    "อาหาร",
    "เครื่องดื่ม",
    "ผลไม้",
    "ของทานเล่น"
  ];
  List docid = [];

  var selectCategory = "อาหาร".obs;
  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getdatafood();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  addfooditem(int index, FoodModel foodModel) async {
    ListFoodController.calEat.add(CalEatModel(
        food: foodModel.foodName,
        cal: foodModel.foodCal,
        date: DateFormat('MMddyyyy').format(DateTime.now())));
  }

  checkMaterial(bool value) {
    material.value = value;
    update();
  }

  changeCategory(String value) {
    selectCategory.value = value;
  }

  void search(String query) {
    searchData.clear();
    for (var food in myfood) {
      if (food.foodName!.toLowerCase().contains(query.toLowerCase()) ||
          food.foodCategory!.toLowerCase().contains(query.toLowerCase())) {
        searchData.add(food);
        update();
      }
    }
  }

  getdatafood() async {
    WidgetAll.loading();
    QuerySnapshot querySnapshot = await GetData.firestore
        .collection("UserData")
        .doc(GetData.auth.currentUser!.uid)
        .collection("MyFood")
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    docid = querySnapshot.docs.map((doc) => doc.id).toList();
    myfood.assignAll(docs.map((data) {
      return FoodModel(
        foodName: data["foodName"],
        foodCategory: data["foodCategory"],
        foodQuantity: data["foodQuantity"],
        foodCal: data["foodCal"],
        foodBarcode: data["foodBarcode"],
        foodMash0: "",
        foodMash1: "",
        foodMash2: "",
        foodMash3: "",
        foodMash4: "",
        foodMash5: "",
        foodMash6: "",
        foodMash7: "",
        foodMash8: "",
        foodMash9: "",
      );
    }).toList());
    Get.isDialogOpen! ? Get.back : null;
    update();
  }

  addFood() async {
    if (foodName.text.isNotEmpty &&
        foodQuantity.text.isNotEmpty &&
        foodCal.text.isNotEmpty) {
      if (foodBarcode.text.isEmpty) {
        foodBarcode.text = "";
      } else {}
      await GetData.firestore
          .collection("UserData")
          .doc(GetData.auth.currentUser!.uid)
          .collection("MyFood")
          .doc()
          .set({
        "foodCategory": selectCategory.value,
        "foodName": foodName.text,
        "foodQuantity": foodQuantity.text,
        "foodCal": foodCal.text,
        "foodBarcode": foodBarcode.text,
        "foodMash0": "",
        "foodMash1": "",
        "foodMash2": "",
        "foodMash3": "",
        "foodMash4": "",
        "foodMash5": "",
        "foodMash6": "",
        "foodMash7": "",
        "foodMash8": "",
        "foodMash9": "",
      });
      Get.dialog(WidgetAll.dialog(
          FontAwesomeIcons.check, "Add Menu succeed", AppColor.green));
      foodName.clear();
      foodQuantity.clear();
      foodCal.clear();
      foodBarcode.clear();
      await getdatafood();
      Get.back();
    } else {
      Get.dialog(
          WidgetAll.dialog(FontAwesomeIcons.triangleExclamation,
              "Data Not Empty", AppColor.orange),
          barrierDismissible: false);
    }
  }

  deleteMenu(int index) async {
    myfood.removeAt(index);
    myfood.refresh();
    await GetData.firestore
        .collection("UserData")
        .doc(GetData.auth.currentUser!.uid)
        .collection("MyFood")
        .doc(docid[index])
        .delete();
    update();
  }
}
