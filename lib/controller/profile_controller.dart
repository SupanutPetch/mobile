import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_mobile/view/login_page.dart';

class ProfileController extends GetxController {
  RxString image = "".obs;
  final auth = FirebaseAuth.instance;

  siginout() async {
    await auth.signOut();
    Get.to(() => LoginPage());
    Get.close(1);
  }
}
