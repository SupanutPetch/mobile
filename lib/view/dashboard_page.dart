import 'package:flutter/material.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';

import '../widget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAll.appbar(),
      backgroundColor: AppColor.background,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Dashboard", style: Font.white30B),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
              child: Container(
                height: 600,
                width: 380,
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    color: AppColor.cream,
                    borderRadius: BorderRadius.circular(30)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Calories", style: Font.base20B)],
                  ),
                ),
              ))
        ],
      )),
    );
  }
}
