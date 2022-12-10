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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Ingredients',style: Theme.of(context).textTheme.titleMedium),
            Text('Please include all ingredients required',style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(
              height: 20,
            ),
            Consumer<RecipeProvider>(builder: (context, provider, _) {
              if (provider.ingredientList.isNotEmpty) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.ingredientList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(provider.ingredientList[index].name,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text(provider.ingredientList[index].amount,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            provider.removeIngredient(provider.ingredientList[index]);
                          }),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 20,);
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddIngredient(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
