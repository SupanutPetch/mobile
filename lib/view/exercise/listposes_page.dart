import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/exercise_controller.dart';
import 'package:project_mobile/model/exercise_mobel.dart';
import 'package:sizer/sizer.dart';

class ListPoses extends StatelessWidget {
  const ListPoses({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExerciseController());
    return Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: Column(children: [
          Row(children: [
            IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(FontAwesomeIcons.chevronLeft,
                    color: AppColor.orange)),
            Center(
                child: SizedBox(
                    height: 10.h,
                    width: 70.w,
                    child: Padding(
                        padding: EdgeInsets.all(2.h),
                        child: SearchBar(
                            onChanged: (value) => controller.search(value),
                            hintText: 'Search...',
                            leading:
                                const Icon(FontAwesomeIcons.magnifyingGlass),
                            backgroundColor: const MaterialStatePropertyAll(
                                AppColor.platinum),
                            shadowColor: const MaterialStatePropertyAll(
                                AppColor.black)))))
          ]),
          Expanded(
              child: GetBuilder<ExerciseController>(
                  init: ExerciseController(),
                  initState: (data) {},
                  builder: (data) {
                    return data.exercideData.isNotEmpty
                        ? data.searchData.isNotEmpty
                            ? Obx(() => listdata(data.searchData))
                            : Obx(() => listdata(data.exercideData))
                        : const Center(child: Text("No Data"));
                  }))
        ])));
  }

  Widget listdata(List<ExerciseMobel> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Row(children: [
            SizedBox(
              width: 45.w,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.sp)),
                  shadowColor: Colors.black,
                  color: AppColor.platinum,
                  child: ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(list[index].imgExercise!,
                              width: 40.w, height: 10.h),
                          Text("ชื่อท่า : ${list[index].nameExercise!}",
                              style: Font.black16),
                          Text(
                              "ระยะเวลา / จำนวนครั้ง : ${list[index].setORtimeExercise!}",
                              style: Font.black16)
                        ]),
                    subtitle: Column(children: [
                      Text("แคลอรี่ : ${list[index].calExercise!}",
                          style: Font.black16),
                    ]),
                  )),
            )
          ]);
        });
  }
}
