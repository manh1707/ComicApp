import 'dart:convert';

import 'package:comic_app/models/chap_model.dart';
import 'package:comic_app/models/comment_model.dart';

class ComicModel {
  String? id;
  String? name;
  String? description;
  String? imageURL;
  String? author;
  int? comicView;
  List<ChapModel>? chaps;
  DateTime? upDateDay;
  List<CommentModel>? comment;
  bool? isDone;
  ComicModel({
    this.id,
    this.name,
    this.description,
    this.imageURL,
    this.author,
    this.comicView,
    this.comment,
    this.chaps,
    this.upDateDay,
    this.isDone,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageURL': imageURL,
      'author': author,
      'chap': chaps,
      'updateDay': upDateDay,
      'comment': comment,
      'isDone': isDone
    };
  }

  int get totalView {
    int view = 0;
    if (chaps!.isNotEmpty)

      // ignore: curly_braces_in_flow_control_structures
      for (var element in chaps!) {
        view += element.chapView!;
      }
    return view;
  }

  factory ComicModel.fromJson(Map<String, dynamic> map) {
    return ComicModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageURL: map['imageURL'],
      author: map['author'] ?? " ",
      chaps:
          List<ChapModel>.from(map['chap'].map((x) => ChapModel.fromJson(x))),
      upDateDay: map['updateDay'] ?? DateTime.now(),
      comment: map['comment'] ?? [],
      isDone: map['isDone'] ?? false,
    );
  }

  @override
  String toString() {
    return '(ID:$id,Name:$name)';
  }
}
