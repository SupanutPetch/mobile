import 'package:flutter/material.dart';
import 'package:project_mobile/constant/font.dart';

import '../widget.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/setting/settingmenu_controller.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final controller = Get.put(SettingMenuController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetAll.appbar(),
        backgroundColor: AppColor.background,
        body: Obx(() => ListView.builder(
            itemCount: controller.titles.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.cream,
                      border: Border.all(width: 2, color: AppColor.custard),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(controller.icon[index]),
                    iconColor: AppColor.background,
                    title: Text(controller.titles[index]),
                    titleTextStyle: Font.base18B,
                    onTap: () => controller.tabMenu(controller.titles[index]),
                  ),
                ),
              );
            }))));
  }
}