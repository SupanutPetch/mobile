import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kitcal/constant/color.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/controller/noti_controller.dart';

class NotiSettingPage extends StatelessWidget {
  const NotiSettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text('ตั้งค่าการแจ้งเตือน'.tr, style: Font.white20B),
            backgroundColor: AppColor.black,
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 8.h,
            leading: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Icon(FontAwesomeIcons.chevronLeft,
                        size: 20.sp, color: AppColor.orange)),
                onTap: () => Get.back(result: false))),
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.w),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(1.h),
                      child: Row(children: [
                        Padding(
                            padding: EdgeInsets.all(1.5.w),
                            child: const Text('เปิดการแจ้งเตือน',
                                style: Font.white18B)),
                        const Spacer(),
                        GetX<NotiController>(
                            init: NotiController(),
                            initState: (_) {},
                            builder: (_) {
                              return SizedBox(
                                  width: 16.w,
                                  height: 6.h,
                                  child: FittedBox(
                                      fit: BoxFit.none,
                                      child: Switch(
                                          activeColor: AppColor.green,
                                          value: _.allowNoti.value,
                                          onChanged: ((value) =>
                                              _.changeNotiSetting()))));
                            })
                      ]))
                ]))));
  }
}
