import 'package:comic_app/controllers/auth_controller/auth_controller.dart';
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
    final firstNamelField = TextFormField(
      autofocus: false,
      controller: userNameController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        userNameController.text = value!;
      },
      validator: (value) {
        RegExp regExp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return "Tên không thể để trống";
        }
        if (!regExp.hasMatch(value)) {
          return "Tên phải có ít nhất 3 kí tự";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.account_circle),
        hintText: 'Tên của bạn là ',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Hãy nhập email của bạn";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Hãy nhập email hợp lệ");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.mail),
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final passField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passController,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return "Hãy nhập mậu khẩu";
        }
        if (!regExp.hasMatch(value)) {
          return "Hãy nhập mật khẩu hợp lệ";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        passController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.vpn_key),
        hintText: 'Mật Khẩu',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final confirmpassField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmpassController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        confirmpassController.text = value!;
      },
      validator: (value) {
        // ignore: unrelated_type_equality_checks
        if (confirmpassController.text.length == passController.text) {
          return 'Mật khẩu không trùng khớp';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.vpn_key),
        hintText: 'Nhập lại mật khẩu',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
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
                firstNamelField,
                const SizedBox(
                  height: 25,
                ),
                emailField,
                const SizedBox(
                  height: 25,
                ),
                passField,
                const SizedBox(
                  height: 25,
                ),
                confirmpassField,
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
