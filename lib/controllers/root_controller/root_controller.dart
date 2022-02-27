import 'package:comic_app/views/screens/history/history_screen.dart';
import 'package:comic_app/views/screens/home/home_screen.dart';
import 'package:comic_app/views/screens/notification/favorite_screen.dart';
import 'package:comic_app/views/screens/profile/account_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  int _tabIndex = 0;

  final List<Widget> _screen = [
    HomeScreen(),
    HistoryScreen(),
    FavoriteScreen(),
    AccountScreen(),
  ];

  get getcurrtentTab {
    return _tabIndex;
  }

  get currentScreen {
    return _screen[_tabIndex];
  }

  void setCurrentTab(int index) {
    _tabIndex = index;
    update();
  }
}
