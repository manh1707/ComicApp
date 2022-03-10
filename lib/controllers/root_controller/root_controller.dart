import 'package:comic_app/screens/forum/forum_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../screens/favorite/favorite_screen.dart';
import '../../screens/history/history_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/account_screen.dart';

class RootController extends GetxController {
  int _tabIndex = 0;

  final List<Widget> _screen = [
    HomeScreen(),
    HistoryScreen(),
    FavoriteScreen(),
    ForumScreen(),
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
