import 'package:comic_app/models/comment_model.dart';
import 'package:comic_app/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailComic extends StatelessWidget {
  final String decription;
  final List<CommentModel> comments;
  const DetailComic(
      {Key? key, required this.decription, required this.comments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đang cập nhật',
                  style: Mytheme.textLogin,
                ),
                Row(
                  children: const [
                    Text('⭐️⭐️⭐️⭐️⭐️'),
                    Icon(
                      CupertinoIcons.pencil,
                      size: 20,
                    )
                  ],
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
            Text(
              'Comment',
              textAlign: TextAlign.left,
              style: Mytheme.textLogin,
            ),
            (comments.isEmpty)
                ? const Center(
                    child: Text(
                    'Chưa có bình luận',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ))
                : const Text('Co binh luan roi'),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          const EdgeInsets.only(bottom: 5, left: 15),
                      hintText: 'Viết bình luận ....',
                      suffixIcon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
