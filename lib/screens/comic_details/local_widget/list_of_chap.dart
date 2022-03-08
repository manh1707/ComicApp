import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/main.dart';
import 'package:comic_app/models/chap_model.dart';
import 'package:comic_app/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfChap extends StatefulWidget {
  ListOfChap({Key? key, required this.comic}) : super(key: key);
  ComicModel comic;

  @override
  State<ListOfChap> createState() => _ListOfChapState();
}

class _ListOfChapState extends State<ListOfChap> {
  bool isNew = false;
  void changeToNew() {
    setState(() {
      isNew = true;
    });
  }

  void changeToOld() {
    setState(() {
      isNew = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ChapModel> listOfChap = widget.comic.chaps;

    ComicController comicController = Get.find();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cập nhật tới chap',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          changeToOld();
                        },
                        child: Text(
                          'Cũ nhất',
                          style: TextStyle(
                              color: (isNew == false)
                                  ? Colors.red
                                  : Colors.black54),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          changeToNew();
                        },
                        child: Text('Mới nhất ',
                            style: TextStyle(
                                color: (isNew == true)
                                    ? Colors.red
                                    : Colors.black54))),
                  ],
                )
              ],
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      comicController.addToHistory(widget.comic, index);
                      comicController.updateChapView(widget.comic, index);
                      Get.toNamed(Routes.read,
                          arguments: [widget.comic, index]);
                    },
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (index + 1).toString() +
                                "." +
                                listOfChap[index].title.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listOfChap[index].upDateDay.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                              Row(children: [
                                GetBuilder<ComicController>(
                                  builder: (controller) => Text(
                                    listOfChap[index].chapView.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ])
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      thickness: 0.5,
                      color: Colors.black54,
                    ),
                itemCount: listOfChap.length)
          ],
        ),
      ),
    );
  }
}
