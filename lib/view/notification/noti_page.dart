import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:kitcal/constant/color.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/controller/noti_controller.dart';

class NotiPage extends StatelessWidget {
  NotiPage({super.key});
  final notiController = Get.put(NotiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text('การแจ้งเตือน'.tr, style: Font.white20B),
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 8.h,
            backgroundColor: AppColor.black,
            centerTitle: true,
            leading: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Icon(FontAwesomeIcons.chevronLeft,
                        size: 20.sp, color: AppColor.orange)),
                onTap: () => Get.back()),
            actions: [
              IconButton(
                  onPressed: notiController.clearNoti,
                  icon: Icon(FontAwesomeIcons.trashCan,
                      size: 15.sp, color: AppColor.orange)),
              SizedBox(width: 3.w)
            ]),
        backgroundColor: AppColor.black,
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Column(children: [
                  Expanded(
                      child: (notiController.notilist.isNotEmpty)
                          ? Obx(() => ListView.builder(
                              addAutomaticKeepAlives: true,
                              itemCount: notiController.notilist.length,
                              itemBuilder: (BuildContext context, int index) {
                                var shownotilist =
                                    notiController.notilist[index];
                                return Padding(
                                    padding: EdgeInsets.all(2.sp),
                                    child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: AppColor.platinum,
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.sp)),
                                        child: Slidable(
                                            closeOnScroll: true,
                                            endActionPane: ActionPane(
                                                extentRatio: 0.25,
                                                motion: const StretchMotion(),
                                                children: [
                                                  SlidableAction(
                                                      onPressed: (BuildContext
                                                          context) {
                                                        notiController
                                                            .deleteNoti(index);
                                                      },
                                                      icon: Icons.delete,
                                                      label: 'ลบ'.tr,
                                                      backgroundColor: Colors
                                                          .red
                                                          .withOpacity(0.75),
                                                      foregroundColor:
                                                          Colors.white,
                                                      autoClose: true)
                                                ]),
                                            child: Padding(
                                                padding: EdgeInsets.all(4.0.sp),
                                                child:
                                                    notidata(shownotilist)))));
                              }))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  const Icon(FontAwesomeIcons.bellSlash,
                                      color: AppColor.orange),
                                  Center(
                                      child: Text('ไม่มีการแจ้งเตือน',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white30)))
                                ]))
                ]))));
  }

  Widget notidata(var shownotilist) {
    return ListTile(
        onTap: () {},
        leading: SizedBox(
            height: 5.h,
            width: 10.w,
            child: const CircleAvatar(
                backgroundImage: AssetImage(
              "lib/asset/iconApp.png",
            ))),
        title: Text(shownotilist.titel ?? '',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold)),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(shownotilist.body ?? '',
              softWrap: true,
              style: TextStyle(color: Colors.black87, fontSize: 12.sp)),
          SizedBox(height: 3.sp),
          Row(children: [
            Icon(Icons.access_time, color: Colors.black38, size: 12.sp),
            SizedBox(width: 3.sp),
            Text(
              shownotilist.date ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black38, fontSize: 8.sp),
            )
          ])
        ]));
  }
}
