import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d_chart/d_chart.dart';
import 'package:kitcal/constant/color.dart';

class GraphController extends GetxController with StateMixin {
  var graphData = [].obs;
  List<OrdinalData> ordinalDataList = [
    OrdinalData(domain: 'unsuccessful', measure: 3, color: Colors.redAccent),
    OrdinalData(domain: 'succeed', measure: 5, color: AppColor.green),
  ].obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getdata();

    change(null, status: RxStatus.success());
    super.onInit();
    update();
  }

  getdata() {
    // graphData.value = [
    //   const FlSpot(0, 10),
    //   const FlSpot(1, 20),
    //   const FlSpot(2, 30),
    //   const FlSpot(3, 40),
    //   const FlSpot(4, 50)
    // ];
    update();
  }
}
