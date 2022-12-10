import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_text_form_field.dart';

import '../../providers/recipe_provider.dart';

class CookingTime extends StatefulWidget {
  const CookingTime({Key? key}) : super(key: key);

  @override
  State<CookingTime> createState() => _CookingTimeState();
}

class _CookingTimeState extends State<CookingTime> {

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.read<RecipeProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cooking Time(in minutes)'),
        const Text('How much time does it take to cook this dish?'),
        const SizedBox(height: 20,),
        AppTextFormField(
            controller: recipeProvider.cookingTimeController,
            hintText: 'Enter minutes',
            keyboardType: TextInputType.number),
      ],
    );
  }
}
