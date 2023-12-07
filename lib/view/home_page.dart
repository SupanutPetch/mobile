import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const Center(child: Text("Home", style: Font.white30B)),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
                  child: Container(
                    height: 550,
                    width: 380,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        color: AppColor.cream,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Calories", style: Font.base20B),
                              const Text("Remaining = Goal - Food + Exercise",
                                  style: Font.base18B),
                              const SizedBox(height: 10),
                              const Center(
                                  child: CircleAvatar(
                                radius: 50,
                                child: Icon(FontAwesomeIcons.personRunning,
                                    size: 50),
                              )),
                              const SizedBox(height: 20),
                              Center(child: dataTarget("Goal", "data")),
                              Row(children: [
                                dataTarget("Food", "data"),
                                dataTarget("Execise", "data")
                              ])
                            ])),
                  ))
            ])));
  }

  Widget dataTarget(String title, String detail) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColor.darknavi),
                  borderRadius: BorderRadius.circular(20)),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(title, style: Font.base16B),
                const SizedBox(height: 20),
                Text(detail, style: Font.base16)
              ])))
    ]);
  }
}
