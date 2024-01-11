import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final auth = FirebaseAuth.instance;
  String? foodImage =
      "https://i.pinimg.com/564x/34/f4/8f/34f48f5c56c938642b80b0555e5adf82.jpg";
  String? exerciseImage =
      "https://i.pinimg.com/564x/f3/73/f8/f373f80e574bd4eba0123caefe647ce0.jpg";
}
