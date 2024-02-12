class CalExeciseModel {
  String? poses;
  String? burn;
  String? date;
  CalExeciseModel(
      {required this.poses, required this.burn, required this.date});
  factory CalExeciseModel.fromJson(Map<String, dynamic> json) {
    return CalExeciseModel(
        poses: json["poses"], burn: json["burn"], date: json["date"]);
  }
  Map<String, dynamic> toJson() => {"poses": poses, "burn": burn, "date": date};
}
