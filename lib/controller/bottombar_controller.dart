import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitcal/view/home/homefood_page.dart';
import 'package:kitcal/view/home/exercise_page.dart';

import 'package:kitcal/view/home/home_page.dart';
import 'package:kitcal/view/home/profile_page.dart';
import '../view/home/goal_page.dart';

class BottomBarController extends GetxController with StateMixin {
  final selectedIndex = 2.obs;
  static const TextStyle fontBottomBar =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  void changePage(int index) {
    if (index >= 0 && index < pages.length) {
      selectedIndex.value = index;
    }
  }

  final List<Widget> pages = <Widget>[
    ExercisePage(),
    HomeFoodPage(),
    HomePage(),
    GoalPage(),
    ProfilePage()
  ].obs;
}
