import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';

class Textformfields {
  static Widget fieldBlank(String title, IconData icon,
      TextEditingController textEditingController) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 300,
            child: TextFormField(
                controller: textEditingController,
                scrollPadding: const EdgeInsets.all(1),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: title,
                  filled: true,
                  fillColor: Colors.indigo.withOpacity(0.2),
                  prefixIcon: Icon(
                    icon,
                    color: AppColor.darknavi,
                    size: 35,
                    shadows: const [
                      Shadow(color: AppColor.black, offset: Offset(1, 1))
                    ],
                  ),
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColor.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: AppColor.black, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2)),
                )))
      ])
    ]);
  }

  static Widget fieldPassWord(String title, IconData icon, bool obscure,
      Function function, TextEditingController textEditingController) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 300,
            child: TextFormField(
                controller: textEditingController,
                scrollPadding: const EdgeInsets.all(5),
                style: const TextStyle(color: Colors.white),
                obscureText: obscure,
                decoration: InputDecoration(
                  hintText: title,
                  filled: true,
                  fillColor: Colors.indigo.withOpacity(0.2),
                  prefixIcon: Icon(icon,
                      color: AppColor.custard,
                      size: 35,
                      shadows: const [
                        Shadow(offset: Offset(1, 1), color: Colors.black)
                      ]),
                  labelStyle: const TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                      onPressed: () => function(),
                      icon: obscure
                          ? const Icon(Icons.visibility_off,
                              color: AppColor.custard)
                          : const Icon(Icons.visibility,
                              color: AppColor.darknavi)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: AppColor.black, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      )),
                )))
      ])
    ]);
  }
}

class Button {
  static Widget buttonLong(String label, var save) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
          color: AppColor.darknavi,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: save,
        child: Text(label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              shadows: [
                Shadow(
                  blurRadius: 2,
                  color: Colors.white,
                ),
              ],
            )),
      ),
    );
  }

  static Widget button(String buttonName, dynamic function) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.custard),
          onPressed: () => function(),
          child: Text(
            buttonName,
            style: Font.white18B,
          )),
    );
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
                size: 25, color: AppColor.custard)),
        onTap: () => Get.back(),
      ),
    );
  }
}
