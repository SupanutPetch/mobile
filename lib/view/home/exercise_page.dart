import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/exercise/exercise_controller.dart';
import 'package:project_mobile/controller/goal_controller.dart';
import 'package:project_mobile/model/calexecise_model.dart';
import 'package:project_mobile/view/exercise/listposes_page.dart';
import 'package:project_mobile/widget.dart';
import 'package:sizer/sizer.dart';

class ExercisePage extends StatelessWidget {
  ExercisePage({super.key});
  final controller = Get.put(ExerciseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          const Text("การออกกำลังกาย", style: Font.white18B),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Obx(() => goalBurn()), Obx(() => exercise())]),
          SizedBox(height: 2.h),
          const Text("ประวัติการออกกำลังกาย / ท่าออกกำลังกายที่แนะนำ",
              style: Font.white18),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Container(
                    width: 100.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.platinum),
                    child: GetBuilder<ExerciseController>(
                        init: ExerciseController(),
                        initState: (data) {},
                        builder: (data) {
                          return ExerciseController.calExecise.isNotEmpty
                              ? listdata(ExerciseController.calExecise)
                              : Center(
                                  child: Column(children: [
                                  SizedBox(height: 5.h),
                                  const Icon(FontAwesomeIcons.xmark,
                                      color: AppColor.orange),
                                  SizedBox(height: 1.h),
                                  const Text("วันนี้คุณยังไม่ได้ออกกำลังกาย",
                                      style: Font.black18),
                                  SizedBox(height: 1.h),
                                  Button.button("เพิ่มการออกกำลังกาย",
                                      () => controller.gotolistExecise())
                                ]));
                        })),
                SizedBox(width: 2.w),
                Container(
                    width: 100.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.platinum),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("ท่าออกกำลังกายท่าแนะนำ",
                                  style: Font.black18B)),
                          controller.recommend.isNotEmpty
                              ? const SizedBox()
                              : Center(
                                  child: Column(children: [
                                  SizedBox(height: 5.h),
                                  const Icon(FontAwesomeIcons.xmark,
                                      color: AppColor.orange),
                                  SizedBox(height: 1.h),
                                  const Text("ไม่สามารถแสดงข้อมูลได้",
                                      style: Font.black18)
                                ]))
                        ]))
              ])),
          Obx(() => ExerciseController.calExecise.isNotEmpty
              ? Button.buttonwithicon(
                  "เพิ่มการออกกำลังกาย",
                  () => Get.to(() => ListPosesPage()),
                  FontAwesomeIcons.plus,
                )
              : const SizedBox())
        ]))));
  }

  Widget listdata(List<CalExeciseModel> list) {
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
                        Text("${list[index].poses}", style: Font.black16)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("จำนวนแคลอรี่ :", style: Font.black16),
                        Text("${list[index].burn}", style: Font.black16)
                      ]),
                  const Divider(
                      color: AppColor.black, indent: 20, endIndent: 20)
                ]))
          ]);
        });
  }

  Widget exercise() {
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
                chartType: CircularChartType.Radial)))
        : const SizedBox();
  }

  Widget goalBurn() {
    return GoalController.goalData.isNotEmpty
        ? SizedBox(
            width: 170,
            height: 170,
            child: Obx(() => AnimatedCircularChart(
                edgeStyle: SegmentEdgeStyle.round,
                labelStyle: Font.white20B,
                holeLabel:
                    "เป้าหมาย \n${GoalController.goalData[0].goalBurn}\n  แคลอรี่",
                size: const Size(180, 180),
                initialChartData: <CircularStackEntry>[
                  CircularStackEntry([
                    CircularSegmentEntry(
                        GoalController.goalData[0].goalCal! * 360 / 100,
                        AppColor.green)
                  ]),
                ].obs,
                chartType: CircularChartType.Radial)))
        : const SizedBox();
  }
}
