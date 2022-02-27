class ApiUrl {
  final String API_URL =
      "https://comic-app-d5041-default-rtdb.asia-southeast1.firebasedatabase.app/";

  final Uri COMIC_LIST_URL = Uri.parse(
      "https://comic-app-d5041-default-rtdb.asia-southeast1.firebasedatabase.app/comic.json");
  final Uri USER_URL_list = Uri.parse(
      "https://comic-app-d5041-default-rtdb.asia-southeast1.firebasedatabase.app/user.json");

  String userURl(String id) {
    return "https://comic-app-d5041-default-rtdb.asia-southeast1.firebasedatabase.app/user/$id.json";
  }

  String comicCommentURl(String idComic) {
    return "https://comic-app-d5041-default-rtdb.asia-southeast1.firebasedatabase.app/comic/$idComic/comment.json";
  }
}
