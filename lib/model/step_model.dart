class StepModel {
  String name;
  String instruction;
  String photo;

  StepModel(
      {required this.name, required this.instruction, required this.photo});

  factory StepModel.fromJson(Map<String, dynamic> json) => StepModel(
        name: json["name"],
        instruction: json["instruction"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "instruction": instruction,
        "photo": photo,
      };
}
