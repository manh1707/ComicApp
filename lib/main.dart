import 'package:comic_app/views/screens/comic_details/comic_details_screen.dart';
import 'package:comic_app/views/screens/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
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
}

final routePages = [
  GetPage(name: Routes.root, page: () => const Root()),
  GetPage(name: Routes.detail, page: () => const ComicDetailScreen())
];
