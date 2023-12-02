import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/bottombar_controller.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomBarController());
    return Scaffold(
        body: Obx(() => controller.pages[controller.selectedIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.background,
            selectedItemColor: AppColor.custard,
            selectedLabelStyle: Font.base16B,
            unselectedItemColor: AppColor.white,
            elevation: 0,
            showUnselectedLabels: false,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.dumbbell), label: 'Exercise'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant_menu), label: 'Eating'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.houseChimney), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Goal'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.userTie), label: 'Profile'),
            ],
          ),
        ));
  }
}
