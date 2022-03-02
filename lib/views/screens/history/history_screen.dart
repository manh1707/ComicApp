import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../../themes.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ComicController comicController = Get.find();
    List<ComicModel> historyComic = comicController.historyComic;

    return (historyComic.isEmpty)
        ? Center(
            child: Text(
              'Chưa có lịch sử đọc',
              style: Mytheme.textLogin.copyWith(color: Colors.red),
            ),
          )
        : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GetBuilder<ComicController>(builder: (controller) {
                  List<ComicModel> historyComicList =
                      comicController.historyComic.reversed.toList();
                  List<int> historyChapList =
                      comicController.chapHistory.reversed.toList();
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: historyComicList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          comicController.addToHistory(
                              historyComicList[index], historyChapList[index]);
                          Get.toNamed(Routes.read, arguments: [
                            historyComicList[index],
                            historyChapList[index]
                          ]);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: SizedBox(
                                  height: 200,
                                  width: 120,
                                  child: Image.network(
                                    historyComicList[index].imageURL,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    historyComicList[index].name,
                                    maxLines: 2,
                                    style: Mytheme.textLogin.copyWith(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Text(
                                    'Đọc tiếp chap ${historyChapList[index] + 1}',
                                    maxLines: 2,
                                    style: Mytheme.textLogin
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                })),
          );
  }
}
