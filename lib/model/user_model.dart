class UserModel {
  final String? userID;
  final String? userEmail;
  final String? userName;
  final String? userBirthDay;
  final String? userGender;
  final String? userImageURL;

  UserModel(
      {required this.userID,
      required this.userEmail,
      required this.userName,
      required this.userBirthDay,
      required this.userGender,
      required this.userImageURL});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json["userID"] ?? "",
      userEmail: json["userEmail"] ?? "",
      userName: json["userName"] ?? "",
      userBirthDay: json["userBirthDay"] ?? "",
      userGender: json["userGender"] ?? "",
      userImageURL: json["userImageURL"] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
        "userID": userID,
        "userEmail": userEmail,
        "userName": userName,
        "userBirthDay": userBirthDay,
        "userGender": userGender,
        "userImageURL": userImageURL,
      };
}
