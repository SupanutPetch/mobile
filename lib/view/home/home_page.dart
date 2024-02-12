import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 4.h,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_none_outlined,
                      size: 3.5.h, color: AppColor.white)),
              SizedBox(width: 4.w)
            ]),
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        GetData.userData[0].userImageURL != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${GetData.userData[0].userImageURL}"))
                            : Icon(Icons.account_circle,
                                color: AppColor.orange, size: 15.w),
                        SizedBox(width: 3.w),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Welcome Back".tr, style: Font.white16B),
                              Text(GetData.userData[0].userName ?? "Unknow",
                                  style: Font.white16B)
                            ])
                      ]),
                      SizedBox(height: 5.h),
                      const Text("Daily Target", style: Font.white20B),
                      cardData(controller.foodImage ?? "", "Eating food",
                          "Calories today"),
                      SizedBox(height: 5.h),
                      cardData(controller.exerciseImage ?? "", "exercise",
                          "Metabolism today")
                    ]))));
  }

  Widget cardData(String imageURL, String title, String detail) {
    return Card(
        color: AppColor.platinum,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            onTap: () {
              debugPrint('Card tapped.');
            },
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
                        Text(detail, style: Font.black16)
                      ])
                ]))));
  }
}
