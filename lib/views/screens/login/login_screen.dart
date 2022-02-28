import 'package:comic_app/main.dart';
import 'package:comic_app/views/screens/login/local_widget/email_text_field.dart';
import 'package:comic_app/views/screens/login/local_widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    final signInButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          authController
              .signIn(_formKey, emailController.text, passwordController.text)
              .then((value) {
            Future.delayed(const Duration(seconds: 1), () {
              Get.offAllNamed(Routes.root)!.then((value) {
                Get.snackbar('Thông báo', 'Đăng Nhập thành công');
              });
            });
          });
        },
        child: const Text(
          'Đăng nhập',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(36),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  EmailTextField(emailController: emailController),
                  const SizedBox(
                    height: 25,
                  ),
                  PasswordField(passwordController: passwordController),
                  const SizedBox(
                    height: 36,
                  ),
                  signInButton,
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Bạn không có tài khoản? '),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.signup);
                        },
                        child: const Text(
                          'Đăng kí ngay',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
