import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../../themes.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ComicController controller = Get.find();
    List<ComicModel> history = controller.historyComic.reversed.toList();
    List<int> chapHistory = controller.chapHistory.reversed.toList();
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: GetBuilder<ComicController>(builder: (controller) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.read,
                        arguments: [history[index], chapHistory[index]]);
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
                              history[index].imageURL,
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
                            history[index].name,
                            style: Mytheme.textLogin
                                .copyWith(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            'Đọc tiếp chap ${chapHistory[index] + 1}',
                            style:
                                Mytheme.textLogin.copyWith(color: Colors.grey),
                          ),
                        ],
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
