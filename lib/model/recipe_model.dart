import 'ingredient_model.dart';
import 'step_model.dart';

class RecipeModel {
  String recipeName;
  String recipePhotoUrl;
  String recipeDescription;
  String servings;
  String preparationTime;
  String cookingTime;
  List<IngredientModel> ingredientList;
  List<StepModel> stepList;

  RecipeModel(
      {required this.recipeName,
      required this.recipePhotoUrl,
      required this.recipeDescription,
      required this.servings,
      required this.preparationTime,
      required this.cookingTime,
      required this.ingredientList,
      required this.stepList});

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        recipeName: json["recipeName"],
        recipePhotoUrl: json["recipePhotoUrl"],
        recipeDescription: json["recipeDescription"],
        servings: json["servings"],
        preparationTime: json["preparationTime"],
        cookingTime: json["cookingTime"],
        ingredientList: (json["ingredientList"] as List).map((e) => IngredientModel.fromJson(e)).toList(),
        stepList: (json["stepList"] as List).map((e) => StepModel.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "recipeName": recipeName,
        "recipePhotoUrl": recipePhotoUrl,
        "recipeDescription": recipeDescription,
        "servings": servings,
        "preparationTime": preparationTime,
        "cookingTime": cookingTime,
        "ingredientList": ingredientList.map((e) => e.toJson()).toList(),
        "stepList": stepList.map((e) => e.toJson()).toList(),
      };
}
