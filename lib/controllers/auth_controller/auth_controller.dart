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
        checkLogin();
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
    userModel.value = UserModel(
        id: user!.uid,
        userName: userName,
        email: user.email.toString(),
        avatarURl:
            "https://firebasestorage.googleapis.com/v0/b/comic-app-d5041.appspot.com/o/UserImage%2Favatar.png?alt=media&token=19a44c95-c3e6-412c-82be-41b074ef40bd");
    final Uri url = Uri.parse(ApiUrl().API_URL + "user/" + user.uid + ".json");
    var body = json.encode(userModel.toJson());
    var responce = await http.patch(url, body: body);
    if (responce.statusCode == 200) {
      Get.snackbar('Thông báo', 'Đăng kí thành công');

      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(Routes.root);
      });
    } else {
      Get.snackbar('Thông báo', 'Đăng kí thất bại');
      return;
    }
    update();
  }

  Future<void> logout() async {
    _auth.signOut();
    isAuth(false);
    update();
  }
}
