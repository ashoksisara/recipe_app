import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe_model.dart';

import '../../common/widgets/app_image_placeholder.dart';

class RecipeInfo extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeInfo({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        color: Colors.purple),
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
                        Text(recipe.recipeName,style: Theme.of(context).textTheme.titleMedium),
                        Text(recipe.recipeDescription,style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Servings',style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 10,
              ),
              Text(recipe.servings,style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(
                height: 20,
              ),
              Text('Preparation time',style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 10,
              ),
              Text('${recipe.preparationTime}min',style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(
                height: 20,
              ),
              Text('Cooking time',style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 10,
              ),
              Text('${recipe.cookingTime}min',style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(
                height: 20,
              ),
              Text('Ingredients',style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recipe.ingredientList.length,
                itemBuilder: (context, index) {
                  final ingredient = recipe.ingredientList[index];
                  return ListTile(
                    title: Text(ingredient.name),
                    subtitle: Text(ingredient.amount),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20,);
              },
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Steps',style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: recipe.stepList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final step = recipe.stepList[index];
                  return ListTile(
                    leading: step.imageUrl !=null && step.imageUrl!.isNotEmpty
                        ? SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          step.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const AppImagePlaceHolder();
                          },
                        ),
                      ),
                    )
                        : const AppImagePlaceHolder(),
                    title: Text(step.name),
                    subtitle: Text(step.instruction),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20,);
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
