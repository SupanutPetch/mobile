import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/controller/profile_controller.dart';
import 'package:project_mobile/view/notification/notisetting_page.dart';
import 'package:project_mobile/view/report/report_page.dart';
import 'package:project_mobile/widget.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: Column(children: [
          SizedBox(height: 2.h),
          Row(children: [
            GetData.userData.isNotEmpty
                ? GetData.userData[0].userImageURL != null &&
                        GetData.userData[0].userImageURL!.isNotEmpty
                    ? SizedBox(
                        height: 11.h,
                        width: 25.w,
                        child: Obx(() => CircleAvatar(
                            backgroundImage: NetworkImage(
                                GetData.userData[0].userImageURL!))))
                    : Icon(Icons.account_circle,
                        color: AppColor.orange, size: 15.w)
                : Icon(Icons.account_circle,
                    color: AppColor.orange, size: 15.w),
            SizedBox(width: 2.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GetData.userData[0].userName != null &&
                      GetData.userData[0].userName != ""
                  ? Obx(() => Text("${GetData.userData[0].userName}",
                      style: Font.white16))
                  : const Text("Unknow", style: Font.white16),
              Text("${GetData.userData[0].userEmail}", style: Font.white16B)
            ])
          ]),
          Button.buttonLong("แก้ไขข้อมูล", () => Get.dialog(editProfile())),
          SizedBox(height: 3.h),
          InkWell(
            child: ListTile(
                title: const Text("รายงาน", style: Font.white16B),
                leading: const Icon(FontAwesomeIcons.clipboardUser,
                    color: AppColor.orange),
                trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: AppColor.orange),
                    onPressed: () => Get.to(() => const ReportPage()))),
            onTap: () => Get.to(() => const ReportPage()),
          ),
          SizedBox(height: 1.h),
          InkWell(
              child: ListTile(
                  title:
                      const Text("ตั้งค่าการแจ้งเตือน", style: Font.white16B),
                  leading:
                      const Icon(FontAwesomeIcons.bell, color: AppColor.orange),
                  trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: AppColor.orange),
                      onPressed: () => Get.to(() => const NotiSettingPage()))),
              onTap: () => Get.to(() => const NotiSettingPage())),
          const Spacer(),
          InkWell(
              child: ListTile(
                  title: const Text("ออกจากระบบ", style: Font.white16B),
                  leading: const Icon(FontAwesomeIcons.arrowRightFromBracket,
                      color: AppColor.orange),
                  trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: AppColor.orange),
                      onPressed: () => controller.siginout()),
                  onTap: () => controller.siginout())),
          SizedBox(height: 1.h)
        ])));
  }

  Widget editProfile() {
    return AlertDialog(
        backgroundColor: AppColor.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: 80.h,
            width: 80.w,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(FontAwesomeIcons.xmark,
                            color: Colors.red))
                  ]),
                  GetBuilder<ProfileController>(
                      init: ProfileController(),
                      initState: (data) {},
                      builder: (data) {
                        return GetData.userData[0].userImageURL!.isNotEmpty
                            ? Obx(() => SizedBox(
                                height: 11.h,
                                width: 25.w,
                                child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        GetData.userData[0].userImageURL!))))
                            : data.urlImg.value == ''
                                ? SizedBox(
                                    height: 11.h,
                                    width: 25.w,
                                    child: const CircleAvatar(
                                        backgroundColor: AppColor.black,
                                        child: Icon(Icons.account_circle,
                                            color: AppColor.orange, size: 100)))
                                : Obx(() => SizedBox(
                                    height: 11.h,
                                    width: 25.w,
                                    child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(data.urlImg.value))));
                      }),
                  Button.buttonwithicon("Change Image",
                      () => controller.changeIMG(), FontAwesomeIcons.camera),
                  SizedBox(height: 5.h),
                  Obx(() => texteditProfile("Name", controller.namecontroller,
                      GetData.userData[0].userName ?? "Name")),
                  Obx(() => texteditProfile("Mail", controller.mailcontroller,
                      GetData.userData[0].userEmail ?? "Email")),
                  const Spacer(),
                  Button.button("Save", () => controller.editProfile())
                ])));
  }

  Widget texteditProfile(
      String titel, TextEditingController textEditingController, String data) {
    textEditingController.text = data;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(titel, style: Font.white16),
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.platinum),
          child: Column(children: [
            TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppColor.platinum)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColor.platinum, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: AppColor.platinum, width: 2))))
          ])),
      SizedBox(height: 2.h)
    ]);
  }
}
