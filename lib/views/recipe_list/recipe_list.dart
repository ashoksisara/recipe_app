import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_loader.dart';

import '../../common/widgets/app_image_placeholder.dart';
import '../../providers/recipe_provider.dart';
import 'recipe_info.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recipeProvider =
          Provider.of<RecipeProvider>(context, listen: false);
      recipeProvider.getRecipeList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recipe List'),
      ),
      body: Consumer<RecipeProvider>(builder: (context, provider, _) {
        if (provider.isLoading) {
          return const AppLoader();
        } else if (provider.recipeList.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            itemCount: provider.recipeList.length,
            itemBuilder: (context, index) {
              final recipe = provider.recipeList[index];
              debugPrint('recipe');
              debugPrint('${recipe.ingredientList}');
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecipeInfo(recipe: recipe),
                  ));
                },
                child: ListTile(
                  leading: recipe.recipePhotoUrl.isNotEmpty
                      ? SizedBox(
                          height: 50,
                          width: 50,
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
                  title: Text(recipe.recipeName),
                  subtitle: Text(recipe.recipeDescription),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20,);
            },
          );
        } else {
          return const Center(
            child: Text("No recipe found!"),
          );
        }
      }),
    );
  }
}
