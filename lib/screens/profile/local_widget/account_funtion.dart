import 'package:comic_app/controllers/auth_controller/auth_controller.dart';
import 'package:comic_app/main.dart';
import 'package:comic_app/models/user.dart';
import 'package:comic_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class AccountFunction extends StatelessWidget {
  UserModel user;
  AccountFunction({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.avatarURl.toString()),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      user.userName.toString(),
                      style: Mytheme.textLogin,
                    ),
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'VIP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const FuntionButton(
                Icon(
                  Icons.money,
                  color: Colors.grey,
                ),
                'Nạp tiền '),
            const FuntionButton(
                Icon(
                  Icons.person_add,
                  color: Colors.grey,
                ),
                'Trở thành đối tác '),
            TextButton.icon(
                onPressed: () {
                  Get.toNamed(Routes.editProfile);
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                label: Text(
                  'Chỉnh sửa thông tin cá nhân ',
                  style: Mytheme.textLogin.copyWith(color: Colors.grey),
                )),
            TextButton.icon(
                onPressed: () {
                  Get.defaultDialog(
                      title: 'Bạn có chắc muốn đăng xuất không',
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                                authController.logout();
                              },
                              child: Text(
                                'Yes',
                                style: Mytheme.textLogin
                                    .copyWith(fontSize: 16, color: Colors.red),
                              )),
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'No',
                                style: Mytheme.textLogin.copyWith(
                                    fontSize: 16, color: Colors.black),
                              )),
                        ],
                      ));
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
                label: Text(
                  'Đăng xuất ',
                  style: Mytheme.textLogin.copyWith(color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }
}
