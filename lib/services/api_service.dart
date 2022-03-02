import 'dart:convert';
import 'package:comic_app/models/comic_model.dart';
import 'package:comic_app/models/comment_model.dart';
import 'package:comic_app/models/user.dart';
import 'package:comic_app/services/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ComicModel>> fetchComic() async {
    final List<ComicModel> lists = [];
    final response = await http.get(ApiUrl().COMIC_LIST_URL);
    if (response.statusCode == 200) {
      final extraData = json.decode(response.body) as Map<String, dynamic>;
      extraData.forEach((id, data) {
        lists.add(ComicModel.fromJson(id, data));
      });
    } else {
      Get.snackbar('Error', 'Có lỗi xảy ra');
    }
    return lists;
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

  Future<void> postCommnent(
      List<CommentModel> commentModel, String comicId) async {
    final Uri url = Uri.parse(ApiUrl().comicCommentURl(comicId));
    var body =
        json.encode(List<dynamic>.from(commentModel.map((e) => e.toJson())));
    var response = await http.put(url, body: body);
    if (response.statusCode == 200) {
      Get.snackbar('Thong bao', 'Thêm comment thành công');
    } else {
      Get.snackbar('Error', "Co loi xay ra");
    }
  }

  Future<void> addFavoriteComic(
      List<String>? favoriteList, String userID, String content) async {
    final Uri url = Uri.parse(ApiUrl().favoriteList(userID));
    var body = json.encode(List<dynamic>.from(favoriteList!.map((e) => e)));
    var response = await http.put(url, body: body);
    if (response.statusCode == 200) {
      Get.snackbar('Thông báo', content);
    } else {
      Get.snackbar('Error', "Co loi xay ra");
    }
  }
}
