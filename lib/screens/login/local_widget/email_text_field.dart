import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  EmailTextField({required this.emailController, Key? key}) : super(key: key);
  TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        hintText: 'Email của bạn',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    ;
  }
}
