import 'package:comic_app/main.dart';
import 'package:comic_app/views/screens/comic_details/comic_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComicItems extends StatelessWidget {
  String? imageUrl;
  String? comicName;
  String? description;
  double heightSize;
  double withSize;
  ComicItems(
      {required this.imageUrl,
      required this.heightSize,
      required this.withSize,
      required this.comicName,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: withSize,
      width: heightSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: heightSize * 0.8,
            width: withSize * 0.8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            comicName!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            description!,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
