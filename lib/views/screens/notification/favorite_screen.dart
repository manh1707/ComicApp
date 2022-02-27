import 'package:comic_app/controllers/auth_controller/auth_controller.dart';
import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/main.dart';
import 'package:comic_app/models/comic_model.dart';
import 'package:comic_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    ComicController comicController = Get.find();
    List<ComicModel> favoriteList = [];
    for (var element in authController.userModel.value.favoriteComic!) {
      favoriteList.add(comicController.findComicByID(element));
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: favoriteList.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.detail, arguments: favoriteList[index].id);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: SizedBox(
                          height: 250,
                          width: 180,
                          child: Image.network(
                            favoriteList[index].imageURL,
                            fit: BoxFit.cover,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          favoriteList[index].name,
                          style: Mytheme.textLogin
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                        Text(
                          'Chap mới nhất ${favoriteList[index].chaps.length + 1}',
                          style: Mytheme.textLogin.copyWith(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
