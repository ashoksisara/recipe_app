import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/app/validation.dart';
import 'package:recipe_app/model/ingredient_model.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

import '../../../common/widgets/app_elevated_button.dart';
import '../../../common/widgets/app_text_form_field.dart';

class AddIngredient extends StatelessWidget {
  AddIngredient({Key? key}) : super(key: key);
  final TextEditingController ingredientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final ingredientFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add ingredient',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: ingredientFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ingredient',style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 10,
              ),
              AppTextFormField(
                  controller: ingredientController,
                  hintText: 'Enter ingredient, e.g. Carrot',
                  validator: AppValidation.fieldEmptyValidation,
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Amount',style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 10,
              ),
              AppTextFormField(
                  controller: amountController,
                  hintText: 'Enter amount, e.g. 25 gms',
                validator: AppValidation.fieldEmptyValidation,
              ),
              const SizedBox(
                height: 40,
              ),
              AppElevatedButton(
                text: 'Save',
                onPressed: () {
                  if(ingredientFormKey.currentState!.validate()){
                    IngredientModel ingredient = IngredientModel(
                      amount: amountController.text.trim(),
                      name: ingredientController.text.trim(),
                    );
                    context.read<RecipeProvider>().addIngredient(ingredient);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
