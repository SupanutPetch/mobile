import 'dart:async';

import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/controller/basic_controller.dart';
import 'package:kitcal/controller/goal_controller.dart';
import 'package:kitcal/controller/noti_controller.dart';
import 'package:kitcal/main.dart';
import 'package:kitcal/model/caleat_model.dart';
import 'package:kitcal/view/eating/navigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFoodController extends GetxController with StateMixin {
  var data = <CircularStackEntry>[].obs;
  static RxInt totelCalEat = 0.obs;
  static RxList<CalEatModel> calEat = <CalEatModel>[].obs;
  final noticontroller = Get.put(NotiController());

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getdata();
    await getEatDaily();
    change(null, status: RxStatus.success());
    super.onInit();
    await checkeat();
    Timer.periodic(const Duration(seconds: 5), (_) async {
      await getdata();
    });
  }

  Future onrefresh() async {
    await getdata();
    Get.forceAppUpdate();
  }

  getEatDaily() async {
    QuerySnapshot querySnapshot = await GetData.firestore
        .collection("UserData")
        .doc(GetData.auth.currentUser!.uid)
        .collection("EatDaily")
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    calEat.assignAll(docs.map((data) {
      if (data["date"] == DateFormat('MMddyyyy').format(DateTime.now())) {
        return CalEatModel(
            food: data["food"], cal: data["cal"], date: data["date"]);
      } else {
        return null;
      }
    }).whereType<CalEatModel>());
    if (calEat.isNotEmpty) {
      HomeFoodController.totelCalEat.value = calEat
          .map((e) => int.parse(e.cal!))
          .reduce((value, element) => value + element);
      update();
    }
  }

  checkeat() async {
    var totelCal =
        double.parse(HomeFoodController.totelCalEat.value.toString());
    var goal = GoalController.goalData[0].goalCal!;
    var result = goal - totelCal;
    if (result == 0) {
      await FirebaseMessaging.instance.subscribeToTopic("app");
    } else if (result < 250) {
      await showNotificationEat02();
      await FirebaseMessaging.instance.unsubscribeFromTopic("app");
    } else {
      await showNotificationEat01();
      await FirebaseMessaging.instance.unsubscribeFromTopic("app");
    }
  }

  calculateCelRemain() {
    if (HomeFoodController.totelCalEat.value != 0 &&
        GoalController.goalData[0].goalCal != 0.0) {
      var totelCal =
          double.parse(HomeFoodController.totelCalEat.value.toString());
      var goal = GoalController.goalData[0].goalCal!;
      var result = goal - totelCal;
      if (result <= 0) {
        var totel = result * -1;
        return "ปริมาณที่เกิน\n   ${totel.toStringAsFixed(0)}\n   แคลอรี่";
      } else {
        return "   คงเหลือ\n   ${result.toStringAsFixed(0)}\n   แคลอรี่";
      }
    } else {
      return "  คงเหลือ\n ${GoalController.goalData[0].goalCal}\n   แคลอรี่";
    }
  }

  Color checkcolor() {
    if (HomeFoodController.totelCalEat.value == 0.0) {
      return AppColor.platinum;
    } else if ((100 - HomeFoodController.totelCalEat.value.toDouble()) *
            360 /
            100 >
        GoalController.goalData[0].goalCal! * 360 / 100) {
      return Colors.redAccent;
    } else {
      return AppColor.green;
    }
  }

  getdata() async {
    if (GoalController.goalData.isNotEmpty) {
      data.value = <CircularStackEntry>[
        CircularStackEntry([
          CircularSegmentEntry(
              (100 - HomeFoodController.totelCalEat.value.toDouble()) *
                  360 /
                  100,
              checkcolor()),
          CircularSegmentEntry(GoalController.goalData[0].goalCal! * 360 / 100,
              AppColor.platinum)
        ]),
      ].obs;
      Get.forceAppUpdate();
    }
  }

  gotolistfood() {
    Get.to(() => const NavigationBarPage())!.then((value) {
      if (value == true) {
        Get.forceAppUpdate();
        update();
      }
    });
  }

  Future<void> showNotificationEat02() async {
    final shared = await SharedPreferences.getInstance();
    bool chackShared = shared.getBool('notisetting') ?? true;
    if (chackShared == true) {
      AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/iconapp'));
      await flutterLocalNotificationsPlugin.show(
        0,
        'ใกล้จะรับประทานอาหารถึงเป้าหมายแล้ว',
        'ตอนนี้ใกล้จะรับประทานอาหารถึงเป้าหมายแล้วครับ',
        platformChannelSpecifics,
      );
    }
  }

  Future<void> showNotificationEat01() async {
    final shared = await SharedPreferences.getInstance();
    bool chackShared = shared.getBool('notisetting') ?? true;
    if (chackShared == true) {
      AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/iconapp'));
      await flutterLocalNotificationsPlugin.show(
        0,
        'รับประทานอาหารน้อยกว่าที่กำหนด',
        'ระวังเป้าหมายจะไม่สำเร็จหากไม่ทานอาหารตามเป้าหมายนะครับ',
        platformChannelSpecifics,
      );
    }
  }
}
