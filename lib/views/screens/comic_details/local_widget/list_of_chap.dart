import 'package:comic_app/models/comic_model.dart';
import 'package:comic_app/views/screens/read_comic/read_comic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfChap extends StatelessWidget {
  ListOfChap({Key? key, required this.comic}) : super(key: key);
  ComicModel comic;

  @override
  Widget build(BuildContext context) {
    final listOfChap = comic.chaps;
    bool isNew = false;
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
                        onTap: () {},
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
                        onTap: () {},
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
                      Get.to(() => ReadComicScreen(),
                          arguments: [listOfChap, index]);
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
                                Text(
                                  listOfChap[index].chapView.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
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
