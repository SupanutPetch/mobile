import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitcal/constant/font.dart';
import 'package:kitcal/constant/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class Textformfields {
  static Widget fieldBlank(String title, IconData icon,
      TextEditingController textEditingController, Color iconcolor) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 95.w,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Font.white16),
              TextFormField(
                  validator: (String? value) =>
                      value!.isEmpty ? "Please fill out information" : null,
                  onSaved: (value) => value!.isNotEmpty
                      ? textEditingController.text = value.trim()
                      : null,
                  controller: textEditingController,
                  scrollPadding: const EdgeInsets.all(1),
                  style: Font.black16B,
                  decoration: InputDecoration(
                      hintText: title,
                      filled: true,
                      fillColor: AppColor.platinum,
                      prefixIcon: Icon(icon,
                          color: iconcolor,
                          size: 35,
                          shadows: const [
                            Shadow(
                                color: AppColor.green,
                                offset: Offset(2, 2),
                                blurRadius: 1)
                          ]),
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: AppColor.platinum)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: AppColor.platinum, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: AppColor.platinum, width: 2))))
            ]))
      ])
    ]);
  }

  static Widget fieldPassWord(
      String title,
      IconData icon,
      bool obscure,
      Function function,
      TextEditingController textEditingController,
      bool showicon) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 95.w,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Font.white16),
              TextFormField(
                  onSaved: (value) => value!.isNotEmpty
                      ? textEditingController.text = value.trim()
                      : null,
                  controller: textEditingController,
                  scrollPadding: const EdgeInsets.all(5),
                  style: Font.black18B,
                  obscureText: obscure,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      hintText: title,
                      filled: true,
                      fillColor: AppColor.platinum,
                      prefixIcon: Icon(icon,
                          color: AppColor.orange,
                          size: 35,
                          shadows: const [
                            Shadow(offset: Offset(2, 2), color: AppColor.green)
                          ]),
                      labelStyle: const TextStyle(color: Colors.white),
                      suffixIcon: showicon
                          ? IconButton(
                              onPressed: () => function(),
                              icon: obscure
                                  ? const Icon(Icons.visibility_off,
                                      color: AppColor.black)
                                  : const Icon(Icons.visibility,
                                      color: AppColor.orange,
                                      shadows: [
                                          Shadow(
                                              offset: Offset(1, 1),
                                              color: Colors.black)
                                        ]))
                          : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: AppColor.platinum)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: AppColor.platinum, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: AppColor.platinum, width: 2))))
            ]))
      ])
    ]);
  }

  static Widget shotTextField(String titel, TextStyle textStyle,
      TextEditingController textEditingController) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(titel, style: textStyle),
      Container(
          height: 5.h,
          width: 30.w,
          decoration: BoxDecoration(
              color: AppColor.platinum,
              borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
              controller: textEditingController,
              scrollPadding: const EdgeInsets.all(10),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColor.platinum)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: AppColor.platinum, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: AppColor.platinum, width: 2)))))
    ]);
  }

  static Widget textField(String titel, TextStyle textStyle,
      TextEditingController textEditingController) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(titel, style: textStyle),
      Container(
          height: 5.h,
          width: 50.w,
          decoration: BoxDecoration(
              color: AppColor.platinum,
              borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
              controller: textEditingController,
              scrollPadding: const EdgeInsets.all(10),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColor.platinum)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: AppColor.platinum, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: AppColor.platinum, width: 2)))))
    ]);
  }
}

class Button {
  static Widget buttonLong(String label, var save) {
    return Container(
        width: 50.w,
        height: 6.h,
        decoration: BoxDecoration(
            color: AppColor.green,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2)),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                disabledBackgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            onPressed: save,
            child: Text(label,
                style: const TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [Shadow(blurRadius: 2, color: Colors.white)]))));
  }

  static Widget button(String buttonName, dynamic function) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.orange),
        onPressed: () => function(),
        child: Text(
          buttonName,
          style: Font.white18B,
        ));
  }

  static Widget buttonwithicon(
      String buttonName, dynamic function, IconData icon) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.orange),
        onPressed: () => function(),
        icon: Icon(icon, color: AppColor.black),
        label: Text(
          buttonName,
          style: Font.white20B,
        ));
  }
}

class WidgetAll {
  static appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 50,
      backgroundColor: Colors.transparent,
      leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
              margin: const EdgeInsets.only(left: 2),
              child: const Icon(FontAwesomeIcons.chevronLeft,
                  size: 25, color: AppColor.orange)),
          onTap: () => Get.back()),
    );
  }

  static Widget dialogWithButton(
      IconData icon, String detail, Function function, String labelButton) {
    return AlertDialog(
        backgroundColor: AppColor.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Icon(icon, color: AppColor.orange, size: 50),
        content: Text(detail, style: Font.white18),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
              onPressed: () => function(),
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
              child: Text(labelButton, style: Font.black16))
        ]);
  }

  static Widget dialog(IconData icon, String detail, Color iconcolor) {
    return Builder(builder: (context) {
      Future.delayed(const Duration(seconds: 1), () => Get.back());
      return AlertDialog(
          backgroundColor: AppColor.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Icon(icon, color: iconcolor, size: 50),
          content: Text(detail, style: Font.white18),
          actionsAlignment: MainAxisAlignment.center);
    });
  }

  static Widget loading() {
    return Material(
        type: MaterialType.transparency,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              LoadingAnimationWidget.fallingDot(
                  color: AppColor.orange, size: 100),
              const Text("loading...", style: Font.white18B)
            ])));
  }

  static Widget boxDateForPick(dynamic function, DateTime dateTime) {
    return InkWell(
        child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                color: AppColor.platinum,
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(20)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(DateFormat.yMd().format(dateTime), style: Font.black16B),
              const Icon(FontAwesomeIcons.cakeCandles,
                  size: 20,
                  color: AppColor.orange,
                  shadows: [Shadow(offset: Offset(1, 1))])
            ])),
        onTap: () {
          function();
        });
  }

  static Widget dataTarget(String title, String detail, String description) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColor.green),
                  borderRadius: BorderRadius.circular(20)),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(title, style: Font.black16B),
                const SizedBox(height: 20),
                Text(detail, style: Font.black16)
              ]))),
      Text(description, style: Font.black16)
    ]);
  }

  static Widget calculateGoal(
      TextEditingController hight,
      TextEditingController weight,
      Widget dropdown,
      TextEditingController targetWeight,
      TextEditingController goalDay,
      dynamic function) {
    return AlertDialog(
        backgroundColor: AppColor.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: 45.h,
            width: 50.h,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(FontAwesomeIcons.xmark, color: Colors.red))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Textformfields.shotTextField(
                    "ส่วนสูง (ซม.)", Font.white16, hight),
                Textformfields.shotTextField(
                    "น้ำหนัก (กก.)", Font.white16, weight)
              ]),
              SizedBox(height: 2.h),
              dropdown,
              SizedBox(height: 2.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Textformfields.shotTextField(
                    "น้ำหนักที่ตั้งเป้า(กก.)", Font.white16, targetWeight),
                Textformfields.shotTextField(" จำนวนวัน", Font.white16, goalDay)
              ]),
              const Spacer(),
              Center(child: Button.button("คำนวน", () => function()))
            ])));
  }
}
