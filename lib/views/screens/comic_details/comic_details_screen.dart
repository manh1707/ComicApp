import 'dart:ui';
import 'package:comic_app/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/root_controller/root_controller.dart';

class ComicDetailScreen extends StatelessWidget {
  const ComicDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = Get.arguments;
    final RootController controller = Get.find();
    final ComicModel model = controller.findByID(id);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: SliverDelegate(
                maxHeight: 200,
                minheight: 50,
                imageUrl: model.imageURL.toString(),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Text('data'),
              Container(
                height: MediaQuery.of(context).size.height,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
              ),
              Text('data')
            ]))
          ],
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  SliverDelegate(
      {required this.maxHeight,
      required this.minheight,
      required this.imageUrl});
  final double maxHeight;
  final double minheight;
  final String imageUrl;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Stack(fit: StackFit.expand, children: [
        ClipRRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaX: imageOpacity(shrinkOffset),
                sigmaY: imageOpacity(shrinkOffset)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          child: Text(
            'Comic name',
            style: TextStyle(
                color: Colors.white.withOpacity(titleOpacity(shrinkOffset))),
          ),
          bottom: 10,
          left: 15,
        ),
        Positioned(
          child: Row(
            children: [
              Text('Luot xem',
                  style: TextStyle(
                      color: Colors.white
                          .withOpacity(titleOpacity(shrinkOffset)))),
              Text('Luot binh luan',
                  style: TextStyle(
                      color:
                          Colors.white.withOpacity(titleOpacity(shrinkOffset))))
            ],
          ),
          bottom: 10,
          right: 15,
        ),
        Positioned(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          left: 15,
          top: 15,
        )
      ]),
    );
  }

  double titleOpacity(double shinkOffset) {
    return 1.0 - shinkOffset / maxExtent;
  }

  double imageOpacity(double shinkOffset) {
    return (shinkOffset / maxExtent) * 10;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minheight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
