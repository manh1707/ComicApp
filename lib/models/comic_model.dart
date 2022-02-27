import 'package:comic_app/models/chap_model.dart';
import 'package:comic_app/models/comment_model.dart';

class ComicModel {
  String id;
  String name;
  String description;
  String imageURL;
  String author;
  List<ChapModel> chaps;
  DateTime upDateDay;
  String hotImage;
  List<CommentModel> comments;
  bool isDone;
  ComicModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.author,
    required this.comments,
    required this.hotImage,
    required this.chaps,
    required this.upDateDay,
    required this.isDone,
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
      'comment': comments,
      'isDone': isDone
    };
  }

  ChapModel getChap(String id) {
    return chaps.firstWhere((element) => element.id == id);
  }

  int get CommentAmount {
    return comments.length;
  }

  int get totalView {
    int view = 0;
    if (chaps.isNotEmpty)

      // ignore: curly_braces_in_flow_control_structures
      for (var element in chaps) {
        view += element.chapView!;
      }
    return view;
  }

  factory ComicModel.fromJson(id, Map<String, dynamic> map) {
    return ComicModel(
      id: id,
      name: map['name'],
      description: map['description'],
      imageURL: map['imageURL'],
      hotImage: map['hotImage'],
      author: map['author'] ?? " ",
      chaps:
          List<ChapModel>.from(map['chap'].map((x) => ChapModel.fromJson(x))),
      upDateDay: map['updateDay'] ?? DateTime.now(),
      comments: (map['comment'] == null)
          ? []
          : List<CommentModel>.from(
              map['comment'].map((x) => CommentModel.fromJson(x))),
      isDone: map['isDone'] ?? false,
    );
  }

  @override
  String toString() {
    return '(ID:$id,Name:$name)';
  }
}
