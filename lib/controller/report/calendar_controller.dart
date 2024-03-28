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
  String? dateString;
  RxList<CalEatModel> eatEvent = <CalEatModel>[].obs;
  RxList<CalExeciseModel> execiseEvent = <CalExeciseModel>[].obs;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    await getdata();
    await getEatDaily();
    await getExeciseDailyDaily();
    await getevent();
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

  addEventToToday() {
    Set<String> addedDatesForEat = {};
    Set<String> addedDatesForExercise = {};
    for (var date in eatEvent) {
      String dateString = date.date!;
      if (dateString.isNotEmpty && !addedDatesForEat.contains(dateString)) {
        String month = dateString.substring(0, 2);
        String day = dateString.substring(2, 4);
        String year = dateString.substring(4);
        DateTime dateTime =
            DateTime(int.parse(year), int.parse(month), int.parse(day));
        int totalcal = 0;
        for (var event in eatEvent) {
          if (event.date == dateString) {
            totalcal += int.parse(event.cal!);
          }
        }
        addEvent(dateTime, 'eat', colorEventEat(totalcal));
        addedDatesForEat.add(dateString);
      }
    }
    for (var date in execiseEvent) {
      String dateString = date.date!;
      if (dateString.isNotEmpty &&
          !addedDatesForExercise.contains(dateString)) {
        String month = dateString.substring(0, 2);
        String day = dateString.substring(2, 4);
        String year = dateString.substring(4);
        DateTime dateTime =
            DateTime(int.parse(year), int.parse(month), int.parse(day));
        int totalcal = 0;
        for (var event in execiseEvent) {
          if (event.date == dateString) {
            totalcal += int.parse(event.burn!);
          }
        }
        addEvent(dateTime, 'execise', colorEventExecise(totalcal));
        addedDatesForExercise.add(dateString);
      }
    }
    bool allDataProcessed = eatEvent.every((date) => date.date != '') &&
        execiseEvent.every((date) => date.date != '');
    if (!allDataProcessed &&
        (addedDatesForEat.isNotEmpty || addedDatesForExercise.isNotEmpty)) {
      addEventToToday();
    }
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

  getevent() async {
    await geteventEat();
    await geteventExecise();
  }

  geteventEat() async {
    QuerySnapshot querySnapshot = await GetData.firestore
        .collection("UserData")
        .doc(GetData.userData[0].userID!)
        .collection("EatDaily")
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    eatEvent.assignAll(docs.map(
      (data) {
        return CalEatModel(
            food: data["food"], cal: data["cal"], date: data["date"]);
      },
    ));
  }

  Color colorEventEat(int totalcal) {
    int goalCalInt = int.parse((goalperDay[0].goalCal!.toStringAsFixed(0)));
    if (totalcal < goalCalInt) {
      return Colors.redAccent;
    }
    if (totalcal == goalCalInt) {
      return AppColor.green;
    } else {
      return AppColor.orange;
    }
  }

  Color colorEventExecise(int totalcal) {
    int goalBurnInt = int.parse((goalperDay[0].goalBurn!.toStringAsFixed(0)));
    if (totalcal < goalBurnInt) {
      return Colors.redAccent;
    }
    if (totalcal == goalBurnInt) {
      return AppColor.green;
    } else {
      return AppColor.orange;
    }
  }

  geteventExecise() async {
    QuerySnapshot querySnapshot = await GetData.firestore
        .collection("UserData")
        .doc(GetData.userData[0].userID!)
        .collection("ExerciseDaily")
        .get();
    List<DocumentSnapshot> docs = querySnapshot.docs;
    execiseEvent.assignAll(docs.map(
      (data) {
        return CalExeciseModel(
            poses: data["poses"], burn: data["burn"], date: data["date"]);
      },
    ));
  }

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
