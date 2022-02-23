import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliverDelegate extends SliverPersistentHeaderDelegate {
  SliverDelegate(
      {required this.maxHeight,
      required this.view,
      required this.comment,
      required this.minheight,
      required this.comicName,
      required this.tabController,
      required this.isFavorite,
      required this.imageUrl});
  final double maxHeight;
  final double minheight;
  final String imageUrl;
  final String view;
  final String comment;
  final String comicName;
  late TabController tabController;
  bool isFavorite;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: [
        Expanded(
          child: Stack(fit: StackFit.expand, children: [
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.black,
            ),
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
                comicName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        Colors.white.withOpacity(titleOpacity(shrinkOffset))),
              ),
              bottom: 10,
              left: 15,
            ),
            Positioned(
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.eye,
                    color: Colors.deepOrange
                        .withOpacity(titleOpacity(shrinkOffset)),
                  ),
                  Text(view,
                      style: TextStyle(
                          color: Colors.white
                              .withOpacity(titleOpacity(shrinkOffset)))),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    CupertinoIcons.bubble_left_bubble_right,
                    color: Colors.pink.withOpacity(titleOpacity(shrinkOffset)),
                  ),
                  Text(comment,
                      style: TextStyle(
                          color: Colors.white
                              .withOpacity(titleOpacity(shrinkOffset))))
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
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              left: 15,
              top: 15,
            ),
            Positioned(
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  (isFavorite == true)
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart_slash_fill,
                  // Icons.favorite_border_sharp,
                  color: Colors.white,
                ),
              ),
              right: 15,
              top: 15,
            ),
          ]),
        ),
        Container(
          color: Colors.white,
          height: 50,
          width: double.maxFinite,
          child: Align(
            alignment: Alignment.center,
            child: TabBar(
                labelColor: Colors.red,
                unselectedLabelColor: Colors.black54,
                controller: tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.red,
                tabs: [
                  Tab(
                    text: "Chi tiết",
                  ),
                  Tab(
                    text: "Danh sách chương",
                  ),
                ]),
          ),
        )
      ],
    );
  }

  double titleOpacity(double shinkOffset) {
    return 1.0 - shinkOffset / maxExtent;
  }

  double imageOpacity(double shinkOffset) {
    return (shinkOffset / maxExtent) * 5;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minheight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
