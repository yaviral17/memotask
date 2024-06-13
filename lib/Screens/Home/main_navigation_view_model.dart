import 'package:flutter/material.dart';

class MainNavigatorViewModel extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  void setPageController(PageController pageController) {
    this.pageController = pageController;
    notifyListeners();
  }

  void setCurrentIndex(int currentIndex) {
    this.currentIndex = currentIndex;
    notifyListeners();
  }

  PageController getPageController() {
    return pageController;
  }

  int getCurrentIndex() {
    return currentIndex;
  }
}
