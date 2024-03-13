import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/view/eating/listfood_page.dart';
import 'package:kitcal/view/eating/myfood_page.dart';

class NavigationBarController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  var selectedIndex = 0.obs;
  static const TextStyle fontBottomBar =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  final List<Tab> myTabs = <Tab>[
    const Tab(child: Text("ListMenu", style: Font.white18)),
    const Tab(child: Text("MyMenu", style: Font.white18)),
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
    ListFoodPage(),
    MyFoodPage(),
  ];
}
