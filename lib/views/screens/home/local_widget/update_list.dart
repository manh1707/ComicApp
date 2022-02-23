import 'package:comic_app/main.dart';
import 'package:comic_app/views/screens/home/local_widget/comic_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/comic_controller/comic_controller.dart';

class Updatelist extends StatelessWidget {
  const Updatelist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ComicController controller = Get.find();
    return GridView.builder(
        itemCount: 4,
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.detail,
                  arguments: controller.comicList.value[index].id);
            },
            child: ComicItems(
              withSize: 250,
              heightSize: 300,
              comicName: controller.comicList.value[index].name,
              description: controller.comicList.value[index].description,
              imageUrl: controller.comicList.value[index].imageURL,
            ),
          );
        });
  }
}
