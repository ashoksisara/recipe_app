import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/common/widgets/app_loader.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

import 'ingredient/ingredient.dart';
import 'recipe_description/recipe_description.dart';
import 'steps/steps.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create recipe'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<RecipeProvider>().onSaveRecipe(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
          centerTitle: true,
          bottom: TabBar(
            controller: controller,
            tabs: const [
              Tab(
                text: 'Recipe',
              ),
              Tab(
                text: 'Ingredients',
              ),
              Tab(
                text: 'Step',
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: controller,
              children: const [
                RecipeDescription(),
                Ingredient(),
                Steps(),
              ],
            ),
            Consumer<RecipeProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const AppLoader();
                }
                return const SizedBox();
              },
            )
          ],
        ));
  }
}
