import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  Future<List<String>> getImageFoleder(String url) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    List<String> string = [];
    final storageReference = storage.ref().child(url);
    firebase_storage.ListResult result = await storageReference.listAll();
    for (var itemRef in result.items) {
      string.add(await itemRef.getDownloadURL());
    }

    return string;
  }
}
