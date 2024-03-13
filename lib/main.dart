import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kitcal/controller/basic_controller.dart';
import 'package:kitcal/view/home/bottombar.dart';
import 'package:kitcal/view/home/exercise_page.dart';
import 'package:kitcal/view/home/goal_page.dart';
import 'package:kitcal/view/home/homefood_page.dart';
import 'package:kitcal/view/home/profile_page.dart';
import 'package:kitcal/view/welcome/welcome_page.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initNoti();
  if (FirebaseAuth.instance.currentUser != null &&
      FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
    await GetData.getdata();
  }
  runApp(const MyApp());
}

Future<void> initNoti() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  final tokel = await messaging.getToken();
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  debugPrint(tokel);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {}
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  RemoteMessage? initialMessage = await messaging.getInitialMessage();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              primaryColor: AppColor.black),
          initialRoute: "/",
          getPages: [
            GetPage(name: "/ExercisePage", page: () => ExercisePage()),
            GetPage(name: "/HomeFoodPage", page: () => HomeFoodPage()),
            GetPage(name: "/GoalPage", page: () => GoalPage()),
            GetPage(name: "/ProfilePage", page: () => ProfilePage()),
          ],
          home: FutureBuilder(
              future: Future.value(FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.uid.isNotEmpty),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return const BottomBar();
                } else {
                  return WelcomePage();
                }
              }));
    });
  }
}
