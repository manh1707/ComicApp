import 'package:comic_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FuntionButton extends StatelessWidget {
  const FuntionButton(this.icon, this.text, {Key? key}) : super(key: key);
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          Get.snackbar('Thông báo', "Nạp lần đầu đi");
        },
        icon: icon,
        label: Text(
          text,
          style: Mytheme.textLogin.copyWith(color: Colors.grey),
        ));
  }
}
