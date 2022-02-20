import 'package:comic_app/models/comic_model.dart';
import 'package:comic_app/views/screens/history/history_screen.dart';
import 'package:comic_app/views/screens/home/home_screen.dart';
import 'package:comic_app/views/screens/notification/notifiaction_screen.dart';
import 'package:comic_app/views/screens/profile/account_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../services/api_service.dart';

class RootController extends GetxController {
  var _tabIndex = 0;
  var isLoading = true.obs;
  var comicList = List<ComicModel>.empty(growable: true).obs;
  @override
  void onInit() async {
    await fetchAllComic();
    super.onInit();
  }

  ComicModel findByID(String id) {
    return comicList.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAllComic() async {
    try {
      isLoading(true);
      List<ComicModel> lists = await ApiService().fetchComic();
      comicList.assignAll(lists);
      update();
    } finally {
      isLoading(false);
    }
  }

  final List<Widget> _screen = [
    HomeScreen(),
    HistoryScreen(),
    NotificationScreen(),
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
