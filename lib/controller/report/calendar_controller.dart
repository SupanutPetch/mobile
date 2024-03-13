import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kitcal/constant/color.dart';
import 'package:kitcal/controller/basic_controller.dart';
import 'package:kitcal/model/caleat_model.dart';
import 'package:kitcal/model/calexecise_model.dart';

import 'package:kitcal/model/goal_model.dart';
import 'package:kitcal/widget.dart';

class Event {
  DateTime date;
  String title;
  Color color;

  Event({required this.date, required this.title, required this.color});
}

class CalenderController extends GetxController with StateMixin {
  RxList<CalEatModel> eatDailyList = <CalEatModel>[].obs;
  RxList<CalExeciseModel> execiseDailyList = <CalExeciseModel>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxList<GoalModel> goalperDay = <GoalModel>[].obs;
  RxList<Event> events = <Event>[].obs;
  RxInt totelCalEat = 0.obs;
  RxInt totelCalExecise = 0.obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getdata();
    await getEatDaily();
    await getExeciseDailyDaily();
    addEventToToday();
    change(null, status: RxStatus.success());
    super.onInit();
    update();
  }

  bool selected(DateTime day) {
    return selectedDate.value.year == day.year &&
        selectedDate.value.month == day.month &&
        selectedDate.value.day == day.day;
  }

  void addEventToToday() {
    DateTime today = DateTime.now();
    String eventContent = 'test';
    addEvent(today, eventContent, AppColor.orange);
  }

  void addEvent(DateTime date, String title, Color color) {
    events.add(Event(date: date, title: title, color: color));
  }

  List<Event> eventsForDay(DateTime day) {
    return events
        .where((event) =>
            event.date.year == day.year &&
            event.date.month == day.month &&
            event.date.day == day.day)
        .toList();
  }

  loadEvents() {}

  getdata() async {
    WidgetAll.loading();
    QuerySnapshot querySnapshot =
        await GetData.firestore.collection("goalData").get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    for (var list in docs) {
      var docid = list.id.split('-');
      if (docid[0] == GetData.userData[0].userID &&
          docid[1].compareTo(
                  DateFormat("yyyyMMdd").format(selectedDate.value)) <=
              0) {
        goalperDay.assignAll(docs.map((data) {
          return GoalModel(
              goalBMI: double.tryParse(data["goalBMI"]),
              goalBMR: double.tryParse(data["goalBMR"]),
              goalTDEE: double.tryParse(data["goalTDEE"]),
              goalCal: double.tryParse(data["goalCal"]),
              goalBurn: double.tryParse(data["goalBurn"]),
              goalWeight: double.tryParse(data["goalWeight"]),
              goalDay: double.tryParse(data["goalDay"].toString()),
              goalStartDate: data["goalStartDate"],
              goalEndDate: data["goalEndDate"]);
        }).toList());
        if (goalperDay[0].goalCal! < 0.0) {
          goalperDay[0].goalCal = goalperDay[0].goalCal! * -1;
        }
        if (Get.isDialogOpen!) {
          Get.back();
        }
        await getEatDaily();
        await getExeciseDailyDaily();
        update();
      }
    }
  }

  getEatDaily() async {
    if (eatDailyList.isNotEmpty) {
      eatDailyList.clear();
    }
    totelCalEat.value = 0;
    var date = DateFormat('MMddyyyy').format(selectedDate.value);
    QuerySnapshot querySnapshot = await GetData.firestore
        .collection("UserData")
        .doc(GetData.userData[0].userID!)
        .collection("EatDaily")
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;

    for (var data in docs) {
      if (data["date"].toString().contains(date)) {
        eatDailyList.add(CalEatModel(
          food: data["food"],
          cal: data["cal"],
          date: data["date"],
        ));
        totelCalEat.value = eatDailyList
            .map((e) => int.parse(e.cal!))
            .reduce((value, element) => value + element);
      }
    }
  }

  getExeciseDailyDaily() async {
    if (execiseDailyList.isNotEmpty) {
      execiseDailyList.clear();
    }
    totelCalExecise.value = 0;
    var date = DateFormat('MMddyyyy').format(selectedDate.value);
    QuerySnapshot querySnapshot = await GetData.firestore
        .collection("UserData")
        .doc(GetData.userData[0].userID!)
        .collection("ExerciseDaily")
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    for (var data in docs) {
      if (data["date"].toString().contains(date)) {
        execiseDailyList.add(CalExeciseModel(
            poses: data["poses"], burn: data["burn"], date: data["date"]));
        totelCalExecise.value = execiseDailyList
            .map((e) => int.parse(e.burn!))
            .reduce((value, element) => value + element);
      }
    }
  }
}
