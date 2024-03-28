import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kitcal/controller/basic_controller.dart';
import 'package:kitcal/controller/food/homefood_controller.dart';
import 'package:kitcal/controller/food/myfood_controller.dart';
import 'package:kitcal/model/caleat_model.dart';
import 'package:kitcal/model/food_model.dart';
import 'package:kitcal/view/eating/myfood_page.dart';
import 'package:kitcal/widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ListFoodController extends GetxController with StateMixin {
  final controller = Get.put(MyMenuController());
  MobileScannerController cameraController = MobileScannerController();
  RxList<FoodModel> foodData = <FoodModel>[].obs;
  final textSearch = TextEditingController();
  RxList<FoodModel> searchData = <FoodModel>[].obs;
  RxList<FoodModel> listData = <FoodModel>[].obs;
  RxString scanCode = "".obs;
  RxBool allmenu = true.obs;
  RxBool food = false.obs;
  RxBool drink = false.obs;
  RxBool fruit = false.obs;
  RxBool snacks = false.obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getdatafood();

    change(null, status: RxStatus.success());
    super.onInit();
    update();
  }

  addfooditem(int index, FoodModel foodModel) async {
    if (HomeFoodController.calEat.isNotEmpty) {
      HomeFoodController.calEat[0].date !=
              DateFormat('MMddyyyy').format(DateTime.now())
          ? HomeFoodController.calEat.clear()
          : null;
    }
    HomeFoodController.calEat.add(CalEatModel(
        food: foodModel.foodName,
        cal: foodModel.foodCal,
        date: DateFormat('MMddyyyy').format(DateTime.now())));
    HomeFoodController.totelCalEat.value = HomeFoodController.calEat
        .map((e) => int.parse(e.cal!))
        .reduce((value, element) => value + element);
    await GetData.firestore
        .collection("UserData")
        .doc(GetData.auth.currentUser!.uid)
        .collection("EatDaily")
        .doc()
        .set({
      "food": foodModel.foodName,
      "cal": foodModel.foodCal,
      "date": DateFormat('MMddyyyy').format(DateTime.now())
    });
    update();
    Get.back(result: true);
  }

  selectCategory(String titel) {
    listData.clear();
    switch (titel) {
      case 'ทั้งหมด':
        allmenu.value = true;
        food.value = false;
        drink.value = false;
        fruit.value = false;
        snacks.value = false;
        for (var data in foodData) {
          listData.add(data);
          update();
        }
        break;
      case 'อาหาร':
        allmenu.value = false;
        food.value = true;
        drink.value = false;
        fruit.value = false;
        snacks.value = false;
        for (var data in foodData) {
          if (data.foodCategory!.contains('อาหาร')) {
            listData.add(data);
            update();
          }
        }
        break;
      case 'เครื่องดื่ม':
        allmenu.value = false;
        food.value = false;
        drink.value = true;
        fruit.value = false;
        snacks.value = false;
        for (var data in foodData) {
          if (data.foodCategory!.contains('เครื่องดื่ม')) {
            listData.add(data);
            update();
          }
        }
        break;
      case 'ผลไม้':
        allmenu.value = false;
        food.value = false;
        drink.value = false;
        fruit.value = true;
        snacks.value = false;
        for (var data in foodData) {
          if (data.foodCategory!.contains('ผลไม้')) {
            listData.add(data);
            update();
          }
        }
        break;
      case 'ทานเล่น':
        allmenu.value = false;
        food.value = false;
        drink.value = false;
        fruit.value = false;
        snacks.value = true;
        for (var data in foodData) {
          if (data.foodCategory!.contains('ของทานเล่น')) {
            listData.add(data);
            update();
          }
        }
        break;
    }
  }

  void search(String query) {
    searchData.clear();
    for (var food in foodData) {
      if (food.foodName!.toLowerCase().contains(query.toLowerCase()) ||
          food.foodCategory!.toLowerCase().contains(query.toLowerCase())) {
        searchData.add(food);
        update();
      }
    }
  }

  getdatafood() async {
    WidgetAll.loading();
    QuerySnapshot querySnapshot =
        await GetData.firestore.collection("FoodData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    foodData.assignAll(docs.map((data) {
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
    for (var data in foodData) {
      listData.add(data);
    }
    update();
  }

  qrDetect(BuildContext context, BarcodeCapture barcode) async {
    if (barcode.barcodes.isNotEmpty) {
      if (barcode.barcodes[0].rawValue != null) {
        scanCode.value = barcode.barcodes[0].rawValue.toString();
        cameraController.stop();
        await checkQrcode();
      } else {
        return;
      }
    }
  }

  checkQrcode() async {
    for (var food in foodData) {
      if (food.foodBarcode!
          .toLowerCase()
          .contains(scanCode.value.toLowerCase())) {
        if (HomeFoodController.calEat.isNotEmpty) {
          HomeFoodController.calEat[0].date !=
                  DateFormat('MMddyyyy').format(DateTime.now())
              ? HomeFoodController.calEat.clear()
              : null;
        }
        HomeFoodController.calEat.add(CalEatModel(
            food: food.foodName,
            cal: food.foodCal,
            date: DateFormat('MMddyyyy').format(DateTime.now())));
        HomeFoodController.totelCalEat.value = HomeFoodController.calEat
            .map((e) => int.parse(e.cal!))
            .reduce((value, element) => value + element);
        await GetData.firestore
            .collection("UserData")
            .doc(GetData.auth.currentUser!.uid)
            .collection("EatDaily")
            .doc()
            .set({
          "food": food.foodName,
          "cal": food.foodCal,
          "date": DateFormat('MMddyyyy').format(DateTime.now())
        });
        update();
        Get.back(result: true);
        update();
      }
    }
    for (var food in controller.myfood) {
      if (food.foodBarcode!
          .toLowerCase()
          .contains(scanCode.value.toLowerCase())) {
        if (HomeFoodController.calEat.isNotEmpty) {
          HomeFoodController.calEat[0].date !=
                  DateFormat('MMddyyyy').format(DateTime.now())
              ? HomeFoodController.calEat.clear()
              : null;
        }
        HomeFoodController.calEat.add(CalEatModel(
            food: food.foodName,
            cal: food.foodCal,
            date: DateFormat('MMddyyyy').format(DateTime.now())));
        HomeFoodController.totelCalEat.value = HomeFoodController.calEat
            .map((e) => int.parse(e.cal!))
            .reduce((value, element) => value + element);
        await GetData.firestore
            .collection("UserData")
            .doc(GetData.auth.currentUser!.uid)
            .collection("EatDaily")
            .doc()
            .set({
          "food": food.foodName,
          "cal": food.foodCal,
          "date": DateFormat('MMddyyyy').format(DateTime.now())
        });
        update();
        Get.back(result: true);
        update();
      }
    }
  }
}
