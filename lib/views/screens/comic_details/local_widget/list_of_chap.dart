import 'package:comic_app/main.dart';
import 'package:comic_app/models/chap_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfChap extends StatelessWidget {
  ListOfChap({Key? key, required this.listofChap}) : super(key: key);
  List<ChapModel> listofChap;
  @override
  Widget build(BuildContext context) {
    bool isNew = false;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cập nhật tới chap',
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Cũ nhất',
                        style: TextStyle(
                            color:
                                (isNew == false) ? Colors.red : Colors.black54),
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
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.read);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (index + 1).toString() +
                              "." +
                              listofChap[index].title.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateTime.now().toIso8601String()),
                            Text(listofChap[index].chapView.toString())
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
              itemCount: listofChap.length)
        ],
      ),
    );
  }
}
