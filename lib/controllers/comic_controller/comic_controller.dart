import 'package:comic_app/services/api_service.dart';
import 'package:get/get.dart';

import '../../models/comic_model.dart';

class ComicController extends GetxController {
  var isLoading = true.obs;
  var comicList = List<ComicModel>.empty(growable: true).obs;
  @override
  void onInit() async {
    await fetchAllComic();
    super.onInit();
  }

  List<ComicModel> findByName(String name) {
    return comicList.where((x) => x.name.contains(name)).toList();
  }

  ComicModel findByID(String id) {
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
