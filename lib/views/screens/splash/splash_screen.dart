import 'package:comic_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.root);
        },
        child: Container(
          child: Text("Welcome"),
        ),
      ),
    );
  }
}
