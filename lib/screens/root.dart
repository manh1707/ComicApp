import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/screens/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import '../../controllers/root_controller/root_controller.dart';

// ignore: use_key_in_widget_constructors
class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ComicController comicController = Get.find();
    RootController rootController = Get.find();
    DateTime timeBackPress = DateTime.now();
    // ignore: unrelated_type_equality_checks
    return Obx(() => (comicController.isLoading == true)
        ? const LoadingIndicator()
        : GetBuilder<RootController>(
            builder: (_) => WillPopScope(
              onWillPop: () async {
                final diferrence = DateTime.now().difference(timeBackPress);
                final isExitingWarning = diferrence >= Duration(seconds: 2);
                timeBackPress = DateTime.now();
                if (isExitingWarning) {
                  Fluttertoast.showToast(msg: 'Ấn lại lần nữa để thoát');
                  return false;
                } else {
                  Fluttertoast.cancel();
                  return true;
                }
              },
              child: Scaffold(
                body: rootController.currentScreen,
                bottomNavigationBar: BottomNavigationBar(
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.blue,
                  showUnselectedLabels: false,
                  currentIndex: rootController.getcurrtentTab,
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    rootController.setCurrentTab(index);
                  },
                  items: [
                    _bottomNavigationItem(Icons.home, 'Trang Chủ'),
                    _bottomNavigationItem(Icons.history, 'Lịch sử đọc'),
                    _bottomNavigationItem(Icons.favorite, 'Yêu thích'),
                    _bottomNavigationItem(Icons.person, 'Tài khoản')
                  ],
                ),
              ),
            ),
          ));
  }
}

_bottomNavigationItem(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}
