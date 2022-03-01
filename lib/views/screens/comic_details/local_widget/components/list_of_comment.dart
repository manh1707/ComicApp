import 'package:comic_app/controllers/auth_controller/auth_controller.dart';
import 'package:comic_app/models/comment_model.dart';
import 'package:comic_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfComment extends StatelessWidget {
  ListOfComment({Key? key, required this.commentList}) : super(key: key);
  List<CommentModel> commentList;
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          UserModel userModel =
              authController.getUserbyID(commentList[index].userID.toString());
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(userModel.avatarURl.toString()),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          userModel.userName.toString(),
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Container(
                          height: 15,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'VIP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          commentList[index].updateDay.toString(),
                          style: const TextStyle(
                            color: Colors.black26,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      commentList[index].content.toString(),
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: commentList.length);
  }
}
