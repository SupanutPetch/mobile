import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_mobile/controller/basic_controller.dart';
import 'package:project_mobile/view/auth/login_page.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    await chackDataUser();
    super.onInit();
  }

  chackDataUser() async {
    if (UserData.userData.isEmpty) {
      await UserData.getdata();
      update();
    }
  }

  siginout() async {
    Get.close(0);

    await auth.signOut();
    Get.to(() => LoginPage());
  }
}
