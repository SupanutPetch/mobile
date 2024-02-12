import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/view/home/exercise_page.dart';
import 'package:project_mobile/view/home/meals_page.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_mobile/constant/color.dart';
import 'package:project_mobile/firebase_options.dart';
import 'package:project_mobile/view/welcome/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
            GetPage(name: "/MealsPage", page: () => const MealsPage()),
            GetPage(name: "/ExercisePage", page: () => const ExercisePage()),
          ],
          home: WelcomePage());
    });
  }
}
