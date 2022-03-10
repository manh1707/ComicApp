import 'dart:convert';
import 'package:comic_app/models/comic_model.dart';
import 'package:comic_app/models/comment_model.dart';
import 'package:comic_app/models/user.dart';
import 'package:comic_app/services/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> fetchComic() async {
    final response = await http.get(ApiUrl().COMIC_LIST_URL);

    return response;
  }

  Future<UserModel> fetchUser(String id) async {
    UserModel userModel = UserModel();
    final Uri url = Uri.parse(ApiUrl().userURl(id));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final extraData = json.decode(response.body);
      userModel = UserModel.fromJson(id, extraData);
    } else {
      Get.snackbar('Error', 'Có lỗi xảy ra');
    }
    return userModel;
  }

  Future<List<UserModel>> fetchAllUser() async {
    List<UserModel> list = [];
    final response = await http.get(ApiUrl().USER_URL_list);

    if (response.statusCode == 200) {
      final extraData = json.decode(response.body);
      if (extraData != null) {
        extraData.forEach((id, data) {
          list.add(UserModel.fromJson(id, data));
        });
      }
    } else {
      Get.snackbar('Error', 'Có lỗi xảy ra');
    }
    return list;
  }

  Future<dynamic> postCommnent(
      List<CommentModel> commentModel, String comicId) async {
    final Uri url = Uri.parse(ApiUrl().comicCommentURl(comicId));
    var body =
        json.encode(List<dynamic>.from(commentModel.map((e) => e.toJson())));
    var response = await http.put(url, body: body);
    return response;
  }

  Future<dynamic> AddRating(ComicModel comicModel) async {
    final Uri uri = Uri.parse(ApiUrl().comicRatingURL(comicModel.id));
    var body = json.encode(comicModel.rating);
    var response = await http.put(uri, body: body);

    return response;
  }

  Future<dynamic> addFavoriteComic(
      List<String>? favoriteList, String userID) async {
    final Uri url = Uri.parse(ApiUrl().favoriteList(userID));
    var body = json.encode(List<dynamic>.from(favoriteList!.map((e) => e)));
    var response = await http.put(url, body: body);
    return response;
  }

  Future<dynamic> postDetailToFirestore(UserModel userModel, String uid) async {
    final Uri url = Uri.parse(ApiUrl().API_URL + "user/" + uid + ".json");
    var body = json.encode(userModel.toJson());
    var responce = await http.put(url, body: body);
    return responce;
  }

  Future<dynamic> editprofile(UserModel userModel) async {
    final Uri url = Uri.parse(
        ApiUrl().API_URL + "user/" + userModel.id.toString() + ".json");
    var body = json.encode(userModel.toJson());
    var responce = await http.put(url, body: body);
    return responce;
  }

  Future<void> updateChapview(
      String comicID, int chapIndex, int newView) async {
    final Uri url = Uri.parse(ApiUrl().API_URL +
        'comic/' +
        comicID +
        "/chap/" +
        chapIndex.toString() +
        ".json");
    var body = json.encode({'chapView': newView});
    await http.patch(url, body: body);
  }
}
