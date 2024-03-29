class ChapModel {
  String? id;
  String? title;
  List<String> chapImageUrl;
  int chapView;
  String? upDateDay;
  ChapModel(
      {this.id,
      this.title,
      required this.chapView,
      required this.chapImageUrl,
      this.upDateDay});
  factory ChapModel.fromJson(Map<String, dynamic> map) {
    return ChapModel(
        id: map['title'],
        title: map['title'],
        chapView: map['chapView'] ?? 0,
        chapImageUrl: List<String>.from(map['chapImageURL'].map((x) => x)),
        upDateDay: map['updateDay']);

    // chapView: map['chapView']);)

    // upDateDay = map['updateDay'];)
  }
  void increChapView() {
    chapView++;
  }
}
