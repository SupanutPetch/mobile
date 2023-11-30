import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  late PageController pageController;
  int? selectedPage;

  changePage(int index) {
    selectedPage = index;
    update();
  }
}
