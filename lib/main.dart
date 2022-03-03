import 'package:comic_app/controllers/auth_controller/auth_controller.dart';
import 'package:comic_app/screens/comic_details/comic_details_screen.dart';
import 'package:comic_app/screens/login/login_screen.dart';
import 'package:comic_app/screens/login/signup_screen.dart';
import 'package:comic_app/screens/read_comic/read_comic.dart';
import 'package:comic_app/screens/root.dart';
import 'package:comic_app/screens/search/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/comic_controller/comic_controller.dart';
import 'controllers/root_controller/root_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  // firebaseAppCheck.activate();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return GetMaterialApp(
      color: const Color(0xFFEDEDED),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      getPages: routePages,
      initialRoute: Routes.root,
    );
  }
}

abstract class Routes {
  static const root = '/root';
  static const detail = '/detail';
  static const read = '/read';
  static const login = '/login';
  static const signup = '/signup';
  static const search = '/search';
}

final routePages = [
  GetPage(name: Routes.root, page: () => Root(), binding: RootBinding()),
  GetPage(name: Routes.detail, page: () => ComicDetailScreen()),
  GetPage(name: Routes.read, page: () => ReadComicScreen()),
  GetPage(name: Routes.login, page: () => LoginScreen()),
  GetPage(name: Routes.signup, page: () => RegisterScreen()),
  GetPage(name: Routes.search, page: () => SearchScreen()),
];

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => RootController());
    Get.lazyPut(() => ComicController());
  }
}
