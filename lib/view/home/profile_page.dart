import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/controller/profile_controller.dart';
import 'package:project_mobile/view/setting_page.dart';
import 'package:project_mobile/widget.dart';
import 'package:project_mobile/constant/font.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarProfile(),
        backgroundColor: AppColor.black,
        body: Column(children: [
          Row(children: [
            UserData.userData[0].userImageURL != null
                ? SizedBox(
                    height: 11.h,
                    width: 25.w,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage("${UserData.userData[0].userImageURL}"),
                    ),
                  )
                : Icon(
                    Icons.account_circle,
                    color: AppColor.orange,
                    size: 15.w,
                  ),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserData.userData[0].userName != null &&
                        UserData.userData[0].userName != ""
                    ? Text(
                        "${UserData.userData[0].userName}",
                        style: Font.white16,
                      )
                    : const Text(
                        "Unknow",
                        style: Font.white16,
                      ),
                Text(
                  "${UserData.userData[0].userEmail}",
                  style: Font.white16B,
                ),
              ],
            ),
          ]),
          Button.buttonLong("Edit Profile", () => UserData.userData.clear()),
          const Spacer(),
          ListTile(
            title: const Text(
              "Signout",
              style: Font.white16B,
            ),
            leading: const Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: AppColor.orange,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: AppColor.orange),
              onPressed: () => controller.siginout(),
            ),
          )
        ]));
  }

  dataUser(String title, String detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: Font.black20B),
        Container(
            width: 200,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppColor.black, width: 2))),
            child: Center(
                child: Text(
              detail,
              style: Font.black18,
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
                const Icon(Icons.settings, size: 25, color: AppColor.orange)),
        onTap: () => Get.to(() => SettingPage()),
      ),
    );
  }
}
