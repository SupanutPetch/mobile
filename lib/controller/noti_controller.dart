// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kitcal/model/noti_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotiController extends GetxController {
  RxList<NotiModel> notilist = <NotiModel>[].obs;
  RxBool allowNoti = true.obs;

  @override
  void onInit() {
    getSharedNoti();
    super.onInit();
    update();
  }

  setSharedNoti(RemoteNotification notification) async {
    final shared = await SharedPreferences.getInstance();
    await shared.reload();
    var chackShared = shared.getString('notilist');
    allowNoti.value = shared.getBool("notisetting") ?? true;
    if (chackShared != null) {
      notilist.value = (jsonDecode(chackShared) as List)
          .map((p) => NotiModel.fromJson(p))
          .toList();
      notilist.refresh();
    } else {
      notilist.value = [];
    }
    notilist.refresh();
    notilist.add(
      NotiModel(
          body: notification.body,
          titel: notification.title,
          date: DateFormat('dd/MM/yyyy HH:mm:ss a')
              .format(DateTime.now())
              .toString()),
    );
    if (notilist.isNotEmpty) {
      notilist.sort((a, b) => b.date!.compareTo(a.date!));
      var dataNotiList = jsonEncode(notilist);
      await shared.setString('notilist', dataNotiList);
    }
    notilist.refresh();
    update();
  }

  getSharedNoti() async {
    final shared = await SharedPreferences.getInstance();
    await shared.reload();
    allowNoti.value = shared.getBool('notisetting') ?? true;
    var sharedNoti = shared.getString('notilist');
    if (sharedNoti != null) {
      notilist.value = (jsonDecode(sharedNoti) as List)
          .map((p) => NotiModel.fromJson(p))
          .toList();
      notilist.refresh();
      update();
    }
  }

  clearNoti() async {
    final shared = await SharedPreferences.getInstance();
    await shared.remove('notilist');
    await shared.reload();
    notilist.clear();
    notilist.refresh();
    getSharedNoti();
    update();
  }

  deleteNoti(int index) async {
    notilist.removeAt(index);
    final shared = await SharedPreferences.getInstance();
    await shared.reload();
    final dataNotiList = jsonEncode(notilist);
    shared.setString('notilist', dataNotiList);
    notilist.refresh();
    update();
  }

  changeNotiSetting() async {
    final shared = await SharedPreferences.getInstance();
    allowNoti.value = allowNoti.value ? false : true;
    shared.setBool("notisetting", allowNoti.value);
    if (allowNoti.value == true) {
      await FirebaseMessaging.instance.subscribeToTopic("app");
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic("app");
    }
    await shared.reload();
    update();
  }
}
