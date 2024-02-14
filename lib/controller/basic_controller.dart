import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_mobile/model/food_mobel.dart';
import 'package:project_mobile/model/user_model.dart';

class GetData extends GetxController {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static RxList<UserModel> userData = <UserModel>[].obs;
  RxList<FoodModel> foodData = <FoodModel>[].obs;

  static Future getdata() async {
    DocumentSnapshot userExists =
        await firestore.collection('UserData').doc(auth.currentUser!.uid).get();
    if (userExists.exists && userData.isEmpty) {
      Map<String, dynamic> data = userExists.data() as Map<String, dynamic>;
      userData.add(UserModel(
          userID: data['userID'],
          userEmail: data["userEmail"],
          userName: data["userName"],
          userBirthDay: data["userBirthDay"],
          userGender: data["userGender"],
          userImageURL: data["userImageURL"],
          userType: data["userType"],
          userHigh: data["userHigh"],
          userWeight: data["userWeight"],
          userActivity: data["userActivity"]));
      userData.refresh();
    }
  }

  void updateUserData(List<UserModel> newData) {
    userData.assignAll(newData);
  }
}
