import 'package:comic_app/main.dart';
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
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.mail),
        hintText: 'Tài khoản',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final passwordlField = TextFormField(
      obscureText: true,
      autofocus: false,
      controller: passwordController,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return "Please enter pasword";
        }
        if (!regExp.hasMatch(value)) {
          return "Please enter invalid pasword";
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.vpn_key),
        hintText: 'Mật khẩu',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          authController
              .logIn(_formKey, emailController.text, passwordController.text)
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
                  emailField,
                  const SizedBox(
                    height: 25,
                  ),
                  passwordlField,
                  const SizedBox(
                    height: 36,
                  ),
                  loginButton,
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: null_check_always_fails

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
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
