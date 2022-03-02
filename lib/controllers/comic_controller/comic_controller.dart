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

  List<ComicModel> findByName(String name) {
    return comicList.where((x) => x.name.contains(name)).toList();
  }

  ComicModel findComicByID(String id) {
    return comicList.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAllComic() async {
    try {
      isLoading(true);
      List<ComicModel> lists = await ApiService().fetchComic();
      comicList.assignAll(lists);
      update();
    } finally {
      isLoading(false);
    }
  }
}
