import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/bottombar_controller.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final controller = Get.put(BottomBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text("Page 1"),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text("Page 2"),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text("Page 3"),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text("Page 4"),
            ),
          ],
        ),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 8.0)
            ],
          ),
          child: WaterDropNavBar(
            backgroundColor: AppColor.background,
            onItemSelected: (int index) {
              () => controller.changePage(index);

              controller.pageController.animateToPage(
                  controller.selectedPage ?? 0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuad);
            },
            selectedIndex: controller.selectedPage ?? 0,
            // nav bar items
            barItems: <BarItem>[
              BarItem(
                filledIcon: Icons.home_rounded,
                outlinedIcon: Icons.home_outlined,
              ),
              BarItem(
                  filledIcon: Icons.phone_android_rounded,
                  outlinedIcon: Icons.phone_android_outlined),
              BarItem(
                filledIcon: Icons.trending_flat_rounded,
                outlinedIcon: Icons.trending_flat_outlined,
              ),
              BarItem(
                  filledIcon: Icons.favorite_rounded,
                  outlinedIcon: Icons.favorite_border_rounded),
            ],
          ),
        ));
  }
}
