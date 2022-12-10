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
        const Text('Servings'),
        const Text('How many adults will this serve?'),
        const SizedBox(height: 20,),
        AppTextFormField(
            controller: recipeProvider.servingController,
            hintText: 'Enter servings',
            keyboardType: TextInputType.number),
      ],
    );
  }
}
