import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/app/app_alert_dialog.dart';
import 'package:recipe_app/common/app/app_snack_bar.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/providers/home_provider.dart';
import 'package:recipe_app/services/firebase_service/firebase_service.dart';

import '../common/app/app_connection.dart';
import '../common/app/shared_preference.dart';
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
  bool reorderIngredient = false;
  bool reorderStep = false;

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

  void setStepImage(StepModel step, XFile? file){
    step.image = file;
    notifyListeners();
  }

  void updateIngredientReorder(){
    reorderIngredient = !reorderIngredient;
    notifyListeners();
  }

  void reorderIngredientData(oldIndex, newIndex){
      if (oldIndex < newIndex){
        newIndex--;
      }
      final item = ingredientList.removeAt(oldIndex);
      ingredientList.insert(newIndex, item);
    notifyListeners();
  }

  void updateStepReorder(){
    reorderStep = !reorderStep;
    notifyListeners();
  }

  void reorderStepListData(oldIndex, newIndex){
    if (oldIndex < newIndex){
      newIndex--;
    }
    final item = stepList.removeAt(oldIndex);
    stepList.insert(newIndex, item);
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
      bool isOnline = await AppConnection.checkConnectivityState();
      if(!isOnline){
        String? recipeData = await AppSharedPref.getSharedPrefRecipeData();
        debugPrint('recipeData : $recipeData');
        if(recipeData != null){
          List<Map<String, dynamic>> recipeListMap = jsonDecode(recipeData);
          debugPrint('recipeListMap : $recipeListMap');
          recipeListMap.add(recipe.toJson());
          await AppSharedPref.saveSharedPrefRecipeData(jsonEncode(recipeListMap))
              .then((value) {
            navigateToRecipeList(context);
            isLoading = false;
          });
        }else{
          debugPrint('empty shared pref');
          List<Map<String, dynamic>> recipeListMap = [];
          recipeListMap.add(recipe.toJson());
          debugPrint('recipeListMap : $recipeListMap');
          AppSharedPref.saveSharedPrefRecipeData(jsonEncode(recipeListMap)).then((value) {
            navigateToRecipeList(context);
            isLoading = false;
          });

        }
      }else{
        await uploadRecipeToDatabase(context,recipe);
      }
      recipeList.add(recipe);
    notifyListeners();
  }
  }

  Future<void> uploadRecipeToDatabase(BuildContext context, RecipeModel recipe) async {
    if (recipeImage != null) {
      String? url = await FirebaseService.uploadImage(
          File(recipeImage!.path), recipeImage!.name);
      if (url != null) {
        recipe.recipePhotoUrl = url;
      }
    }
    if (stepList.isNotEmpty) {
      for (int i = 0; i < stepList.length; i++) {
        if (stepList[i].image != null) {
          String? url = await FirebaseService.uploadImage(
              File(stepList[i].image!.path), (stepList[i].image!.name));
          stepList[i].imageUrl = url;
        }
      }
    }
    FirebaseService.addRecipe(recipe).then((value) {
      navigateToRecipeList(context);
      isLoading = false;
    });
  }

  Future<void> getRecipeList() async{
    isLoading = true;
    notifyListeners();

    bool isOnline = await AppConnection.checkConnectivityState();
    if(isOnline){
      List<RecipeModel> recipeList =  await FirebaseService.getRecipes();
      debugPrint('recipeList database-> ${recipeList.length}');
      this.recipeList = recipeList;
    }else{
      AppSharedPref.getSharedPrefRecipeData().then((recipeData) {
        if (recipeData != null) {
          List recipeListMap = jsonDecode(recipeData);
          debugPrint('recipeListMap : $recipeListMap');
          List<RecipeModel> recipeList = recipeListMap.map((e) => RecipeModel.fromJson(e)).toList();
          this.recipeList = recipeList;
        }
      });
    }
    isLoading = false;
   notifyListeners();
  }

  Future<void> checkStoreRecipe(BuildContext context) async {
    bool isOnline = await AppConnection.checkConnectivityState();
    if(isOnline){
      AppSharedPref.getSharedPrefRecipeData().then((recipeData) {
        debugPrint('checkStoreRecipe : $recipeData');
        if (recipeData != null) {
          AppAlertDialog.showAlertDialog(context,
              alertMessage:
              'Some recipes are not sync with database. Do you want to sync?',
              button1Text: 'No',
              button2Text: 'Sync',
              onTapButton1: Navigator.of(context).pop, onTapButton2: () async {
                syncRecipeData(context,recipeData).then((value) {
                  Navigator.of(context).pop();
                  AppSharedPref.clearSharedPrefRecipeData();
                });
              });
        }
      });
    }
  }

  Future<void> syncRecipeData(context, String recipeData) async{
    debugPrint('recipeData : $recipeData');
    List recipeListMap = jsonDecode(recipeData);
    debugPrint('recipeListMap : $recipeListMap');
    List<RecipeModel> recipeList = recipeListMap.map((e) => RecipeModel.fromJson(e)).toList();
    for(int i=0; i< recipeList.length; i++){
      await uploadRecipeToDatabase(context, recipeList[i]);
    }
  }

  void navigateToRecipeList(BuildContext context){
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.onBottomItemChange(1);
    AppSnackBar.showSnackBar(context, 'Recipe added successfully!');
    clearValues();
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
