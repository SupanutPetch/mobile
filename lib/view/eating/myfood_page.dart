import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/view/eating/scanfood_page.dart';
import 'package:sizer/sizer.dart';

import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/food/myfood_controller.dart';
import 'package:project_mobile/model/food_model.dart';
import 'package:project_mobile/widget.dart';

class MyFoodPage extends StatelessWidget {
  MyFoodPage({super.key});
  final controller = Get.put(MyMenuController());
  @override
  Widget build(BuildContext context) {
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
                            hintText: 'ค้นหา...',
                            leading:
                                const Icon(FontAwesomeIcons.magnifyingGlass),
                            backgroundColor: const MaterialStatePropertyAll(
                                AppColor.platinum),
                            shadowColor: const MaterialStatePropertyAll(
                                AppColor.black))))),
            IconButton(
                onPressed: () => Get.to(() => const ScanFood()),
                icon: const Icon(FontAwesomeIcons.barcode,
                    color: AppColor.orange))
          ]),
          Expanded(
              child: GetBuilder<MyMenuController>(
                  init: MyMenuController(),
                  initState: (data) {},
                  builder: (data) {
                    return data.myfood.isNotEmpty
                        ? data.searchData.isNotEmpty
                            ? Obx(() => listdata(data.searchData))
                            : Obx(() => listdata(data.myfood))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(Icons.no_food,
                                    color: AppColor.orange, size: 25.sp),
                                SizedBox(height: 2.h),
                                const Center(
                                    child: Text("ไม่พบข้อมูล",
                                        style: Font.white18)),
                                IconButton(
                                    onPressed: () => Get.dialog(addFood(
                                        Obx(() => dropdown(controller)))),
                                    icon: const Icon(FontAwesomeIcons.plus,
                                        color: AppColor.green))
                              ]);
                  })),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.orange),
              onPressed: () => controller.addFood(),
              child: Column(children: [
                SizedBox(height: 1.h),
                Icon(Icons.fastfood, color: AppColor.white, size: 20.sp),
                SizedBox(height: 1.h),
                const Text("เพิ่มเมนูอาหาร", style: Font.white18)
              ]))
        ])));
  }

  dropdown(MyMenuController foodController) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("หมวดหมู่"),
      SizedBox(height: 0.5.h),
      Container(
          width: 40.w,
          decoration: BoxDecoration(
              color: AppColor.platinum,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            DropdownButton(
                dropdownColor: AppColor.platinum,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(10),
                value: foodController.selectCategory.value,
                items: foodController.foodCategory.map((option) {
                  return DropdownMenuItem(
                      value: option, child: Text(option, style: Font.black16));
                }).toList(),
                onChanged: (value) {
                  foodController.changeCategory(value!);
                })
          ]))
    ]);
  }

  Widget addFood(dynamic dropdown) {
    return Obx(() => AlertDialog(
            backgroundColor: AppColor.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
                height: 90.h,
                width: 60.w,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Text("เพิ่มเมนู", style: Font.white18B),
                        const Spacer(),
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(FontAwesomeIcons.xmark,
                                color: Colors.red))
                      ]),
                      Row(children: [dropdown]),
                      SizedBox(height: 2.h),
                      textfield('ชื่อเมนู', controller.foodName),
                      textfield('ปริมาณ', controller.foodQuantity),
                      textfield('จำนวนแคลอรี่', controller.foodCal),
                      textfield('บาร์โค้ด (ถ้ามี)', controller.foodBarcode),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 1.h,
                                child: Obx(() => Checkbox(
                                    side:
                                        const BorderSide(color: AppColor.white),
                                    activeColor: AppColor.white,
                                    checkColor: AppColor.green,
                                    value: controller.material.value,
                                    onChanged: ((value) =>
                                        controller.checkMaterial(value!))))),
                            const Text("เพิ่มส่วนผสม?", style: Font.white18)
                          ]),
                      controller.material.isTrue
                          ? Button.button("เพิ่มส่วนผสม", () {})
                          : const SizedBox()
                    ])),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColor.green),
                  onPressed: () => controller.addFood(),
                  child: const Text("บันทึก", style: Font.white16B))
            ]));
  }

  Widget textfield(String titel, TextEditingController textEditingController) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(titel, style: Font.white18),
      Container(
          height: 5.h,
          width: 60.w,
          decoration: BoxDecoration(
              color: AppColor.platinum,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
              controller: textEditingController,
              inputFormatters: [LengthLimitingTextInputFormatter(20)],
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColor.platinum)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: AppColor.platinum, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColor.platinum, width: 2))))),
      SizedBox(height: 2.h)
    ]);
  }

  Widget listdata(List<FoodModel> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.fromLTRB(5.sp, 0, 5.sp, 0),
              child: Column(children: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.sp)),
                    shadowColor: Colors.black,
                    color: AppColor.platinum,
                    child: Slidable(
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                            extentRatio: 0.25,
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                  onPressed: (BuildContext context) {
                                    controller.deleteMenu(index);
                                  },
                                  icon: Icons.delete,
                                  label: 'ลบ'.tr,
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  autoClose: true)
                            ]),
                        child: ListTile(
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "หมวดหมู่ : ${list[index].foodCategory!}",
                                      style: Font.black16),
                                  Text("ชื่ออาหาร : ${list[index].foodName!}",
                                      style: Font.black16)
                                ]),
                            subtitle: Row(children: [
                              Text("ปริมาณ : ${list[index].foodQuantity!}",
                                  style: Font.black16),
                              SizedBox(width: 2.w),
                              Text("จำนวนแคลอรี่ : ${list[index].foodCal!}",
                                  style: Font.black16)
                            ]),
                            trailing: IconButton(
                                onPressed: () =>
                                    controller.addfooditem(index, list[index]),
                                icon: const Icon(FontAwesomeIcons.plus,
                                    color: AppColor.orange)))))
              ]));
        });
  }
}
