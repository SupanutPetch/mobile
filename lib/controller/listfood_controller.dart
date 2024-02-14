import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/model/food_mobel.dart';
import 'package:project_mobile/widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ListFoodController extends GetxController with StateMixin {
  MobileScannerController cameraController = MobileScannerController();
  RxList<FoodModel> foodData = <FoodModel>[].obs;
  final textSearch = TextEditingController();
  RxList<FoodModel> searchData = <FoodModel>[].obs;
  RxString scanCode = "".obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getdatafood();
    change(null, status: RxStatus.success());
    super.onInit();
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
      );
    }).toList());
    Get.isDialogOpen! ? Get.back : null;
    update();
  }

  qrDetect(BuildContext context, BarcodeCapture barcode) async {
    if (barcode.barcodes.isNotEmpty) {
      if (barcode.barcodes[0].rawValue != null) {
        cameraController.stop();
        await checkQrcode(context, barcode.barcodes[0].rawValue.toString());
      } else {
        return;
      }
    }
  }

  checkQrcode(BuildContext context, String codeRAW) {}
}
