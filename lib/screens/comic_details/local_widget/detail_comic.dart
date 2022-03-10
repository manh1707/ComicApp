import 'dart:math';

import 'package:comic_app/controllers/auth_controller/auth_controller.dart';
import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/models/comic_model.dart';
import 'package:comic_app/models/comment_model.dart';
import 'package:comic_app/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'components/list_of_comment.dart';
import 'components/rating_star.dart';

class DetailComic extends StatelessWidget {
  final String decription;
  final List<CommentModel> comments;
  final String id;
  final ComicModel comicModel;
  const DetailComic(
      {Key? key,
      required this.decription,
      required this.comments,
      required this.comicModel,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authcontroller = Get.find();
    ComicController comicController = Get.find();
    final String comicID = id;
    final String? userID = authcontroller.currentUser.value.id;

    TextEditingController commentEditing = TextEditingController();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Đang cập nhật',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700),
                ),
                (authcontroller.isAuth.isFalse)
                    ? InkWell(
                        onTap: () {
                          Get.snackbar(
                              "Thông báo ", 'Vui lòng đăng nhập để theo dõi',
                              backgroundColor: Colors.white,
                              colorText: Colors.red);
                        },
                        child: Row(
                          children: [
                            Text('Follow',
                                style: Mytheme.textLogin.copyWith(
                                  color: Colors.grey,
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.add,
                              color: Colors.grey,
                              size: 14,
                            )
                          ],
                        ),
                      )
                    : GetBuilder<AuthController>(
                        builder: (controller) {
                          bool isFavorite =
                              controller.currentUser.value.isFavorite(comicID);

                          return InkWell(
                            onTap: () {
                              if (isFavorite == true) {
                                controller.removeFavorite(
                                    comicID,
                                    controller.currentUser.value.favoriteComic,
                                    userID!);
                              } else {
                                controller.addFavorite(
                                    comicID,
                                    controller.currentUser.value.favoriteComic,
                                    userID!);
                              }
                            },
                            child: isFavorite == false
                                ? Row(
                                    children: [
                                      Text('Follow',
                                          style: Mytheme.textLogin.copyWith(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                        size: 14,
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Text('Following',
                                          style: Mytheme.textLogin.copyWith(
                                            color: Colors.red,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                          );
                        },
                      )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              decription,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<ComicController>(
                  builder: (controller) => Text(
                    'Comment (${controller.findComicByID(comicID).comments.length})',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          true, // set to false if you want to force a rating
                      builder: (context) => RatingDialog(
                        initialRating: 1.0,
                        title: Text(
                          'Đánh giá truyện',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        enableComment: false,
                        message: Text(
                          'Chọn mức sao mà bạn muốn cho sự hài lòng của bạn',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                        submitButtonText: 'Xác nhận',
                        onSubmitted: (response) {
                          comicController.ratingComic(
                              comicModel, response.rating);
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      GetBuilder<ComicController>(builder: (controller) {
                        return (controller
                                .findComicByID(comicModel.id)
                                .rating
                                .isEmpty)
                            ? Text('Chưa có đánh giá')
                            : RatingStars(controller
                                    .findComicByID(comicModel.id)
                                    .ratingStar /
                                controller
                                    .findComicByID(comicModel.id)
                                    .rating
                                    .length);
                      }),
                      Icon(
                        CupertinoIcons.pencil,
                        size: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
            GetBuilder<ComicController>(
                builder: (controller) => (comicController
                        .findComicByID(comicID)
                        .comments
                        .isEmpty)
                    ? const Center(
                        child: Text(
                        'Chưa có bình luận',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ))
                    : ListOfComment(
                        commentList:
                            comicController.findComicByID(comicID).comments)),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: commentEditing,
              onSubmitted: (comment) {
                if (authcontroller.isAuth.isFalse) {
                  Get.snackbar("Thông báo ", 'Vui lòng đăng nhập để bình luận',
                      backgroundColor: Colors.white, colorText: Colors.red);
                } else {
                  CommentModel commentModel = CommentModel(
                      id: DateTime.now().toIso8601String(),
                      content: commentEditing.text,
                      userID: userID,
                      updateDay: DateFormat("dd-MM-yyyy")
                          .format(DateTime.now())
                          .toString());
                  comicController.addComment(comicModel, commentModel);
                  commentEditing.clear();
                }
              },
              decoration: InputDecoration(
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.only(bottom: 5, left: 15),
                hintText: 'Viết bình luận ....',
                suffixIcon: const Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
