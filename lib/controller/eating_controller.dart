import 'dart:ffi';

import 'package:get/get.dart';
import 'package:project_mobile/view/eating/breakfast_page.dart';
import 'package:project_mobile/widget.dart';

class EatingController extends GetxController {
  gotoDetail(String title) {
    switch (title) {
      case "Breakfast":
        WidgetAll.loading();
        Get.to(() => const BreakfastPage());
        if (Get.isDialogOpen!) {
          Get.back();
        }
        break;
      case "Lunch":
        break;
      case "Dinner":
        break;
      default:
        null;
    }
  }
}
