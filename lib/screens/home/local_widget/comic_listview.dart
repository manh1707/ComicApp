import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/main.dart';
import 'package:comic_app/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'comic_item.dart';

class ComicListView extends StatelessWidget {
  const ComicListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ComicController controller = Get.find();
    List<ComicModel> list = controller.comicList;
    double height = 300;
    return Stack(children: [
      SizedBox(
        height: height,
        child: ListView.builder(
            padding: const EdgeInsets.only(right: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemExtent: 200,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.detail, arguments: list[index].id);
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ComicItems(
                      withSize: 0.8 * height,
                      heightSize: height,
                      comicName: list[index].name,
                      description: list[index].description,
                      imageUrl: list[index].imageURL,
                    )),
              );
            }),
      ),
      Positioned(
        right: 8,
        top: 110.0,
        child: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    ]);
  }
}
