import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  Future<String> uploadImage(image, filename, folder) async {
    var storageReference =
        FirebaseStorage.instance.ref().child(folder).child(filename);
    var uploadTask = await storageReference.putFile(image);
    // ignore: await_only_futures
    var urlf = await uploadTask.ref.getDownloadURL();
    String url = urlf.toString();
    return url;
  }
}
