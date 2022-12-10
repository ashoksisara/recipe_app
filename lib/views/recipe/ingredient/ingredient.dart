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
        child:  Consumer<RecipeProvider>(
            builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ingredients',style: Theme.of(context).textTheme.titleMedium),
                    TextButton(onPressed: (){
                      provider.updateIngredientReorder();
                    }, child: Text(provider.reorderIngredient ? 'Done' :'Reorder'))
                  ],
                ),
                Text('Please include all ingredients required',style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 20,
                ),
                if(provider.ingredientList.isNotEmpty)
                  Theme(
                    data: Theme.of(context).copyWith(
                      shadowColor: Colors.transparent,
                    ),
                    child: ReorderableListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      buildDefaultDragHandles: provider.reorderIngredient,
                      onReorder: provider.reorderIngredientData,
                      children: [
                        for(final ingredient in provider.ingredientList)
                          Container(
                            key: ValueKey(ingredient),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(ingredient.name,
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                              subtitle: Text(ingredient.amount,
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                              trailing: IconButton(
                                  icon: provider.reorderIngredient ?
                                  const Icon(Icons.menu) : const Icon(Icons.clear),
                                  onPressed: () {
                                    if(!provider.reorderIngredient){
                                      provider.removeIngredient(ingredient);
                                    }
                                  }),
                            ),
                          )
                      ],
                    ),
                  )
                else const SizedBox(),
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
            );
          }
        ),
      ),
    );
  }
}
