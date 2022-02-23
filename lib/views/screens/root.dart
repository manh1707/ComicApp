import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/views/screens/widget/Loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/root_controller/root_controller.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ComicController comicController = Get.find();
    RootController rootController = Get.find();
    return Obx(() => (comicController.isLoading == true)
        ? LoadingIndicator()
        : GetBuilder<RootController>(
            builder: (_) => Scaffold(
              body: rootController.currentScreen,
              bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.lightBlue,
                showUnselectedLabels: false,
                currentIndex: rootController.getcurrtentTab,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  rootController.setCurrentTab(index);
                },
                items: [
                  _bottomNavigationItem(Icons.home, 'Home'),
                  _bottomNavigationItem(Icons.history, 'History'),
                  _bottomNavigationItem(Icons.notifications, 'Notification'),
                  _bottomNavigationItem(Icons.person, 'Me')
                ],
              ),
            ),
          ));
  }
}

_bottomNavigationItem(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}
