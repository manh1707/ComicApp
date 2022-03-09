import 'package:comic_app/main.dart';
import 'package:comic_app/models/user.dart';
import 'package:comic_app/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;

  var isAuth = false.obs;
  var listOfAllUser = List<UserModel>.empty(growable: true).obs;
  var currentUser = UserModel().obs;
  @override
  void onInit() {
    checkLogin();
    loadAllUser();
    super.onInit();
  }

  Future<void> checkLogin() async {
    if (_auth.currentUser != null) {
      isAuth(true);
      currentUser.value = await ApiService().fetchUser(_auth.currentUser!.uid);
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

  Future<void> addFavorite(
      String comicID, List<String>? favoriteList, String userID) async {
    currentUser.value.favoriteComic!.add(comicID);
    var response = await ApiService().addFavoriteComic(
      favoriteList,
      userID,
    );
    if (response.statusCode == 200) {
      Get.snackbar('Thông báo', "Đã thêm vào danh sách theo dõi");
    } else {
      Get.snackbar('Error', "Co loi xay ra");
    }
    update();
  }

  void removeFavorite(
      String comicID, List<String>? favoriteList, String userID) async {
    currentUser.value.favoriteComic!.remove(comicID);
    var response = await ApiService().addFavoriteComic(
      favoriteList,
      userID,
    );
    if (response.statusCode == 200) {
      Get.snackbar('Thông báo', "Bỏ theo dõi truyện");
    } else {
      Get.snackbar('Error', "Co loi xay ra");
    }
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
          .then((value) async {
        User? user = _auth.currentUser;
        UserModel userModel = UserModel(
            id: user!.uid,
            userName: username,
            email: user.email.toString(),
            avatarURl:
                "https://firebasestorage.googleapis.com/v0/b/comic-app-d5041.appspot.com/o/UserImage%2Favatar.png?alt=media&token=19a44c95-c3e6-412c-82be-41b074ef40bd");
        var response =
            await ApiService().postDetailToFirestore(userModel, user.uid);
        if (response.statusCode == 200) {
          Future.delayed(const Duration(seconds: 1), () {
            checkLogin();
            Get.offAllNamed(Routes.root);
          });
        } else {
          Get.snackbar('Thông báo', 'Đăng kí thất bại');
          return;
        }
      }).catchError((onError) {
        if (onError.toString().contains('already-in-use')) {
          Get.snackbar("Thông báo", 'Email này đã được đăng kí');
        } else {
          Get.snackbar("Thông báo", onError.toString());
        }
      });
    }
  }

  Future<void> signIn(
      GlobalKey<FormState> formKey, String email, String password) async {
    if (formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) {
        if (uid.user != null) {
          Future.delayed(const Duration(seconds: 1), () {
            Get.snackbar('Thông báo', 'Đăng Nhập thành công');
          });

          Get.offAllNamed(Routes.root);
          isAuth(true);
          update();
        }
      }).catchError((e) {
        if (e.toString().contains('user-not-found')) {
          Get.snackbar('Lỗi', 'Email này chưa được đăng kí');
        } else {
          Get.snackbar('Lỗi', "Mật khẩu không chính xác ");
          print(e.toString());
        }
      });
    }
  }

  Future<void> logout() async {
    _auth.signOut();
    isAuth(false);
    update();
  }
}
