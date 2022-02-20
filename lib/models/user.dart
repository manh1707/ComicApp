import 'package:comic_app/models/comic_model.dart';

class User {
  String id;
  String userName;
  List<ComicModel>? followComic;
  User({required this.id, required this.userName, this.followComic});
}
