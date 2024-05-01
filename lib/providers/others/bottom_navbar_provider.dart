import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int currentIndex = 0;
  set index(int index) {
    currentIndex = index;
    notifyListeners();
  }

  int get index {
    return currentIndex;
  }
}
