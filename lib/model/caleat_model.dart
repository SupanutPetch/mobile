class CalEatModel {
  String? food;
  String? cal;
  String? date;
  CalEatModel({required this.food, required this.cal, required this.date});
  factory CalEatModel.fromJson(Map<String, dynamic> json) {
    return CalEatModel(
        food: json["food"], cal: json["cal"], date: json["date"]);
  }
  Map<String, dynamic> toJson() => {
        "food": food,
        "cal": cal,
        "date": date,
      };
}
