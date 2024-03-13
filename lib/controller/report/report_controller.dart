import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/view/report/calendar_page.dart';
import 'package:kitcal/view/report/graph_page.dart';

class ReportController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  var selectedIndex = 0.obs;

  final List<Tab> myTabs = <Tab>[
    const Tab(child: Text("ปฏิทิน", style: Font.white18)),
    const Tab(child: Text("กราฟ", style: Font.white18))
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    CalendarPage(),
    const GraphPage(),
  ];
}
