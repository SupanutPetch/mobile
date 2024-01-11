import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:sizer/sizer.dart';

class BreakfastPage extends StatelessWidget {
  const BreakfastPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 3, color: AppColor.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: 73.w,
                        child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Search Menu",
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        FontAwesomeIcons.magnifyingGlass)))))
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 70.h,
              decoration: BoxDecoration(
                  color: AppColor.platinum,
                  border: Border.all(width: 3, color: AppColor.black),
                  borderRadius: BorderRadius.circular(50)),
            ),
          )
        ],
      )),
    );
  }
}
