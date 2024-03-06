import 'package:flutter/material.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/constant/font.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
            child:
                Center(child: Text("กราฟรายงานผู้ใช้", style: Font.white18))));
  }
}
