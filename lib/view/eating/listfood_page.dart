import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/controller/food/listfood_controller.dart';
import 'package:project_mobile/model/food_model.dart';
import 'package:project_mobile/view/eating/scanfood_page.dart';
import 'package:sizer/sizer.dart';

class ListFoodPage extends StatelessWidget {
  ListFoodPage({super.key});
  final controller = Get.put(ListFoodController());
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
                            hintText: 'Search...',
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Obx(() => categoryIcon(
                FontAwesomeIcons.list, "ทั้งหมด", controller.allmenu.value)),
            Obx(() => categoryIcon(
                FontAwesomeIcons.pizzaSlice, "อาหาร", controller.food.value)),
            Obx(() => categoryIcon(FontAwesomeIcons.glassWater, "เครื่องดื่ม",
                controller.drink.value)),
            Obx(() => categoryIcon(
                FontAwesomeIcons.apple, "ผลไม้", controller.fruit.value)),
            Obx(() => categoryIcon(
                FontAwesomeIcons.candyCane, "ทานเล่น", controller.snacks.value))
          ]),
          Expanded(
              child: GetBuilder<ListFoodController>(
                  init: ListFoodController(),
                  initState: (data) {},
                  builder: (data) {
                    return data.foodData.isNotEmpty
                        ? data.searchData.isNotEmpty
                            ? Obx(() => listdata(data.searchData))
                            : Obx(() => listdata(data.listData))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(Icons.no_food,
                                    color: AppColor.orange, size: 25.sp),
                                SizedBox(height: 2.h),
                                const Center(
                                    child: Text("ไม่พบข้อมูล",
                                        style: Font.white18))
                              ]);
                  }))
        ])));
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
                            onPressed: () =>
                                controller.addfooditem(index, list[index]),
                            icon: const Icon(FontAwesomeIcons.plus,
                                color: AppColor.green))))
              ]));
        });
  }

  Widget categoryIcon(IconData icon, String title, bool select) {
    return InkWell(
        onTap: () => controller.selectCategory(title),
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
