class UserModel {
  final String? userID;
  final String? userEmail;
  final String? userName;
  final String? userBirthDay;
  final String? userGender;
  final String? userImageURL;
  final String? userType;
  final String? userHigh;
  final String? userWeight;
  final String? userActivity;

  UserModel(
      {required this.userID,
      required this.userEmail,
      required this.userName,
      required this.userBirthDay,
      required this.userGender,
      required this.userImageURL,
      required this.userType,
      required this.userHigh,
      required this.userWeight,
      required this.userActivity});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userID: json["userID"] ?? "",
        userEmail: json["userEmail"] ?? "",
        userName: json["userName"] ?? "",
        userBirthDay: json["userBirthDay"] ?? "",
        userGender: json["userGender"] ?? "",
        userImageURL: json["userImageURL"] ?? "",
        userType: json["userType"] ?? "n",
        userHigh: json["userHigh"] ?? "",
        userWeight: json["userWeight"] ?? "",
        userActivity: json["userActivity"] ?? "");
  }
  Map<String, dynamic> toJson() => {
        "userID": userID,
        "userEmail": userEmail,
        "userName": userName,
        "userBirthDay": userBirthDay,
        "userGender": userGender,
        "userImageURL": userImageURL,
        "userType": userType,
        "userhigh": userHigh,
        "userWeight": userWeight,
        "userActivity": userActivity
      };
}
