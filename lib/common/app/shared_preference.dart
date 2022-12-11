import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref{
  static String sharedPrefRecipeKey = 'recipe';

  static Future<bool> saveSharedPrefRecipeData(String recipe) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefRecipeKey, recipe);
  }

  static Future<String?> getSharedPrefRecipeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefRecipeKey);
  }

  static Future<bool> clearSharedPrefRecipeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(sharedPrefRecipeKey);
  }

}
