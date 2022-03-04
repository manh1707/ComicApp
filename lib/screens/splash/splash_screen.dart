import 'dart:ffi';

import 'package:comic_app/main.dart';
import 'package:comic_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToRoot();
    super.initState();
  }

  Future<void> _navigateToRoot() async {
    await Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(Routes.root);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "MangaVN",
              style:
                  Mytheme.textLogin.copyWith(fontSize: 30, color: Colors.white),
            ),
            Text(
              "Thế giới của Manga",
              style:
                  Mytheme.textLogin.copyWith(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
