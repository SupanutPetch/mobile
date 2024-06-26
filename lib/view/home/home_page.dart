import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitcal/controller/food/homefood_controller.dart';
import 'package:kitcal/controller/noti_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/controller/basic_controller.dart';
import 'package:kitcal/controller/exercise/exercise_controller.dart';
import 'package:kitcal/controller/goal_controller.dart';
import 'package:kitcal/controller/home_controller.dart';
import 'package:kitcal/view/eating/navigationbar.dart';
import 'package:kitcal/view/exercise/listposes_page.dart';
import 'package:kitcal/view/notification/noti_page.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  final noticontroller = Get.put(NotiController());
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 4.h,
                automaticallyImplyLeading: false,
                actions: [
                  Obx(() => IconButton(
                      onPressed: () => Get.to(() => NotiPage()),
                      icon: noticontroller.notilist.isEmpty
                          ? Icon(Icons.notifications_none_outlined,
                              size: 3.5.h, color: AppColor.white)
                          : Icon(Icons.notifications_active,
                              size: 3.5.h, color: AppColor.orange))),
                  SizedBox(width: 4.w)
                ]),
            backgroundColor: AppColor.black,
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            GetData.userData[0].userImageURL!.isNotEmpty
                                ? SizedBox(
                                    height: 11.h,
                                    width: 25.w,
                                    child: Obx(() => CircleAvatar(
                                        backgroundImage: NetworkImage(GetData
                                            .userData[0].userImageURL!))))
                                : Icon(Icons.account_circle,
                                    color: AppColor.orange, size: 15.w),
                            SizedBox(width: 3.w),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ยินดีต้อนรับ".tr, style: Font.white16B),
                                  Text(
                                      GetData.userData[0].userName ??
                                          "ไม่รู้จัก",
                                      style: Font.white16B)
                                ])
                          ]),
                          SizedBox(height: 5.h),
                          const Text("เป้าหมายในวันนี้", style: Font.white20B),
                          GoalController.goalData.isNotEmpty
                              ? cardData(
                                  controller.foodImage ?? "",
                                  "การกินอาหาร",
                                  "แคลอรี่การกินวันนี้  : ${HomeFoodController.totelCalEat}",
                                  "เป้าหมาย : ${GoalController.goalData[0].goalCal}",
                                  () => Get.to(() => const NavigationBarPage()))
                              : cardData(
                                  controller.foodImage ?? "",
                                  "การกินอาหาร",
                                  "แคลอรี่การกินวันนี้  : ${HomeFoodController.totelCalEat}",
                                  "คุณยังไม่ได้ตั้งเป้าหมาย",
                                  () =>
                                      Get.to(() => const NavigationBarPage())),
                          SizedBox(height: 5.h),
                          GoalController.goalData.isNotEmpty
                              ? cardData(
                                  controller.exerciseImage ?? "",
                                  "ออกกำลังกาย",
                                  "แคลอรี่ออกกำลังกายวันนี้ : ${ExerciseController.totelCalBurn}",
                                  "เป้าหมาย : ${GoalController.goalData[0].goalBurn}",
                                  () => Get.to(() => ListPosesPage()))
                              : cardData(
                                  controller.exerciseImage ?? "",
                                  "ออกกำลังกาย",
                                  "แคลอรี่ออกกำลังกายวันนี้ :",
                                  "คุณยังไม่ได้ตั้งเป้าหมาย",
                                  () => Get.to(() => ListPosesPage()))
                        ])))),
        onLoading: Scaffold(
            backgroundColor: AppColor.black,
            body: Center(
                child: LoadingAnimationWidget.threeRotatingDots(
              color: AppColor.orange,
              size: 100,
            ))));
  }

  Widget cardData(String imageURL, String title, String detail, String goal,
      dynamic funtion) {
    return Card(
        color: AppColor.platinum,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            onTap: () => funtion(),
            child: SizedBox(
                width: 90.w,
                height: 20.h,
                child: Row(children: [
                  SizedBox(
                      height: 100.h,
                      width: 30.w,
                      child: Image.network(
                        imageURL,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(width: 2.w),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: Font.black18B),
                        Text(detail, style: Font.black16),
                        Text(goal, style: Font.black16)
                      ])
                ]))));
  }
}
