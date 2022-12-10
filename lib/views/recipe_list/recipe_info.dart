import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe_model.dart';

import '../../common/widgets/app_image_placeholder.dart';

class RecipeInfo extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeInfo({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('recipe -> ${recipe.ingredientList.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: recipe.recipePhotoUrl.isNotEmpty
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                recipe.recipePhotoUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const AppImagePlaceHolder();
                                },
                              ),
                            ),
                          )
                        : const AppImagePlaceHolder(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.recipeName),
                        Text(recipe.recipeDescription),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Ingredients'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: recipe.ingredientList.length,
                itemBuilder: (context, index) {
                  final ingredient = recipe.ingredientList[index];
                  return ListTile(
                    title: Text(ingredient.name),
                    subtitle: Text(ingredient.amount),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Steps'),
            ],
          ),
        ),
      ),
    );
  }
}
