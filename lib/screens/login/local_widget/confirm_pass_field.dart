import 'package:flutter/material.dart';

class ConfirmPassField extends StatelessWidget {
  ConfirmPassField(
      {required this.confirmpassController,
      required this.passController,
      Key? key})
      : super(key: key);
  TextEditingController confirmpassController;
  TextEditingController passController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmpassController,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        confirmpassController.text = value!;
      },
      validator: (value) {
        // ignore: unrelated_type_equality_checks
        if (confirmpassController.text != passController.text) {
          return 'Mật khẩu không trùng khớp';
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.vpn_key),
        hintText: 'Nhập lại mật khẩu',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
