import 'package:comic_app/models/comic_model.dart';
import 'package:comic_app/views/screens/comic_details/local_widget/list_of_chap.dart';
import 'package:comic_app/views/screens/comic_details/local_widget/detail_comic.dart';
import 'package:comic_app/views/screens/comic_details/local_widget/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/comic_controller/comic_controller.dart';

class ComicDetailScreen extends StatefulWidget {
  @override
  State<ComicDetailScreen> createState() => _ComicDetailScreenState();
}

class _ComicDetailScreenState extends State<ComicDetailScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    String id = Get.arguments;
    final ComicController controller = Get.find();
    final ComicModel model = controller.findByID(id);
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: SliverDelegate(
                  maxHeight: 300,
                  minheight: 100,
                  isFavorite: true,
                  comicName: model.name,
                  imageUrl: model.imageURL,
                  view: model.totalView.toString(),
                  comment: '155',
                  tabController: tabController),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            DetailComic(
              decription: model.description.toString(),
              comments: model.comments,
            ),
            ListOfChap(
              listofChap: model.chaps,
            ),
          ],
        ),
      ),
    );
  }
}
