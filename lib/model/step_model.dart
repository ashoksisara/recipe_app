import 'package:image_picker/image_picker.dart';

class StepModel {
  String name;
  String instruction;
  XFile? image;
  String? imageUrl;

  StepModel(
      {required this.name,
      required this.instruction,
      required this.image,
      required this.imageUrl});

  factory StepModel.fromJson(Map<String, dynamic> json) => StepModel(
        name: json["name"],
        instruction: json["instruction"],
        image: json["image"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "instruction": instruction,
        "imageUrl": imageUrl,
      };
}
