import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_mobile/view/login_page.dart';

class SettingMenuController extends GetxController {
  List titles = [].obs;
  List icon = [].obs;

  @override
  void onInit() async {
    super.onInit();
    await getmenu();
  }

  getmenu() {
    titles.add("Change Language");
    icon.add(Icons.language);
    titles.add("Sign out");
    icon.add(FontAwesomeIcons.arrowRightFromBracket);
    update();
  }

  tabMenu(titles) {
    switch (titles) {
      case "Change Language":
        () {};
      case "Sign out":
        Get.to(() => LoginPage());
    }
  }
}
