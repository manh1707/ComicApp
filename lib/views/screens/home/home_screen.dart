import 'package:comic_app/themes.dart';
import 'package:comic_app/views/screens/home/local_widget/comic_listview.dart';
import 'package:comic_app/views/screens/home/local_widget/update_list.dart';
import 'package:flutter/material.dart';
import 'local_widget/tab_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            TabView(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(bottom: 10, left: 20),
                                hintText: 'Tìm kiếm...',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(Icons.search)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                          onTap: () {},
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
