import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/main.dart';
import 'package:comic_app/views/screens/home/local_widget/comic_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComicListView extends StatelessWidget {
  const ComicListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ComicController controller = Get.find();
    double height = 300;
    return Stack(children: [
      Container(
        height: height,
        child: ListView.builder(
            padding: const EdgeInsets.only(right: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemExtent: 180,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.detail,
                      arguments: controller.comicList.value[index].id);
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ComicItems(
                      withSize: 0.8 * height,
                      heightSize: height,
                      comicName: controller.comicList.value[index].name,
                      description:
                          controller.comicList.value[index].description,
                      imageUrl: controller.comicList.value[index].imageURL,
                    )),
              );
            }),
      ),
      Positioned(
        right: 0,
        top: 100.0,
        child: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              color: Colors.lightBlue, borderRadius: BorderRadius.circular(20)),
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
