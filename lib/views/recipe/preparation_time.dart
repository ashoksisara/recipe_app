import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_text_form_field.dart';

import '../../providers/recipe_provider.dart';

class PreparationTime extends StatefulWidget {
  const PreparationTime({Key? key}) : super(key: key);

  @override
  State<PreparationTime> createState() => _PreparationTimeState();
}

class _PreparationTimeState extends State<PreparationTime> {

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.read<RecipeProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preparation Time (in minutes)',style: Theme.of(context).textTheme.titleMedium),
        Text('How much time does it take to prepare this dish?',style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 10,),
        AppTextFormField(
            controller: recipeProvider.prepTimeController,
            hintText: 'Enter minutes',
            keyboardType: TextInputType.number),
      ],
    );
  }
}
