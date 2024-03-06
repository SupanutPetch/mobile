// ignore_for_file: unused_local_variable, avoid_print

import 'package:get/get.dart';
import 'package:project_mobile/model/noti_model.dart';

class NotiController extends GetxController {
  RxList<NotiModel> notilist = <NotiModel>[].obs;

  RxBool allowNoti = true.obs;

  // @override
  // void onInit() {
  //   getSharedNoti();
  //   super.onInit();
  //   update();
  // }

  // setSharedNoti(RemoteNotification notification) async {
  //   final shared = await SharedPreferences.getInstance();
  //   await shared.reload();
  //   var chackShared = shared.getString('notilist');
  //   allowNoti.value = shared.getBool("notisetting") ?? true;
  //   if (chackShared != null) {
  //     notilist.value = (jsonDecode(chackShared) as List)
  //         .map((p) => NotiModel.fromJson(p))
  //         .toList();
  //     notilist.refresh();
  //   } else {
  //     notilist.value = [];
  //   }
  //   notilist.refresh();
  //   notilist.add(
  //     NotiModel(
  //         body: notification.body,
  //         titel: notification.title,
  //         time: DateFormat('dd/MM/yyyy HH:mm:ss a')
  //             .format(DateTime.now())
  //             .toString()),
  //   );
  //   if (notilist.isNotEmpty) {
  //     notilist.sort((a, b) => b.time!.compareTo(a.time!));
  //     var dataNotiList = jsonEncode(notilist);
  //     await shared.setString('notilist', dataNotiList);
  //   }
  //   notilist.refresh();
  //   update();
  // }

  // gotoNotiPage() {
  //   // ไปหน้าแจ้งเตือน
  // }
  // gotodetail(String body) async {
  //   if (body != '') {
  //     try {
  //       var docnumber = (body.split('เลขที่เอกสาร : '))[1];
  //       await AssetRepair.getAssetRepairByDocNo(docnumber).then((value) {
  //         if (value.isNotEmpty) {
  //           Get.to(() => RepairDetailPage(), arguments: value[0]);
  //         }
  //       });
  //     } catch (e) {
  //       // ไม่ต้องทำอะไร
  //     }
  //   }
  // }

  // getSharedNoti() async {
  //   final shared = await SharedPreferences.getInstance();
  //   await shared.reload();
  //   allowNoti.value = shared.getBool('notisetting') ?? true;
  //   var sharedNoti = shared.getString('notilist');
  //   if (sharedNoti != null) {
  //     notilist.value = (jsonDecode(sharedNoti) as List)
  //         .map((p) => NotiModel.fromJson(p))
  //         .toList();
  //     notilist.refresh();
  //     update();
  //   }
  // }

  // clearNoti() async {
  //   // ให้ยืนยันก่อน เพราะอยู่ตำแหน่งเดียวกัน
  //   final shared = await SharedPreferences.getInstance();
  //   await shared.remove('notilist');
  //   await shared.reload();
  //   notilist.clear();
  //   notilist.refresh();
  //   getSharedNoti();
  //   debugPrint('ClearNotification Succeed : $notilist');
  //   update();
  // }

  // deleteNoti(int index) async {
  //   notilist.removeAt(index);
  //   final shared = await SharedPreferences.getInstance();
  //   await shared.reload();
  //   final dataNotiList = jsonEncode(notilist);
  //   shared.setString('notilist', dataNotiList);
  //   notilist.refresh();
  //   update();
  // }

  changeNotiSetting() async {
    allowNoti.value = allowNoti.value ? false : true;

    if (allowNoti.value == true) {
    } else {}
    update();
  }
}
