class GoalModel {
  double? goalBMI;
  double? goalBMR;
  double? goalTDEE;
  double? goalCal;
  double? goalBurn;
  double? goalWeight;
  double? goalDay;
  String? goalStartDate;
  String? goalEndDate;

  GoalModel({
    required this.goalBMI,
    required this.goalBMR,
    required this.goalTDEE,
    required this.goalCal,
    required this.goalBurn,
    required this.goalWeight,
    required this.goalDay,
    required this.goalStartDate,
    required this.goalEndDate,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      goalBMI: json['goalBMI'],
      goalBMR: json['goalBMR'],
      goalTDEE: json['goalTDEE'],
      goalCal: json['goalCal'],
      goalBurn: json['goalBurn'],
      goalWeight: json['goalWeight'],
      goalDay: json['goalDay'],
      goalStartDate: json['goalStartDate'],
      goalEndDate: json['goalEndDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        "goalBMI": goalBMI,
        "goalBMR": goalBMR,
        "goalTDEE": goalTDEE,
        "goalCal": goalCal,
        "goalBurn": goalBurn,
        "goalWeight": goalWeight,
        "goalDay": goalDay,
        'goalStartDate': goalStartDate,
        'goalEndDate': goalEndDate,
      };
}
