import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref{
  static String sharedPrefRecipeKey = 'recipe';

  //save recipe data to shared preference
  static Future<bool> saveSharedPrefRecipeData(String recipe) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefRecipeKey, recipe);
  }

  //get recipe data from shared preference
  static Future<String?> getSharedPrefRecipeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefRecipeKey);
  }

  //remove recipe data from shared preference
  static Future<bool> clearSharedPrefRecipeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(sharedPrefRecipeKey);
  }

}
