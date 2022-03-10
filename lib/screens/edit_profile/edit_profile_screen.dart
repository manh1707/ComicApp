import 'dart:io';
import 'package:comic_app/controllers/auth_controller/auth_controller.dart';
import 'package:comic_app/main.dart';
import 'package:comic_app/services/firebase_storage.dart';
import 'package:comic_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  AuthController authController = Get.find();
  TextEditingController nameController = TextEditingController();

  File? _image;
  final imagePicker = ImagePicker();
  String? avatarUrl;
  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        Get.snackbar("Error", 'No file selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 50, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _image == null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(authController
                                .currentUser.value.avatarURl
                                .toString()),
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            child: Image.file(_image!),
                          ),
                    TextButton.icon(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: () {
                          imagePickerMethod();
                        },
                        icon: Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Thay đổi avatar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Thay đổi tên',
                  style: Mytheme.textLogin,
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autofocus: false,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: authController.currentUser.value.userName,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_image != null) {
                          avatarUrl = await Storage().uploadImage(
                            authController.currentUser.value.id.toString(),
                            _image,
                          );
                        }
                        authController
                            .editProfile(
                              avatarUrl,
                              nameController.text,
                            )
                            .then((value) => Get.offNamed(Routes.root));
                      },
                      child: Text(
                        'Xác nhân thay đổi',
                        style: Mytheme.textLogin.copyWith(color: Colors.white),
                      )),
                )
              ],
            )),
      ),
    );
  }
}
