import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_mobile/controller/basic_controller.dart';

class HomeController extends GetxController with StateMixin {
  final auth = FirebaseAuth.instance;
  String? foodImage =
      "https://i.pinimg.com/564x/34/f4/8f/34f48f5c56c938642b80b0555e5adf82.jpg";
  String? exerciseImage =
      "https://i.pinimg.com/564x/f3/73/f8/f373f80e574bd4eba0123caefe647ce0.jpg";
  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    UserData.userData.refresh();
    chackDataUser();
    change(null, status: RxStatus.success());
    super.onInit();
    update();
  }

  chackDataUser() async {
    if (UserData.userData.isEmpty) {
      await UserData.getdata();
      update();
    }
  }
}
