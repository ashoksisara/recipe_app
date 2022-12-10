import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_elevated_button.dart';

import '../../../providers/recipe_provider.dart';
import 'add_ingredient.dart';

class Ingredient extends StatelessWidget {
  const Ingredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Ingredients'),
          const Text('Please include all ingredients required'),
          const SizedBox(
            height: 20,
          ),
          Consumer<RecipeProvider>(builder: (context, provider, _) {
            if (provider.ingredientList.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: provider.ingredientList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(provider.ingredientList[index].name),
                    trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          provider.removeIngredient(provider.ingredientList[index]);
                        }),
                  );
                },
              );
            }
            return const SizedBox();
          }),
          const SizedBox(
            height: 20,
          ),
          AppElevatedButton(
            text: 'Add ingredient',
            textColor: Colors.white,
            buttonColor: Colors.blue,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddIngredient(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
