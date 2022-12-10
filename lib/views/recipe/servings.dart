import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_text_form_field.dart';

import '../../providers/recipe_provider.dart';

class Servings extends StatefulWidget {
  const Servings({Key? key}) : super(key: key);

  @override
  State<Servings> createState() => _ServingsState();
}

class _ServingsState extends State<Servings> {

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.read<RecipeProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Servings',style: Theme.of(context).textTheme.titleMedium),
        Text('How many adults will this serve?', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 10,),
        AppTextFormField(
            controller: recipeProvider.servingController,
            hintText: 'Enter servings',
            keyboardType: TextInputType.number),
      ],
    );
  }
}
