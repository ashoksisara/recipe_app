import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/app/app_snackbar.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/providers/home_provider.dart';
import 'package:recipe_app/services/firebase_service/firebase_service.dart';

import '../model/ingredient_model.dart';
import '../model/step_model.dart';

class RecipeProvider extends ChangeNotifier {
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController recipeDescriptionController =
      TextEditingController();
  final TextEditingController servingController = TextEditingController();
  final TextEditingController prepTimeController = TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  XFile? recipeImage;

  List<IngredientModel> ingredientList = [];
  List<StepModel> stepList = [];
  List<RecipeModel> recipeList = [];
  bool isLoading = false;

  void addIngredient(IngredientModel ingredient) {
    ingredientList.add(ingredient);
    notifyListeners();
  }

  void addStep(StepModel step) {
    stepList.add(step);
    notifyListeners();
  }

  void removeStep(StepModel step) {
    stepList.remove(step);
    notifyListeners();
  }

  void removeIngredient(IngredientModel ingredient) {
    ingredientList.remove(ingredient);
    notifyListeners();
  }

  void setRecipeImage(XFile? file){
    recipeImage = file;
    notifyListeners();
  }

  Future<void> onSaveRecipe(BuildContext context) async {
    if (recipeNameController.text.isEmpty) {
      AppSnackBar.showSnackBar(
          context, 'Please add recipe name before saving');
    } else if (servingController.text.isEmpty) {
      AppSnackBar.showSnackBar(context, 'Please add servings');
    } else if (prepTimeController.text.isEmpty) {
      AppSnackBar.showSnackBar(context, 'Please add preparation time');
    } else if (cookingTimeController.text.isEmpty) {
      AppSnackBar.showSnackBar(context, 'Please add cooking time');
    } else if (ingredientList.isEmpty) {
      AppSnackBar.showSnackBar(
          context, 'Please add at least one ingredient');
    } else {
      isLoading = true;
      notifyListeners();
      RecipeModel recipe = RecipeModel(
          recipeName: recipeNameController.text.trim(),
          recipePhotoUrl: '',
          recipeDescription: recipeDescriptionController.text.trim(),
          servings: servingController.text.trim(),
          preparationTime: prepTimeController.text.trim(),
          cookingTime: cookingTimeController.text.trim(),
          ingredientList: ingredientList,
          stepList: stepList);
      if(recipeImage != null){
        String? url = await FirebaseService.uploadImage(File(recipeImage!.path),recipeImage!.name);
        print('url -> $url');
        if(url != null){
          recipe.recipePhotoUrl = url;
        }
      }
      debugPrint('recipe tojson -> ${recipe.toJson()}');
      debugPrint('recipe ingre -> ${recipe.ingredientList}');
      FirebaseService.addRecipe(recipe).then((value) {
        final homeProvider = Provider.of<HomeProvider>(context,listen: false);
        homeProvider.onBottomItemChange(1);
        AppSnackBar.showSnackBar(context, 'Recipe added successfully!');
        clearValues();
        isLoading = false;
      });
    }
    notifyListeners();
  }

  Future<void> getRecipeList() async{
    isLoading = true;
   List<RecipeModel> recipeList =  await FirebaseService.getRecipes();
   debugPrint('recipeList firebase-> ${recipeList.length}');
   this.recipeList = recipeList;
    isLoading = false;
   notifyListeners();
  }


  void clearValues(){
    recipeNameController.clear();
    recipeDescriptionController.clear();
    servingController.clear();
    prepTimeController.clear();
    cookingTimeController.clear();
    ingredientList.clear();
    stepList.clear();
    recipeImage = null;
  }
}
