import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/controller/food/listfood_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanFood extends StatelessWidget {
  const ScanFood({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text('สแกนบาร์โค้ด'.tr, style: Font.white20B),
            backgroundColor: AppColor.black,
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 5.h,
            leading: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                    margin: EdgeInsets.only(left: 2.w),
                    child: Icon(FontAwesomeIcons.chevronLeft,
                        size: 20.sp, color: AppColor.orange)),
                onTap: () => Get.back())),
        backgroundColor: AppColor.black,
        body: Center(
            child: Container(
          width: Get.width * 0.8,
          height: Get.width * 0.5,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColor.orange, width: 4.0),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: GetBuilder<ListFoodController>(
              init: ListFoodController(),
              initState: (controller) {},
              builder: (controller) {
                return MobileScanner(
                    startDelay: false,
                    controller: controller.cameraController,
                    onDetect: (barcode) =>
                        controller.qrDetect(context, barcode));
              }),
        )));
  }
}
