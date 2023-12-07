import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mobile/view/eating_page.dart';
import 'package:project_mobile/view/exercise_page.dart';
import 'package:project_mobile/view/goal_Page.dart';
import 'package:project_mobile/view/home_page.dart';
import 'package:project_mobile/view/profile_page.dart';

class BottomBarController extends GetxController {
  var selectedIndex = 2.obs;
  static const TextStyle fontBottomBar =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  final List<Widget> pages = [
    const ExercisePage(),
    const EatingPage(),
    HomePage(),
    const GoalPage(),
    ProfilePage()
  ].obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
