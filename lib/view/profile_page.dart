import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/controller/profile_controller.dart';
import 'package:project_mobile/view/setting_page.dart';
import 'package:project_mobile/widget.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarProfile(),
        backgroundColor: AppColor.background,
        body: (Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text("Profile", style: Font.white30B),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      height: 580,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: AppColor.cream,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(children: [
                            Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4, color: AppColor.black),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child:
                                        // const CircleAvatar(
                                        // backgroundImage: NetworkImage(
                                        //     "https://scontent.fbkk12-2.fna.fbcdn.net/v/t39.30808-6/404591651_891260859239848_2997869654705368734_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=efb6e6&_nc_eui2=AeG4WtLIZTIya8DpHk09pEU-KqRIa9U1NkIqpEhr1TU2QiSd4pd4Mh0lHXSq61f1o47ECGFdv2nYCUtC1ZsNF25K&_nc_ohc=UpXBOW6sp4YAX-UQeCe&_nc_ht=scontent.fbkk12-2.fna&oh=00_AfAYPlIAEaPzBdK9teJ16JjSl7SLR_ZGTO_N9RP6O2XLcw&oe=6576599A"),
                                        // radius: 50))),
                                        // ??
                                        const Icon(Icons.account_circle_sharp,
                                            size: 100,
                                            color: AppColor.background))),
                            const SizedBox(height: 30),
                            dataUser("User :", "เพดเหน่ย"),
                            dataUser("Email", "test@mail.com"),
                            dataUser("age :", "24"),
                            dataUser("Gender :", "Man"),
                            Row(children: [
                              WidgetAll.dataTarget(
                                  "BMR(kcal)", "data", "เผาผลาญในแต่ละวัน"),
                              const Spacer(),
                              WidgetAll.dataTarget(
                                  "TEDD(kcal)", "data", "เผาผลาญเมื่อทำกิจกรรม")
                            ]),
                            const SizedBox(height: 15),
                            Row(children: [
                              WidgetAll.dataTarget(
                                  "Goal / Day", "data", "เป้าหมายต่อวัน"),
                              const Spacer(),
                              WidgetAll.dataTarget("BMI", "data", "ดัชนีมวลกาย")
                            ]),
                            const SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Button.button("Edit", () {}),
                                  Button.button(
                                      "Logout", () => controller.siginout()),
                                ])
                          ]))))
            ])));
  }

  dataUser(String title, String detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: Font.base20B),
        Container(
            width: 200,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppColor.black, width: 2))),
            child: Center(
                child: Text(
              detail,
              style: Font.base18,
            ))),
        const SizedBox(height: 40)
      ],
    );
  }

  appbarProfile() {
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
            child:
                const Icon(Icons.settings, size: 25, color: AppColor.custard)),
        onTap: () => Get.to(() => SettingPage()),
      ),
    );
  }
}
