import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/exercise/exercise_controller.dart';
import 'package:project_mobile/model/exercise_model.dart';
import 'package:project_mobile/widget.dart';
import 'package:sizer/sizer.dart';

class ListPosesPage extends StatelessWidget {
  const ListPosesPage({super.key});
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
                            ? Obx(() => listdata(data.searchData, context))
                            : Obx(() => listdata(data.exercideData, context))
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
        ])));
  }

  Widget listdata(List<ExerciseModel> list, BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Column(children: [
                SizedBox(
                    height: 28.h,
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
                              Image.network(list[index].imgExercise!),
                              Text(list[index].nameExercise!,
                                  style: Font.black16),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(right: 1.w),
                                        child:
                                            const Icon(FontAwesomeIcons.clock)),
                                    Text(list[index].setORtimeExercise!,
                                        style: Font.black16)
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(FontAwesomeIcons.fireFlameSimple,
                                        color: Colors.redAccent),
                                    Text(list[index].calExercise!,
                                        style: Font.black16)
                                  ]),
                              Button.button("Add", () {})
                            ]))))
              ]);
            }));
  }
}
