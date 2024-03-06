import 'package:awesome_circular_chart/awesome_circular_chart.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/food/listfood_controller.dart';
import 'package:project_mobile/controller/goal_controller.dart';
import 'package:project_mobile/model/caleat_model.dart';
import 'package:sizer/sizer.dart';

import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/food/homefood_controller.dart';
import 'package:project_mobile/widget.dart';

class HomeFoodPage extends StatelessWidget {
  HomeFoodPage({super.key});
  final controller = Get.put(HomeFoodController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        displacement: 15.h,
        onRefresh: controller.onrefresh,
        color: AppColor.orange,
        child: controller.obx(
            (state) => Scaffold(
                backgroundColor: AppColor.black,
                body: SafeArea(
                    child: ListView(children: [
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("การรับประทานอาหาร", style: Font.white18B)),
                  Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            goalEat(),
                            eatfood(),
                          ])),
                  const Text("ประวัติการรับประทานอาหาร", style: Font.white18B),
                  Center(child: goalData()),
                  Obx(() => ListFoodController.calEat.isNotEmpty
                      ? Center(
                          child: Button.button(
                              "เพิ่มอาหาร", () => controller.gotolistfood()))
                      : SizedBox(height: 2.h))
                ]))),
            onLoading: Scaffold(
                backgroundColor: AppColor.black,
                body: Center(
                    child: LoadingAnimationWidget.threeRotatingDots(
                  color: AppColor.orange,
                  size: 100,
                )))));
  }

  Widget goalData() {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
            height: 50.h,
            width: 90.w,
            decoration: BoxDecoration(
                color: AppColor.platinum,
                borderRadius: BorderRadius.circular(20)),
            child: GetBuilder<ListFoodController>(
                init: ListFoodController(),
                initState: (data) {},
                builder: (data) {
                  return ListFoodController.calEat.isNotEmpty
                      ? listdata(ListFoodController.calEat)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const Icon(Icons.no_food, color: AppColor.orange),
                              SizedBox(height: 1.h),
                              const Text("วันนี้คุณยังไม่ได้รับประทานอาหาร",
                                  style: Font.black18),
                              SizedBox(height: 1.h),
                              Button.button("เพิ่มอาหาร",
                                  () => controller.gotolistfood()),
                            ]);
                })));
  }

  Widget listdata(List<CalEatModel> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Column(children: [
            ListTile(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("ชื่ออาหาร :", style: Font.black16),
                        Text("${list[index].food}", style: Font.black16)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("จำนวนแคลอรี่ :", style: Font.black16),
                        Text("${list[index].cal}", style: Font.black16)
                      ]),
                  const Divider(
                      color: AppColor.black, indent: 20, endIndent: 20)
                ]))
          ]);
        });
  }

  Widget eatfood() {
    return GoalController.goalData.isNotEmpty
        ? SizedBox(
            width: 170,
            height: 180,
            child: Obx(() => AnimatedCircularChart(
                  edgeStyle: SegmentEdgeStyle.round,
                  labelStyle: Font.white20B,
                  holeLabel: "${controller.calculateCelRemain()}",
                  size: const Size(180, 200),
                  initialChartData: controller.data().toList(),
                  chartType: CircularChartType.Radial,
                )))
        : const SizedBox();
  }

  Widget goalEat() {
    return GoalController.goalData.isNotEmpty
        ? SizedBox(
            width: 170,
            height: 170,
            child: Obx(() => AnimatedCircularChart(
                  edgeStyle: SegmentEdgeStyle.round,
                  labelStyle: Font.white20B,
                  holeLabel:
                      "เป้าหมาย \n${GoalController.goalData[0].goalCal}\n  แคลอรี่",
                  size: const Size(180, 180),
                  initialChartData: <CircularStackEntry>[
                    CircularStackEntry([
                      CircularSegmentEntry(
                          GoalController.goalData[0].goalCal! * 360 / 100,
                          AppColor.green),
                    ]),
                  ].obs,
                  chartType: CircularChartType.Radial,
                )))
        : const SizedBox();
  }
}
