class ExerciseModel {
  final String? nameExercise;
  final String? detailExercise;
  final String? calExercise;
  final String? benefitsExercise;
  final String? setORtimeExercise;
  final String? imgExercise;
  final String? vdoExercise;

  ExerciseModel({
    required this.nameExercise,
    required this.detailExercise,
    required this.calExercise,
    required this.benefitsExercise,
    required this.setORtimeExercise,
    required this.imgExercise,
    required this.vdoExercise,
  });
  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
        nameExercise: json["nameExercise"] ?? "",
        detailExercise: json["detailExercise"] ?? "",
        calExercise: json["calExercise"] ?? "",
        benefitsExercise: json["benefitsExercise"] ?? "",
        setORtimeExercise: json["setORtimeExercise"] ?? "",
        imgExercise: json["imgExercise"] ?? "",
        vdoExercise: json["vdoExercise"] ?? "");
  }
  Map<String, dynamic> toJson() => {
        "nameExercise": nameExercise,
        "detailExercise": detailExercise,
        "calExercise": calExercise,
        "benefitsExercise": benefitsExercise,
        "setORtimeExercise": setORtimeExercise,
        "imgExercise": imgExercise,
        "vdoExercise": vdoExercise
      };
}
