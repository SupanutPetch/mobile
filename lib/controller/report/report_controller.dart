import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/view/report/calendar_page.dart';
import 'package:project_mobile/view/report/graph_page.dart';

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
    const CalenderPage(),
    const GraphPage(),
  ];
}
