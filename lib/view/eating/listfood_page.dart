import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/listfood_controller.dart';
import 'package:project_mobile/model/food_mobel.dart';
import 'package:project_mobile/view/eating/scanfood_page.dart';
import 'package:project_mobile/widget.dart';
import 'package:sizer/sizer.dart';

class ListFoodPage extends StatelessWidget {
  const ListFoodPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListFoodController());
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
              child: GetBuilder<ListFoodController>(
            init: ListFoodController(),
            initState: (data) {},
            builder: (data) {
              return data.foodData.isNotEmpty
                  ? data.searchData.isNotEmpty
                      ? Obx(() => listdata(data.searchData))
                      : Obx(() => listdata(data.foodData))
                  : const Center(child: Text("No Data"));
            },
          )),
          Button.buttonwithicon("Scan Barcode",
              () => Get.to(() => const ScanFood()), FontAwesomeIcons.barcode),
          SizedBox(height: 5.h)
        ])));
  }

  Widget listdata(List<FoodModel> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Column(children: [
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.sp)),
                shadowColor: Colors.black,
                color: AppColor.platinum,
                child: ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("หมวดหมู่ : ${list[index].foodCategory!}",
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
                        onPressed: () => Get.back(),
                        icon: const Icon(FontAwesomeIcons.plus,
                            color: AppColor.green))))
          ]);
        });
  }
}
