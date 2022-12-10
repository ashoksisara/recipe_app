import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

import '../../../common/app/app_bottom_sheet.dart';
import '../../../common/widgets/app_image_selection.dart';
import '../../../common/widgets/app_text_form_field.dart';
import '../cooking_time.dart';
import '../preparation_time.dart';
import '../servings.dart';

class RecipeDescription extends StatefulWidget {
   const RecipeDescription({Key? key}) : super(key: key);

  @override
  State<RecipeDescription> createState() => _RecipeDescriptionState();
}

class _RecipeDescriptionState extends State<RecipeDescription> {

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.read<RecipeProvider>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: (){
                  FocusScope.of(context).unfocus();
                  AppBottomSheet.showImageSelectionSheet(context,
                      onCamera: (file) {
                        debugPrint('file ---> ${file?.name}');
                        recipeProvider.setRecipeImage(file);
                        Navigator.of(context).pop();
                      }, onGallery: (file) {
                        debugPrint('file ---> ${file?.name}');
                        recipeProvider.setRecipeImage(file);
                        Navigator.of(context).pop();
                      });
                },
              child: Consumer<RecipeProvider>(
                builder: (context, provider, chile) {
                  return AppImageSelection(
                    file: provider.recipeImage,
                  );
                },
              ),
            ),
            const SizedBox(height: 20,),
            const Text('Recipe Name'),
            AppTextFormField(
                controller: recipeProvider.recipeNameController,
                hintText: 'Enter name'),
            const SizedBox(height: 20,),
            const Text('Recipe description'),
            AppTextFormField(
                controller: recipeProvider.recipeDescriptionController,
                hintText: ''
                    'Enter recipe description'),
            const SizedBox(height: 20,),
            const Servings(),
            const SizedBox(height: 20,),
            const PreparationTime(),
            const SizedBox(height: 20,),
            const CookingTime(),
          ],
        ),
      ),
    );
  }
}
