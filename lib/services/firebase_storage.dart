import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  Future<String> uploadImage(String userID, File? file) async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("UserImage/${userID}")
        .child('post_$postID');
    await ref.putFile(file!);
    String dowloadURl = await ref.getDownloadURL();
    return dowloadURl;
  }
}
