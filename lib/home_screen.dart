import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/home_provider.dart';
import 'package:recipe_app/views/recipe/create_recipe_screen.dart';

import 'views/recipe_list/recipe_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _widgetOptions = <Widget>[
    CreateRecipeScreen(),
    RecipeList()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Scaffold(
        body: _widgetOptions.elementAt(homeProvider.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: homeProvider.selectedIndex,
          onTap: homeProvider.onBottomItemChange,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: 'Create Recipe'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: 'Recipe List'),
          ],
        ),
      );
    });
  }
}
