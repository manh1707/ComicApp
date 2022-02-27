import 'package:flutter/material.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: SizedBox(
              height: double.maxFinite,
              width: withSize,
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
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
    );
  }
}
