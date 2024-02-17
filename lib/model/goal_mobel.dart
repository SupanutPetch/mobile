class GoalModel {
  double? goalBMI;
  int? goalBMR;
  int? goalTDEE;
  int? goalCal;
  int? goalBurn;
  int? goalWeight;
  int? goalDay;
  int? goalDietPlanning;
  int? goalStartDate;
  int? goalEndDate;

  GoalModel(
      {required this.goalBMI,
      required this.goalBMR,
      required this.goalTDEE,
      required this.goalCal,
      required this.goalBurn,
      required this.goalDietPlanning,
      required this.goalWeight,
      required this.goalDay,
      required this.goalStartDate,
      required this.goalEndDate});

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
        goalBMI: json['goalBMI'],
        goalBMR: json['goalBMR'],
        goalTDEE: json['goalTDEE'],
        goalCal: json['goalCal'],
        goalBurn: json['goalBurn'],
        goalDietPlanning: json['goalDietPlanning'],
        goalWeight: json['goalWeight'],
        goalDay: json['goalDay'],
        goalStartDate: json['goalStartDate'],
        goalEndDate: json['goalEndDate']);
  }

  Map<String, dynamic> toJson() => {
        "goalBMI": goalBMI,
        "goalBMR": goalBMR,
        "goalTDEE": goalTDEE,
        "goalCal": goalCal,
        "goalBurn": goalBurn,
        "goalDietPlanning": goalDietPlanning,
        "goalWeight": goalWeight,
        "goalDay": goalDay,
        'goalStartDate': goalStartDate,
        'goalEndDate': goalEndDate
      };
}
