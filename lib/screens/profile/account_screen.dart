import 'package:comic_app/controllers/auth_controller/auth_controller.dart';
import 'package:comic_app/screens/profile/local_widget/account_funtion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  AuthController authController = Get.find();

  AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final signIpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Get.toNamed(Routes.login);
        },
        child: const Text(
          'Đăng nhập',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return GetBuilder<AuthController>(
        builder: (controller) => (controller.isAuth == true)
            ? AccountFunction(user: controller.currentUser.value)
            : Center(
                child: Container(
                    padding: const EdgeInsets.all(36),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn chưa đăng nhập!!!',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        signIpButton,
                      ],
                    ))));
  }
}
