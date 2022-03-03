import 'package:comic_app/main.dart';
import 'package:comic_app/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'local_widget/comic_listview.dart';
import 'local_widget/tab_view.dart';
import 'local_widget/update_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.face_sharp,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.search);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.search,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          'Tìm kiếm manga...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Truyện Đặc Sắc',
                      style: Mytheme.textLogin,
                    ),
                    TabView(),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mới cập nhật',
                          style: Mytheme.textLogin,
                        ),
                        GestureDetector(
                          child: Text(
                            'Xem Tất cả >>>',
                            style: Mytheme.textLogin,
                          ),
                          onTap: () {
                            Get.toNamed(Routes.search);
                          },
                        ),
                      ],
                    ),
                    const Updatelist(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Truyện hot',
                      style: Mytheme.textLogin,
                    ),
                    const ComicListView(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Có thể bạn sẽ thích ',
                      style: Mytheme.textLogin,
                    ),
                  ]),
            )
          ],
        )));
  }
}
