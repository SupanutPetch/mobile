import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitcal/controller/noti_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:kitcal/constant/color.dart';
import 'package:kitcal/controller/basic_controller.dart';
import 'package:kitcal/firebase_options.dart';
import 'package:kitcal/view/home/bottombar.dart';
import 'package:kitcal/view/home/exercise_page.dart';
import 'package:kitcal/view/home/goal_page.dart';
import 'package:kitcal/view/home/homefood_page.dart';
import 'package:kitcal/view/home/profile_page.dart';
import 'package:kitcal/view/welcome/welcome_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

final controller = Get.put(NotiController());

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupNoti();
  showFlutterNotification(message);
  RemoteNotification? notification = message.notification;
  if (notification != null) {
    controller.setSharedNoti(notification);
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initNoti();
  if (FirebaseAuth.instance.currentUser != null &&
      FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
    await GetData.getdata();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> setupNoti() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> initNoti() async {
  await setupNoti();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  settings.authorizationStatus == AuthorizationStatus.authorized;
  settings.authorizationStatus == AuthorizationStatus.provisional;
  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
}

void showFlutterNotification(RemoteMessage message) async {
  final shared = await SharedPreferences.getInstance();
  bool chackShared = shared.getBool('notisetting') ?? true;
  if (chackShared == true) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    notification != null ? controller.setSharedNoti(notification) : null;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  icon: '@mipmap/iconapp')));
    }
  }
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
            GetPage(name: "/", page: () => GoalPage()),
            GetPage(name: "/HomeFoodPage", page: () => HomeFoodPage()),
            GetPage(name: "/ExercisePage", page: () => ExercisePage()),
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
