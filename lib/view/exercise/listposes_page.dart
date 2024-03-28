import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/controller/exercise/exercise_controller.dart';
import 'package:kitcal/model/exercise_model.dart';
import 'package:kitcal/widget.dart';
import 'package:sizer/sizer.dart';

class ListPosesPage extends StatelessWidget {
  ListPosesPage({super.key});
  final controller = Get.put(ExerciseController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        displacement: 15.h,
        onRefresh: controller.refreshData,
        color: AppColor.orange,
        child: controller.obx(
            (state) => Scaffold(
                resizeToAvoidBottomInset: false,
                extendBodyBehindAppBar: true,
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
                                    onChanged: (value) =>
                                        controller.search(value),
                                    hintText: 'Search...',
                                    leading: const Icon(
                                        FontAwesomeIcons.magnifyingGlass),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            AppColor.platinum),
                                    shadowColor: const MaterialStatePropertyAll(
                                        AppColor.black)))))
                  ]),
                  const Text("รายการท่าออกกำลังกาย", style: Font.white20),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       categoryIcon(
                  //           FontAwesomeIcons.listCheck, "ทั้งหมด", true),
                  //       categoryIcon(MdiIcons.genderMale, "ชาย", true),
                  //       categoryIcon(FontAwesomeIcons.personDress, "หญิง", true)
                  //     ]),
                  SizedBox(height: 2.h),
                  Expanded(
                      child: GetBuilder<ExerciseController>(
                          init: ExerciseController(),
                          initState: (data) {},
                          builder: (data) {
                            return data.exercideData.isNotEmpty
                                ? data.searchData.isNotEmpty
                                    ? Obx(() =>
                                        listdata(data.searchData, context))
                                    : Obx(() =>
                                        listdata(data.exercideData, context))
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        const Icon(FontAwesomeIcons.dumbbell,
                                            color: AppColor.orange),
                                        Center(
                                            child: Text('ไม่มีท่าออกกำลังกาย',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.white30)))
                                      ]);
                          }))
                ]))),
            onLoading: Scaffold(
                backgroundColor: AppColor.black,
                body: Center(
                    child: LoadingAnimationWidget.threeRotatingDots(
                        color: AppColor.orange, size: 100)))));
  }

  Widget listdata(List<ExerciseModel> list, BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: (list.length / 2).ceil(),
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(children: [
                    posesData(list, index),
                    if (index * 2 + 1 < list.length)
                      Expanded(
                          child: SizedBox(
                              height: 30.h,
                              width: 45.w,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(6.sp)),
                                  shadowColor: Colors.black,
                                  color: AppColor.platinum,
                                  child: ListTile(
                                      title: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.network(list[index * 2 + 1]
                                                .imgExercise!),
                                            Text(
                                                list[index * 2 + 1]
                                                    .nameExercise!,
                                                style: Font.black16),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 1.w),
                                                      child: const Icon(
                                                          FontAwesomeIcons
                                                              .clock)),
                                                  Text(
                                                      list[index * 2 + 1]
                                                          .setORtimeExercise!,
                                                      style: Font.black16)
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                      FontAwesomeIcons
                                                          .fireFlameSimple,
                                                      color: Colors.redAccent),
                                                  Text(
                                                      list[index * 2 + 1]
                                                          .calExercise!,
                                                      style: Font.black16)
                                                ]),
                                            Button.button("เพิ่ม", () {})
                                          ]),
                                      onTap:
                                          controller.viewDetail(list, index)))))
                  ]));
            }));
  }

  Widget posesData(List<ExerciseModel> list, int index) {
    return Expanded(
        child: SizedBox(
            height: 30.h,
            width: 45.w,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.sp)),
                shadowColor: Colors.black,
                color: AppColor.platinum,
                child: ListTile(
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(list[index * 2].imgExercise!),
                        Text(list[index * 2].nameExercise!,
                            style: Font.black16),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 1.w),
                                  child: const Icon(FontAwesomeIcons.clock)),
                              Text(list[index * 2].setORtimeExercise!,
                                  style: Font.black16)
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(FontAwesomeIcons.fireFlameSimple,
                                  color: Colors.redAccent),
                              Text(list[index * 2].calExercise!,
                                  style: Font.black16)
                            ]),
                        Button.button(
                            "เพิ่ม",
                            () =>
                                controller.addExerciseDaily(index, list[index]))
                      ]),
                  onTap: () => controller.viewDetail(list, index),
                ))));
  }

  Widget categoryIcon(IconData icon, String title, bool select) {
    return InkWell(
        onTap: () {},
        child: Container(
            height: 10.h,
            width: 18.w,
            decoration: BoxDecoration(
                color: select == false ? AppColor.platinum : AppColor.orange,
                shape: BoxShape.circle),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon,
                  color: select == false ? AppColor.orange : AppColor.white),
              SizedBox(height: 0.5.h),
              Text(title, style: select == false ? Font.black : Font.white)
            ])));
  }
}
