class UserModel {
  String? id;
  String? userName;
  String? email;
  String? avatarURl;
  List<String>? favoriteComic;
  UserModel(
      {this.id, this.userName, this.email, this.avatarURl, this.favoriteComic});
  factory UserModel.fromJson(String id, Map<String, dynamic> map) {
    return UserModel(
        id: id,
        userName: map['userName'],
        avatarURl: map['avatarURL'],
        email: map['email'],
        favoriteComic: (map['favoriteComic'] == null)
            ? []
            : List<String>.from(map['favoriteComic'].map((x) => x)));
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'avatarURL': avatarURl,
      'email': email,
      'favoriteComic': []
    };
  }

  bool isFavorite(String id) {
    return favoriteComic!.contains(id);
  }
}
