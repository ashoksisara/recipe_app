import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final recipeProvider = Provider.of<RecipeProvider>(context,listen: false);
    recipeProvider.getRecipeList();
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
        if (provider.recipeList.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
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
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.network(recipe.recipePhotoUrl),
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 50,
                            color: Colors.blue,
                            child: const Text('No image',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                                maxLines: 2,
                                textAlign: TextAlign.center),
                          ),
                        ),
                  title: Text(recipe.recipeName),
                  subtitle: Text(recipe.recipeDescription),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                indent: 20,
                endIndent: 20,
                color: Colors.grey,
              );
            },
          );
        } else {
          return const Center(
            child: Text("You haven't created any recipe yet"),
          );
        }
      }),
    );
  }
}
