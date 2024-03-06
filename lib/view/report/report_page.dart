import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/report/report_controller.dart';
import 'package:sizer/sizer.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.black,
        toolbarHeight: 0,
        bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: AppColor.orange,
            onTap: (index) => controller.changePage(index),
            controller: controller.controller,
            indicatorWeight: 1.5.sp,
            tabs: controller.myTabs),
      ),
      body: Padding(
          padding: EdgeInsets.all(2.h),
          child: Obx(() {
            return controller.pages[controller.selectedIndex.value];
          })),
    );
  }
}
