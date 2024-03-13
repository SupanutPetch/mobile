import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitcal/controller/auth/register_controller.dart';
import 'package:kitcal/controller/basic_controller.dart';
import 'package:kitcal/controller/profile_controller.dart';
import 'package:kitcal/view/notification/notisetting_page.dart';
import 'package:kitcal/view/report/report_page.dart';
import 'package:kitcal/widget.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/constant/color.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.put(ProfileController());
  final rescontroller = Get.put(RegisterController());
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
          Button.buttonLong(
              "แก้ไขข้อมูล", () => Get.dialog(editProfile(context))),
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

  Widget editProfile(BuildContext context) {
    return AlertDialog(
        backgroundColor: AppColor.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: 80.h,
            width: 80.w,
            child: ListView(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(FontAwesomeIcons.xmark, color: Colors.red))
              ]),
              GetBuilder<ProfileController>(
                  init: ProfileController(),
                  initState: (data) {},
                  builder: (data) {
                    return GetData.userData[0].userImageURL!.isNotEmpty
                        ? Obx(() => Center(
                              child: SizedBox(
                                  height: 11.h,
                                  width: 25.w,
                                  child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          GetData.userData[0].userImageURL!))),
                            ))
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
              SizedBox(height: 1.h),
              Button.buttonwithicon("เปลี่ยนรูปประจำตัว",
                  () => controller.changeIMG(), FontAwesomeIcons.camera),
              SizedBox(height: 2.h),
              texteditProfile("ชื่อ", controller.namecontroller,
                  controller.namecontroller.text),
              texteditProfile("เมล", controller.mailcontroller,
                  GetData.userData[0].userEmail ?? "Email"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  texteditProfileshot("น้ำหนัก", controller.weightcontroller,
                      GetData.userData[0].userWeight!),
                  texteditProfileshot("ส่วนสูง", controller.heightcontroller,
                      GetData.userData[0].userHigh!),
                ],
              ),
              Row(children: [
                const Text("วันเกิด :  ", style: Font.white20B),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.platinum),
                    label: Obx(() => Text(
                        DateFormat.yMd()
                            .format(rescontroller.selectedDate.value),
                        style: Font.black18B)),
                    icon: const Icon(FontAwesomeIcons.calendarDays,
                        color: AppColor.orange),
                    onPressed: () {
                      rescontroller.selectDate(context);
                    })
              ]),
              Row(children: [
                const Text("เพศ :", style: Font.white18B),
                Obx(() => selectGender())
              ]),
              Obx(() => dropdown()),
              SizedBox(height: 2.h),
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

  Widget texteditProfileshot(
      String titel, TextEditingController textEditingController, String data) {
    textEditingController.text = data;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(titel, style: Font.white16),
      Container(
          width: 20.w,
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

  Widget selectGender() {
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Radio(
          activeColor: AppColor.orange,
          value: 0,
          groupValue: controller.selectedRadio.value,
          onChanged: (value) => controller.setSelectedGender(value!)),
      const Text('ชาย', style: Font.white18B),
      Radio(
          activeColor: AppColor.orange,
          value: 1,
          groupValue: controller.selectedRadio.value,
          onChanged: (value) => controller.setSelectedGender(value!)),
      const Text('หญิง', style: Font.white18B)
    ]));
  }

  Widget dropdown() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Text("กิจกรรม", style: Font.white16),
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.platinum)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                  isExpanded: true,
                  dropdownColor: AppColor.black,
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(20),
                  value: controller.selectActivity.value,
                  items: controller.activityLevel.map((option) {
                    return DropdownMenuItem(
                        value: option, child: Text(option, style: Font.white));
                  }).toList(),
                  onChanged: (value) {
                    controller.changeActivity(value!);
                  })))
    ]);
  }
}
