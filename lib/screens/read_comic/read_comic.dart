import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/main.dart';
import 'package:comic_app/models/chap_model.dart';
import 'package:comic_app/models/comic_model.dart';
import 'package:comic_app/screens/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadComicScreen extends StatelessWidget {
  ReadComicScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ComicController comicController = Get.find();
    ComicModel comicModel = Get.arguments[0] as ComicModel;
    int thisChap = Get.arguments[1];
    List<ChapModel> listOfChap = comicModel.chaps;
    List<String> listOfImage = listOfChap[thisChap].chapImageUrl;

    List<String> chapTitle = [];
    listOfChap.forEach(((element) {
      chapTitle.add(element.title.toString());
    }));
    return Scaffold(
      body: ListView.builder(
          itemCount: listOfImage.length + 1,
          itemBuilder: (context, index) {
            if (index < listOfImage.length) {
              return CachedNetworkImage(
                imageUrl: listOfImage[index],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height * 7,
                    width: double.infinity,
                    child: Center(
                      child: LoadingIndicator(),
                    ),
                  );
                },
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (thisChap == 0)
                      ? const SizedBox(
                          width: 30,
                        )
                      : ElevatedButton(
                          child: const Icon(Icons.arrow_back),
                          onPressed: () {
                            comicController.addToHistory(
                                comicModel, (thisChap - 1));
                            comicController.updateChapView(
                                comicModel, (thisChap - 1));
                            Get.offAndToNamed(Routes.read,
                                arguments: [comicModel, (thisChap - 1)]);
                          },
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  DropdownButton<String>(
                    items: chapTitle.map((item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (value) {
                      comicController.addToHistory(
                          comicModel, chapTitle.indexOf(value!));
                      comicController.updateChapView(
                          comicModel, chapTitle.indexOf(value));
                      Get.offAndToNamed(Routes.read,
                          arguments: [comicModel, chapTitle.indexOf(value)]);
                    },
                    value: chapTitle[thisChap],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (thisChap == comicModel.chaps.length - 1) {
                        Get.snackbar('Thông báo ', 'Không còn chương mới',
                            colorText: Colors.red);
                      } else {
                        comicController.addToHistory(
                            comicModel, (thisChap + 1));
                        comicController.updateChapView(
                            comicModel, (thisChap + 1));
                        Get.offAndToNamed(Routes.read,
                            arguments: [comicModel, (thisChap + 1)]);
                      }
                    },
                    child: const Icon(Icons.arrow_forward),
                  )
                ],
              );
            }
          }),
    );
  }
}
