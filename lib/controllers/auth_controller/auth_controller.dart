import 'dart:convert';
import 'package:comic_app/main.dart';
import 'package:comic_app/models/user.dart';
import 'package:comic_app/services/api_service.dart';
import 'package:comic_app/services/api_url.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;

  var isAuth = false.obs;
  var listOfAllUser = List<UserModel>.empty(growable: true).obs;
  var userModel = UserModel().obs;
  @override
  void onInit() {
    checkLogin();
    loadAllUser();
    super.onInit();
  }

  Future<void> checkLogin() async {
    if (_auth.currentUser != null) {
      isAuth(true);
      userModel.value = await ApiService().fetchUser(_auth.currentUser!.uid);
      update();
    }
  }

  UserModel getUserbyID(String id) {
    return listOfAllUser.firstWhere((element) => element.id == id);
  }

  Future<void> loadAllUser() async {
    List<UserModel> list = await ApiService().fetchAllUser();
    listOfAllUser.assignAll(list);
    update();
  }

  void addFavorite(String comicID) {
    userModel.value.favoriteComic!.add(comicID);
    update();
  }

  void removeFavorite(String comicID) {
    userModel.value.favoriteComic!.remove(comicID);
    update();
  }

  Future<void> signUp(
    GlobalKey<FormState> formKey,
    String email,
    String password,
    String username,
  ) async {
    if (formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postDetailToFirestore(username);
        isAuth(true);
      }).catchError((onError) {
        Get.snackbar("Error", onError.toString());
      });
    }
  }

  Future<void> signIn(
      GlobalKey<FormState> formKey, String email, String password) async {
    if (formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) {
        isAuth(true);
        update();
      }).catchError((e) {
        Get.snackbar('Error', e.toString());
      });
    }
  }

  Future<void> postDetailToFirestore(String userName) async {
    User? user = _auth.currentUser;
    UserModel userModel = UserModel(
        id: user!.uid,
        userName: userName,
        email: user.email.toString(),
        avatarURl:
            "https://scontent.fhan3-5.fna.fbcdn.net/v/t39.30808-6/263674497_1588136888200388_6965760474362487225_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=MARP4voYV5sAX_TQZgy&tn=Z2sltfH5ZjBRjBWV&_nc_ht=scontent.fhan3-5.fna&oh=00_AT8n-njiAA6LWjbUl3tl9-BGmzUICpK1Ru94yXwrVHHc7w&oe=621F4C0F");
    final Uri url = Uri.parse(ApiUrl().API_URL + "user/" + user.uid + ".json");
    var body = json.encode(userModel.toJson());

    var responce = await http.patch(url, body: body);
    if (responce.statusCode == 200) {
      Get.snackbar('Thông báo', 'Đăng kí thành công');
      isAuth(true);
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(Routes.root);
      });
    } else {
      Get.snackbar('Thông báo', 'Đăng kí thất bại');
      return;
    }
  }

  Future<void> logout() async {
    _auth.signOut();
    isAuth(false);
    update();
  }
}
