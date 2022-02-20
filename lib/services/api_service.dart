import 'dart:convert';
import 'package:comic_app/models/comic_model.dart';
import 'package:comic_app/services/api_url.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ComicModel>> fetchComic() async {
    final List<ComicModel> lists = [];
    final response = await http.get(ApiUrl().COMIC_LIST_URL);
    if (response.statusCode == 200) {
      final extraData = json.decode(response.body) as Map<String, dynamic>;
      extraData.forEach((id, data) {
        lists.add(ComicModel.fromJson(data));
      });
    } else {
      print('Loi ket noi api');
    }
    return lists;
  }
}
