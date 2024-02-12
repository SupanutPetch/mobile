class FoodModel {
  final String? foodCategory;
  final String? foodName;
  final String? foodQuantity;
  final String? foodCal;
  final String? foodBarcode;

  FoodModel(
      {required this.foodName,
      required this.foodCategory,
      required this.foodQuantity,
      required this.foodCal,
      required this.foodBarcode});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
        foodName: json["foodName"] ?? "",
        foodCategory: json["foodCategory"],
        foodQuantity: json["foodQuantity"],
        foodCal: json["foodCal"],
        foodBarcode: json["foodBarcode"]);
  }
  Map<String, dynamic> toJson() => {
        "foodCategory": foodCategory,
        "foodName": foodName,
        "foodQuantity": foodQuantity,
        "foodCal": foodCal,
        "foodBarcode": foodBarcode,
      };
}
