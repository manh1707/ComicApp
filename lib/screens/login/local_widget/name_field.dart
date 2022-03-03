import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  NameField({required this.userNameController, Key? key}) : super(key: key);
  TextEditingController userNameController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
  }
}
