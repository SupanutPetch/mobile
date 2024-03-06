class NotiModel {
  NotiModel({
    required this.titel,
    required this.body,
    required this.date,
  });

  final String? titel;
  final String? body;
  final String? date;

  factory NotiModel.fromJson(Map<String, dynamic> json) {
    return NotiModel(
      titel: json["titel"] ?? "",
      body: json["body"] ?? "",
      date: json["date"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "titel": titel,
        "body": body,
        "date": date,
      };
}
