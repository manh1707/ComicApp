import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  TextEditingController passwordController;

  PasswordField({required this.passwordController, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.vpn_key),
        hintText: 'Mật khẩu',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    ;
  }
}
