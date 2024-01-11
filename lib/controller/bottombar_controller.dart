import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mobile/view/home/meals_page.dart';
import 'package:project_mobile/view/home/exercise_page.dart';

import 'package:project_mobile/view/home/home_page.dart';
import 'package:project_mobile/view/home/profile_page.dart';
import '../view/home/goal_page.dart';

class BottomBarController extends GetxController {
  var selectedIndex = 2.obs;
  static const TextStyle fontBottomBar =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  final List<Widget> pages = [
    const ExercisePage(),
    const MealsPage(),
    HomePage(),
    const GoalPage(),
    ProfilePage()
  ].obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
