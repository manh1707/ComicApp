import 'dart:convert';

import 'package:comic_app/models/comment_model.dart';
import 'package:comic_app/services/api_service.dart';
import 'package:comic_app/services/share.dart';
import 'package:get/get.dart';
import '../../models/comic_model.dart';
import '../../services/share.dart';

class ComicController extends GetxController {
  var isLoading = true.obs;
  var comicList = List<ComicModel>.empty(growable: true).obs;
  var historyComic = List<ComicModel>.empty(growable: true).obs;
  var chapHistory = List<int>.empty(growable: true).obs;
  var chapSearch = List<ComicModel>.empty(growable: true).obs;
  @override
  void onInit() async {
    await fetchAllComic();
    await fetchHistory();
    super.onInit();
  }

  Future<void> fetchHistory() async {
    comicList.forEach((element) async {
      var getHistory = await History().getHistory(element.id);

      if (getHistory != null) {
        historyComic.add(element);
        chapHistory.add(getHistory);
        update();
      }
    });
  }

  Future<void> addComment(
      ComicModel comicModel, CommentModel commentModel) async {
    var response =
        await ApiService().postCommnent(comicModel.comments, comicModel.id);
    if (response.statusCode == 200) {
      comicModel.comments.add(commentModel);
      update();
    } else {
      Get.snackbar('Error', 'Có lỗi xảy ra');
    }
  }

  Future<void> addToHistory(ComicModel comicModel, chapindex) async {
    var getHistory = await History().getHistory(comicModel.id);
    if (getHistory != null) {
      int index =
          historyComic.indexWhere((element) => element.id == comicModel.id);
      chapHistory.removeAt(index);
      historyComic.removeWhere((element) => element.id == comicModel.id);
      History().saveHistory(comicModel.id, chapindex);
      chapHistory.add(chapindex);
      historyComic.add(comicModel);
    } else {
      History().saveHistory(comicModel.id, chapindex);
      chapHistory.add(chapindex);
      historyComic.add(comicModel);
    }
    update();
  }

  void findByName(String name) {
    chapSearch.value =
        comicList.where((x) => x.name.toLowerCase().contains(name)).toList();
    update();
  }

  ComicModel findComicByID(String id) {
    return comicList.firstWhere((element) => element.id == id);
  }

  Future<void> updateChapView(ComicModel comicModel, int chapIndex) async {
    int index = comicList.indexWhere((element) => element.id == comicModel.id);
    comicList[index].chaps[chapIndex].increChapView();

    ApiService().updateChapview(
        comicModel.id, chapIndex, comicList[index].chaps[chapIndex].chapView);
    update();
  }

  Future<void> ratingComic(ComicModel comicModel, double rating) async {
    int index = comicList.indexWhere((element) => element.id == comicModel.id);
    comicList[index].rating.add(rating);
    var response = await ApiService().AddRating(comicModel);
    if (response.statusCode == 200) {
      Get.snackbar('Thông báo', 'Thêm đánh giá thành công');
    } else {
      Get.snackbar('Thông báo', 'Thêm đánh giá thất bại');
    }
    update();
  }

  Future<void> fetchAllComic() async {
    try {
      isLoading(true);
      var response = await ApiService().fetchComic();

      if (response.statusCode == 200) {
        final extraData = json.decode(response.body) as Map<String, dynamic>;
        extraData.forEach((id, data) {
          comicList.add(ComicModel.fromJson(id, data));
          update();
        });
      } else {
        Get.snackbar('Error', 'Lỗi kêt nói tới sever');
      }
    } finally {
      isLoading(false);
    }
  }
}
