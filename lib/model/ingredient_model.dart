class IngredientModel {
  String name;
  String amount;

  IngredientModel({required this.amount, required this.name});

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        name: json["name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
      };
}
