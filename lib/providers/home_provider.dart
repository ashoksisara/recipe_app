import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier{
  int selectedIndex = 0;

  void onBottomItemChange(int index){
    selectedIndex = index;
    notifyListeners();
  }

}