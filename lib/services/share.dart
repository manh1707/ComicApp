import 'package:shared_preferences/shared_preferences.dart';

class History {
  Future<int?> getHistory(String comicID) async {
    SharedPreferences _pres = await SharedPreferences.getInstance();
    int? count = _pres.getInt(comicID);
    return count;
  }

  Future<int?> saveHistory(String comicID, int chapIndex) async {
    SharedPreferences _pres = await SharedPreferences.getInstance();
    await _pres.setInt(comicID, chapIndex);
  }
}
