import 'package:comic_app/models/chap_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadComicScreen extends StatelessWidget {
  ReadComicScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChapModel> listOfChap = Get.arguments[0] as List<ChapModel>;
    List<String> listOfImage = listOfChap[Get.arguments[1]].chapImageUrl;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        )),
        body: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listOfImage.length,
              itemBuilder: (context, index) {
                return Image.network(
                  listOfImage[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                );
              }),
        ));
  }
}
