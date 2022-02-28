import 'package:comic_app/controllers/auth_controller/auth_controller.dart';
import 'package:comic_app/views/screens/login/local_widget/confirm_pass_field.dart';
import 'package:comic_app/views/screens/login/local_widget/email_text_field.dart';
import 'package:comic_app/views/screens/login/local_widget/name_field.dart';
import 'package:comic_app/views/screens/login/local_widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          authController.signUp(_formKey, emailController.text,
              passController.text, userNameController.text);
        },
        child: const Text(
          'Đăng kí',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(36),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                NameField(userNameController: userNameController),
                const SizedBox(
                  height: 25,
                ),
                EmailTextField(emailController: emailController),
                const SizedBox(
                  height: 25,
                ),
                PasswordField(passwordController: passController),
                const SizedBox(
                  height: 25,
                ),
                ConfirmPassField(
                    confirmpassController: confirmpassController,
                    passController: passController),
                const SizedBox(
                  height: 25,
                ),
                signUpButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
