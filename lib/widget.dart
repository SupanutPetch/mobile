import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Textformfields {
  static Widget fieldBlank(
      String title,
      IconData icon,
      TextEditingController textEditingController,
      bool obscure,
      Color iconcolor) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 300,
            child: TextFormField(
                obscureText: obscure,
                validator: (String? value) =>
                    value!.isEmpty ? "Please fill out information" : null,
                onSaved: (value) => value!.isNotEmpty
                    ? textEditingController.text = value.trim()
                    : null,
                controller: textEditingController,
                scrollPadding: const EdgeInsets.all(1),
                style: Font.base16B,
                decoration: InputDecoration(
                  hintText: title,
                  filled: true,
                  fillColor: Colors.indigo.withOpacity(0.2),
                  prefixIcon: Icon(
                    icon,
                    color: iconcolor,
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

  static Widget fieldPassWord(
    String title,
    IconData icon,
    bool obscure,
    Function function,
    TextEditingController textEditingController,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(left: 75)),
      const SizedBox(height: 5),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 300,
            child: TextFormField(
                onSaved: (value) => value!.isNotEmpty
                    ? textEditingController.text = value.trim()
                    : null,
                controller: textEditingController,
                scrollPadding: const EdgeInsets.all(5),
                style: Font.base18B,
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
                              color: AppColor.black)
                          : const Icon(Icons.visibility,
                              color: AppColor.custard)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
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
            shadowColor: Colors.transparent),
        onPressed: save,
        child: Text(label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              shadows: [Shadow(blurRadius: 2, color: Colors.white)],
            )),
      ),
    );
  }

  static Widget button(String buttonName, dynamic function) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.custard),
        onPressed: () => function(),
        child: Text(
          buttonName,
          style: Font.white18B,
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
                  size: 25, color: AppColor.custard)),
          onTap: () => Get.back()),
    );
  }

  static Widget dialogWithButton(
      IconData icon, String detail, Function function, String labelButton) {
    return AlertDialog(
        backgroundColor: AppColor.darknavi,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Icon(icon, color: AppColor.custard, size: 50),
        content: Text(detail, style: Font.white18),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
              onPressed: () => function(),
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColor.custard),
              child: Text(labelButton, style: Font.base16B))
        ]);
  }

  static Widget dialog(IconData icon, String detail, Color iconcolor) {
    return Builder(builder: (context) {
      Future.delayed(const Duration(seconds: 1), () => Get.back());
      return AlertDialog(
        backgroundColor: AppColor.darknavi,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Icon(icon, color: iconcolor, size: 50),
        content: Text(detail, style: Font.white18),
        actionsAlignment: MainAxisAlignment.center,
      );
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
                  color: AppColor.custard, size: 100),
              const Text("loading...", style: Font.white18B)
            ])));
  }

  static Widget boxDateForPick(Function function, DateTime dateTime) {
    return InkWell(
      child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.2),
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(DateFormat.yMd().format(dateTime), style: Font.base16B),
            const Icon(FontAwesomeIcons.cakeCandles,
                size: 20,
                color: AppColor.custard,
                shadows: [Shadow(offset: Offset(1, 1))])
          ])),
      onTap: () {
        function();
      },
    );
  }

  static Widget dataTarget(String title, String detail, String description) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColor.darknavi),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title, style: Font.base16B),
                const SizedBox(height: 20),
                Text(detail, style: Font.base16)
              ],
            ),
          ),
        ),
        Text(
          description,
          style: Font.base16,
        )
      ],
    );
  }
}
