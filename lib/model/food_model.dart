class FoodModel {
  final String? foodCategory;
  final String? foodName;
  final String? foodQuantity;
  final String? foodCal;
  final String? foodBarcode;
  final String? foodMash0;
  final String? foodMash1;
  final String? foodMash2;
  final String? foodMash3;
  final String? foodMash4;
  final String? foodMash5;
  final String? foodMash6;
  final String? foodMash7;
  final String? foodMash8;
  final String? foodMash9;

  FoodModel({
    required this.foodName,
    required this.foodCategory,
    required this.foodQuantity,
    required this.foodCal,
    required this.foodBarcode,
    this.foodMash0,
    this.foodMash1,
    this.foodMash2,
    this.foodMash3,
    this.foodMash4,
    this.foodMash5,
    this.foodMash6,
    this.foodMash7,
    this.foodMash8,
    this.foodMash9,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodName: json["foodName"] ?? "",
      foodCategory: json["foodCategory"],
      foodQuantity: json["foodQuantity"],
      foodCal: json["foodCal"],
      foodBarcode: json["foodBarcode"],
      foodMash0: json["foodMash0"],
      foodMash1: json["foodMash1"],
      foodMash2: json["foodMash2"],
      foodMash3: json["foodMash3"],
      foodMash4: json["foodMash4"],
      foodMash5: json["foodMash5"],
      foodMash6: json["foodMash6"],
      foodMash7: json["foodMash7"],
      foodMash8: json["foodMash8"],
      foodMash9: json["foodMash9"],
    );
  }

  Map<String, dynamic> toJson() => {
        "foodCategory": foodCategory,
        "foodName": foodName,
        "foodQuantity": foodQuantity,
        "foodCal": foodCal,
        "foodBarcode": foodBarcode,
        "foodMash0": foodMash0,
        "foodMash1": foodMash1,
        "foodMash2": foodMash2,
        "foodMash3": foodMash3,
        "foodMash4": foodMash4,
        "foodMash5": foodMash5,
        "foodMash6": foodMash6,
        "foodMash7": foodMash7,
        "foodMash8": foodMash8,
        "foodMash9": foodMash9,
      };
}
