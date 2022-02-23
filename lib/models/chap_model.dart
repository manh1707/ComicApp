class ChapModel {
  String? id;
  String? title;
  // List<String>? chapImageUrl;
  int? chapView;
  // DateTime? upDateDay;
  ChapModel({this.id, this.title, this.chapView});
  factory ChapModel.fromJson(Map<String, dynamic> map) {
    return ChapModel(title: map['title'], chapView: map['chapView']);

    // chapImageUrl: map['chapImageUrl'],
    // chapView: map['chapView']);)

    // upDateDay = map['updateDay'];)
  }
}
