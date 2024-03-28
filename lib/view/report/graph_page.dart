import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitcal/constant/color.dart';
import 'package:d_chart/d_chart.dart';
import 'package:kitcal/controller/report/grapg_controller.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GraphController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: Column(
          children: [
            // controller.graphData.isNotEmpty
            //     ?
            AspectRatio(
              aspectRatio: 16 / 9,
              child: DChartPieO(data: controller.ordinalDataList),
            ),
          ],
        )));
  }
}
