class CommentModel {
  String? id;
  String? userID;
  String? content;
  String? updateDay;
  CommentModel({this.id, this.content, this.userID, this.updateDay});
  factory CommentModel.fromJson(Map<String, dynamic> map) {
    return CommentModel(
        id: map['id'],
        content: map['content'],
        userID: map['userID'],
        updateDay: map['updateDay']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'userID': userID,
      'updateDay': updateDay
    };
  }
}
